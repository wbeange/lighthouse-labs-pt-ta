class Person
    attr_reader :first_name, :last_name, :gender

    def initialize(first_name, last_name, gender="male")
        @first_name = first_name
        @last_name = last_name
        @gender = gender
    end

    def fullname
      "#{first_name} #{last_name}"
    end
end

class Doctor < Person
  def fullname
    "Dr. #{first_name} #{last_name}"
  end
end

class Lawyer < Person
  def fullname
    "#{first_name} #{last_name}, Esq."
  end
end

joe = Person.new("joe", "smo", "male")
p joe.fullname

joe_doctor = Doctor.new("joe", "smo")
p joe_doctor.fullname

joe_lawyer = Lawyer.new("joe", "smo")
p joe_lawyer.fullname
