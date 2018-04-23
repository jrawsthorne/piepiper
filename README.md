# Team 10

## Usage

```
git clone https://github.com/COM1001-ComputerScience-Sheffield/team-10.git
cd team-10

If error occurs with bcrypt:
gem uninstall bcrypt
gem install bcrypt --platform=ruby

bundle
bundle exec rake

rackup -p 4567
```

```
to make a new migration command is:
	rake db:create_migration NAME=<file name>

```