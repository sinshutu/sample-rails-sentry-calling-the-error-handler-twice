# README

## Require
* docker
* docker-compose

## Run
```bash
$ ./setup.sh
...
ApplicationJob
  error handling and retries
    Exceptions
      when StandardError
        behaves like executed retry
          is expected to have received run(*(any args)) 0 times
    RETRY_LIMIT
      when max
        behaves like executed retry
          is expected to have received run(*(any args)) 0 times
      when over
        is expected to have received run(*(any args)) 1 time (FAILED - 1)

Failures:

  1) ApplicationJob error handling and retries RETRY_LIMIT when over is expected to have received run(*(any args)) 1 time
     Failure/Error: expect(ErrorHandling).to have_received(:run).once

       (ErrorHandling (class)).run(*(any args))
           expected: 1 time with any arguments
           received: 2 times with any arguments
     # ./spec/jobs/application_job_spec.rb:65:in `block (5 levels) in <top (required)>'

Finished in 0.05368 seconds (files took 0.84601 seconds to load)
3 examples, 1 failure

Failed examples:

rspec ./spec/jobs/application_job_spec.rb:62 # ApplicationJob error handling and retries RETRY_LIMIT when over is expected to have received run(*(any args)) 1 time
```
