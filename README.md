# API Rescuable

[![Build Status](https://travis-ci.org/tejasbubane/api_rescuable.svg?branch=master)](https://travis-ci.org/tejasbubane/api_rescuable)

Quick and easy way to handle common exceptions in Rails APIs.

With Rails APIs you generally want to handle the most common exceptions and give proper errors to your users.
This gem gives you a one-liner to put in your top-level API controller.

#### Installation:

Add the gem to your gemfile:

```ruby
gem "api_rescuable"
```

And run `bundle install`.

Then add this to your top-level API controller:

```ruby
class ApiController < ApplicationController
  include ApiRescuable

  rescue_from_api ActiveRecord::RecordNotFound,
                  ActiveRecord::RecordInvalid,
                  ActiveModel::ForbiddenAttributesError,
                  ActionController::ParameterMissing,
                  CanCan::AccessDenied

  .....

end
```

For API-only apps this will be `ApplicationController`, for others create a
separate `ApiController` and let all APIs-related controllers inherit from this.

Handles these five exceptions gracefully for you:

* `ActiveRecord::RecordNotFound`

* `ActiveRecord::RecordInvalid`

* `ActiveModel::ForbiddenAttributesError`

* `ActionController::ParameterMissing`

* `CanCan::AccessDenied`


It essentially turns [this](https://github.com/tejasbubane/api_rescuable/blob/master/example_controller.rb)
into a one-liner.


* This gem adds [rescue_from](http://apidock.com/rails/ActiveSupport/Rescuable/ClassMethods/rescue_from)
  to the class that includes `ApiRescuable`.
  Hence it is supposed to be used in Rails controllers only.

* In case you want finer control over the status codes and/or json being sent,
  please use the [example](https://github.com/tejasbubane/api_rescuable/blob/master/example_controller.rb)
  and add your own handlers.

* Keep in mind that this gem will add `handle_*` methods to your controller
  corresponding to the exceptions being handled.
