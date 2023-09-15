VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

def is_valid_email? email
  email =~ VALID_EMAIL_REGEX
end

p is_valid_email?("gandhali@test.com") ? "Valid" : "Invalid"
p is_valid_email?("gandhali_k@test.com") ? "Valid" : "Invalid"
p is_valid_email?("gandhalitest@com") ? "Valid" : "Invalid"
