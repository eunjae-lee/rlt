# rlt

Start using Git on command line again with `rlt`.

## Installation

    $ gem install rlt

`rlt` wraps all the native commands from git. So you can make an alias like the following:

```bash
$ echo "alias git='rlt'" >> ~/.bash_profile
$ source ~/.bash_profile
```

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

Just hit enter to skip if there's nothing to write down as body.

If you pass a parameter `-a`, it will `git add -A` before committing.

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
When your work is done enough and you're ready to merge it to `master`,
type the following:

```bash
$ git close
```

then, it will

1. Merge from `master` into `feature-abc`
2. Abort if there's any conflict
3. Switch to `master`
4. Merge from `feature-abc` into `master`
5. Delete `feature-abc`
6. Try to delete remote `feature-abc`

Make sure there's no uncommitted changes in current branch before this command.
Otherwise, it will abort.

## Configuration

Everything works fine without any configuration.

However, the great power comes with a configuration, using ERB syntax in YAML.

You can have a global config at `~/.rlt.yml`. You also can put project-specific config file at root of your project.

`rlt` will merge those two configs.

### alias
You can put any alias as you want.
```yaml
alias:
  cmt: cmt -a
  l: log --oneline
```

This way, you can always put `-a` option as default.
You could also make aliases for native commands like `log` from git.

### `close`
If you're using `develop` or other name for active development, do things like this:
```yaml
command:
  close:
    default_branch: develop
```

### `switch`

```yaml
command:
  switch:
    branch_name_template: feature-<%= branch_name %>
```
When you type `rlt switch login`, then it will automatically switch to a branch named `feature-login`.
* Variable available for `branch_name_template` is `branch_name`.

### `cmt`

#### Template

Here goes an example which might look complicated but actually it isn't.

```yaml
command:
  cmt:
    subject_template: >
      <%=
        result = branch_name.match(/^JIRA-(\d+)-(.*)/)
        if result
          "[JIRA-#{result[1]}] #{subject}"
        else
          subject
        end
      %>
    body_template: >
      <%=
        result = branch_name.match(/^JIRA-(\d+)-(.*)/)
        if result
          "https://my-jira.atlassian.net/browse/JIRA-#{result[1]}\n\n#{body}"
        else
          body
        end
      %>
```

Let's say you're in a branch named `JIRA-342-fix-login` and you made a commit like the following:

```bash
$ git cmt
Committing to 'JIRA-342-fix-login'

Subject: Fix a bug where user cannot login
Body:
> There was a problem at ......
>
```

Then `rlt` will automatically change the subject and body, so the actual commit message will be:

```bash
$ git log

commit c333021cidkc5f0117bdbf5ffdlwf5add7293b27
Author: Eunjae Lee <karis612@gmail.com>
Date:   Fri May 11 18:28:44 2018 +0800

    [JIRA-342] Fix a bug where user cannot login

    https://my-jira.atlassian.net/browse/JIRA-342

    There was a problem at ......
```

* Variables available for `subject_template` are `branch_name` and `subject`.
* Variables available for `body_template` are `branch_name` and `body`.

#### pre-script

You can also put `pre-script` to `cmt` command.

```yaml
command:
  cmt:
    pre: rubocop --auto-correct
```

`rlt` will execute `rubocop --auto-correct` and if it returns non-zero status, it will abort.

## TODO

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
