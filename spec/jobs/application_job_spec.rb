# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationJob, type: :job do
  let(:company) { create(:company) }

  before do
    ActiveJob::Base.queue_adapter = :test
  end

  describe 'error handling and retries' do
    subject(:invoke) { AnonymousJob.perform_now }

    let(:instance) { AnonymousJob.new }

    before do
      allow(AnonymousJob).to receive(:new).and_return(instance)
      allow(instance).to receive(:retry_job)
      allow(ErrorHandling).to receive(:run).with(StandardError)
    end

    shared_examples 'executed retry' do
      it do
        invoke
        expect(instance).to have_received(:retry_job).once
        expect(ErrorHandling).to have_received(:run).exactly(0).times
      end
    end

    context 'Exceptions' do
      context 'when StandardError' do
        before do
          allow(AnonymousJob).to receive(:return_error).and_return(StandardError)
        end

        it_behaves_like 'executed retry'
      end
    end

    context 'RETRY_LIMIT' do
      let(:limit) { 3 }

      before do
        stub_const('ApplicationJob::RETRY_LIMIT', limit)
        allow(AnonymousJob).to receive(:return_error).and_return(StandardError)
      end

      context 'when max' do
        before do
          allow(instance).to receive(:executions).and_return(limit)
        end

        it_behaves_like 'executed retry'
      end

      context 'when over' do
        before do
          allow(instance).to receive(:executions).and_return(limit + 1)
        end

        it do
          expect { invoke }.to raise_error(StandardError)
          expect(instance).to have_received(:retry_job).exactly(0).times
          expect(ErrorHandling).to have_received(:run).once
        end
      end
    end
  end
end
