defmodule Revolution.Match do
  def get_cards() do
    %{
      "1": ["Che Guevara", 146, 351],
      "2": ["1928–1967", 438, 54],
      "3": ["Fidel Castro", 140, 299],
      "4": ["1926-2016", 457, 244],
      "5": ["Vladimir Lenin", 140, 254],
      "6": ["1870-1924", 442, 125],
      "7": ["Mahatma Gandhi", 138, 204],
      "8": ["1869–1948", 438, 88],
      "9": ["Karl Marx", 137, 161],
      "10": ["1818–1883", 446, 202],
      "11": ["Thomas Paine", 131, 111],
      "12": ["1737–1809", 446, 325],
      "13": ["Ahmed Ben Bella", 131, 59],
      "14": ["1916–2012", 456, 275],
      "15": ["Francisco I. Madero", 146, 383],
      "16": ["1873–1913", 443, 162]
    }
  end

  def check_pair(x, y) when is_binary(x) and is_binary(y) do
    check_pair(String.to_integer(x), String.to_integer(y))
  end

  def check_pair(x, y) when is_integer(x) and is_integer(y) do
    case submit_match(x, y) || submit_match(y, x) do
      true -> :match
      false -> :no_match
    end
  end

  def submit_match(1, 2), do: true
  def submit_match(3, 4), do: true
  def submit_match(5, 6), do: true
  def submit_match(7, 8), do: true
  def submit_match(9, 10), do: true
  def submit_match(11, 12), do: true
  def submit_match(13, 14), do: true
  def submit_match(15, 16), do: true
  def submit_match(_, _), do: false
end
