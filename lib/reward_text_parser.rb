class RewardTextParser

  def self.import(file_path)
    begin
      text = File.read(file_path)
      operations = text.split("\n")
      errors = []
      sorted_actions = []
      operations.each do |operation|
        line_arr = operation.split(" ", 3)
        datetime = line_arr[0] + ' ' + line_arr[1]
        action_str = line_arr[2]
        parsed_datetime = DateTime.parse(datetime)
        if action_str.include? " recommends "
          action_arr = action_str.split(" recommends ")
          sorted_actions << {datetime: parsed_datetime, action: 'invite', from_user: action_arr[0], to_user: action_arr[1]}
        elsif action_str.include? "accepts"
          action_arr = action_str.split(' accepts')
          sorted_actions << {datetime: parsed_datetime, action: 'accepts', from_user: action_arr[0]}
        else
          errors << "Error parsing file, make sure info is correct"
          break
        end
      end
    rescue => e
      errors << "Error parsing file, make sure info is correct"
    end
    if errors.present?
      return {errors: errors}
    else
      return {data: (sorted_actions.sort_by! { |k| k[:datetime] })}
    end
  end

end