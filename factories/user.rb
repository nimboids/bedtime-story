Factory.sequence :login do |n|
  "user#{'%03i' % n}"
end

Factory.define :user do |user|
  user.login {Factory.next :login}
  user.email {|u| "#{u.login}@example.com"}
  user.password 'top_secret'
  user.password_confirmation {|u| u.password}
end
