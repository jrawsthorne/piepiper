# Team 10

## Usage

```bash
git clone https://github.com/COM1001-ComputerScience-Sheffield/team-10.git
cd team-10
```
If error occurs with bcrypt:
```bash
gem uninstall bcrypt
gem install bcrypt --platform=ruby
```

Development
```bash
bundle exec rake
rackup -p 4567
```

Deploy
```bash
bundle exec rake deploy
```

## Testing

Minitest
```bash
bundle exec rake test
```
Cucumber
```bash
bundle exec rake test:features
```
