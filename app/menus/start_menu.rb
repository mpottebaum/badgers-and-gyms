def start_menu
    prompt = prompt_instance
    user_input = prompt.select("Welcome to Badgers and Gyms", ["Start", "How to play", "Exit"])
    case user_input
    when "Start"
    when "How to play"
    when "Exit"
    end
end