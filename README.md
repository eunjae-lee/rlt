# rlt

Start using Git on command line again with `rlt`.

`rlt` is a git wrapper with convenient methods included.

## Installation

    $ gem install rlt

`rlt` wraps all the native commands of git. So you can make the alias like the following:

    $ echo "alias git='rlt'" >> ~/.bash_profile
    $ source ~/.bash_profile

## Commands

### `cmt`
```bash
$ git cmt
Committing to 'master'

Subject: Fix a bug where user cannot login
Body:
> There was a problem at ......
>
```

If there's nothing to put as body, you can just hit enter to skip it.

### `switch`
```bash
$ git switch <branch_name>
```

This will switch to `<branch_name>`. If the branch does not exist, then it will create it.

And it automatically stashes uncommitted changes(including untracked files) before switching to other branch.
After switching, it unstashes if there's any stash on that branch.

When coming back, it automatically applies and drops the previous stash.

### `close`

Let's say you're in a branch named `feature-abc`, and your master branch is `master`.
After finishing work on `feature-login`, if you type the following:

```bash
$ git close
```

then, these are what happens:

1. Merges from `master` into `feature-abc`
2. (Aborts if there are any conflicts)
3. Switches to `master`
4. Merges from `feature-abc` into `master`
5. Delete `feature-abc`
6. Try to delete remote `feature-abc`

It won't work if there's any uncommitted changes in current branch.

## Configuration

The great power in rlt comes from configuration, using ERB syntax in YAML.

```yaml
command:
  switch:
    branch_name_template: feature-<%= branch_name %>
  cmt:
    subject_template: My prefix <%= subject %>
    body_template: <%= body %> http://...
alias:
  br: branch
  sw: switch
  l: log --oneline
```

### `switch` with configuration
When you type `rlt switch login`, then it will automatically switch to a branch named `feature-login`.
* Variable available for `branch_name_template` is `branch_name`.

### `cmt` with configuration
When you `cmt` with subject 'Hello' and body 'World', then the commit message will be:

```
My prefix Hello

World http://...
```

* Variables available for `subject_template` are `branch_name` and `subject`.
* Variables available for `body_template` are `branch_name` and `body`.

### Alias
You can define alias as you want.

### A Complex Example
You can utilize this configuration as you want. Just for your information, you can do things like this:

```yaml
command:
  switch:
    branch_name_template: JIRA-<%= branch_name %>
  cmt:
    subject_template: >
      <%=
        if branch_name.start_with?('JIRA-')
          "[#{branch_name}] #{subject}"
        else
          subject
        end
      %>
    body_template: >
      <%=
        if branch_name.start_with?('JIRA-')
          "http://myjira.com/#{branch_name}\n\n#{body}"
        else
          body
        end
      %>
alias:
  br: branch
  sw: switch
  l: log --oneline
```

If you do `rlt switch 123`, then you'll be in `JIRA-123` branch.

As long as you're in that branch, when you `cmt` with subject 'Hello' and body 'World', then the commit message will be:

```
[JIRA-123] Hello

http://myjira.com/JIRA-123

World
```

This helps you construct commit message with a convention of yours.

## TODO

* `undo` : Uncommit latest commit
* any suggestion?

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eunjae-lee/rlt. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Please note that this project is released with a [CODE OF CONDUCT](CODE_OF_CONDUCT.md). By
participating in this project you agree to abide by its terms.

## Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

## License

Copyright 2018.
Read [LICENSE](LICENSE.md) for details.

## History

Read [CHANGES](CHANGES.md) for details.

## Credits

Developed by [Eunjae Lee](karis612@gmail.com).
