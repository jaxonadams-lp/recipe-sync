module Util
  def prepare_code_for_deployment(code)
    # search for an 'if __name__ == "__main__":' or 'if __name__ == '__main__':' and remove it and everything below it
    if code.include?("if __name__ == \"__main__\":") || code.include?("if __name__ == '__main__':")

      lines = code.lines
      lines.each_with_index do |line, index|
        if line.match(/if __name__ == ["']__main__["']:/)
          if index > 0 && lines[index - 1].strip.start_with?("#")
            lines = lines[0...index - 1]
          else
            lines = lines[0...index]
          end
          break
        end
      end

      code = lines.join
    end

    # remove any leading/trailing whitespace
    code.strip
  end
end
