# -*- encoding : utf-8 -*-
require 'nokogiri'
require 'open-uri'

namespace :opendata do

  task :commissions => :environment do
    commissions = [
      "Agricultura y Ganadería",
      "Asuntos Indígenas",
      "Atención a Grupos Vulnerables",
      "Ciencia y Tecnología",
      "Comunicaciones",
      "Cultura",
      "Defensa Nacional",
      "Derechos Humanos",
      "Desarrollo Rural",
      "Desarrollo Social",
      "Distrito Federal",
      "Economía",
      "Educación Pública y Servicios Educativos",
      "Energía",
      "Equidad y Género",
      "Función Pública",
      "Gobernación",
      "Hacienda y Crédito Público",
      "Justicia",
      "Juventud y Deporte",
      "Marina",
      "Medio Ambiente y Recursos Naturales",
      "Participación Ciudadana",
      "Población, Fronteras y Asuntos Migratorios",
      "Presupuesto y Cuenta Pública",
      "Puntos Constitucionales",
      "Radio, Televisión y Cinematografía",
      "Recursos Hidráulicos",
      "Reforma Agraria",
      "Régimen, Reglamentos y Prácticas Parlamentarias",
      "Relaciones Exteriores",
      "Salud",
      "Seguridad Pública",
      "Seguridad Social",
      "Trabajo y Previsión Social",
      "Transportes",
      "Turismo",
      "Vivienda",
      "Sección Instructora"
    ]

    commissions.each do |commission|
      Commission.create!(name: commission)
    end
  end

  task :pronouncements => :environment do
    gazette_elements = []

    ['1','2'].each do |number|
      ['primero','segundo'].each do |word|
        gazette_page = Nokogiri::HTML(open("http://gaceta.diputados.gob.mx/Gaceta/Dictamenes/61/gp61_a#{number}#{word}.html"))
        gazette_page.css('ul li').each do |li|
          content = li.content.split("\n")

          content.each_with_index do |element, index|
            if element == ""
              content[index] = nil
            end
          end

          content.compact!
          gazette_elements << content
        end
      end
    end

    commissions = Commission.all
    gazette_elements.each do |element|
      details = element.first
      gazette = element.last

      size = element.size
      element[0] = nil
      element[size - 1] = nil
      element.compact!

      steps = element

      p "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
      p "Details:"
      p details
      p "Gazette:"
      p gazette

      number = gazette.split(",")[1]
      serial = number.split(" ")[1]
      gazette = Gazette.find_by_serial(serial)
      pronouncement = Pronouncement.create!(details: details, gazette_id: gazette.id)

      commissions.each do |commission|
        if details.include? commission.name
          pronouncement.commissions << commission
        end
      end

      steps.each do |step_content|

        step = Step.new(pronouncement_id: pronouncement.id, voted_where: step_content)
        ["Aprobado", "Dictaminado", "Reprobado", "Rechazado", "Publicado", ].each do |state|
          step_content_split = step_content.split(" ").compact
          if step_content_split.first.include? state

            if step_content_split.last.include? "Votación."
              step_content_split.pop
            end

            if step_content_split.last.include? "modificaciones."
              step_content_split.pop(2)
            end

            last_element = step_content_split.size - 1

            month = case step_content_split[last_element - 2]
              when "enero" then "Jan"
              when "febrero" then "Feb"
              when "marzo" then "Mar"
              when "abril" then "Apr"
              when "mayo" then "May"
              when "junio" then "Jun"
              when "julio" then "Jul"
              when "agosto" then "Aug"
              when "septiembre" then "Sep"
              when "octubre" then "Oct"
              when "noviembre" then "Nov"
              when "diciembre" then "Dec"
            end

            step.voted_at = (step_content_split[last_element - 4] + month + step_content_split[last_element] ).to_date
            step.state = state
            step.save
          end
        end
      end
    end
  end

  task :gazettes => :environment do
    gazette_elements = []

    ['1','2'].each do |number|
      ['primero','segundo'].each do |word|
        gazette_page = Nokogiri::HTML(open("http://gaceta.diputados.gob.mx/Gaceta/Dictamenes/61/gp61_a#{number}#{word}.html"))
        gazette_page.css('ul li').each do |li|
          content = li.content.split("\n")

          content.each_with_index do |element, index|
            if element == ""
              content[index] = nil
            end
          end

          content.compact!
          gazette_elements << content
        end
      end
    end

    gazette_elements.each do |element|

      gazette = Gazette.new
      gazette_content = element.last

      number = gazette_content.split(",")[1]
      gazette.serial = number.split(" ")[1]

      date_split = gazette_content.split(" ")
      size = date_split.size - 1

      month = case date_split[size - 2]
        when "enero" then "Jan"
        when "febrero" then "Feb"
        when "marzo" then "Mar"
        when "abril" then "Apr"
        when "mayo" then "May"
        when "junio" then "Jun"
        when "julio" then "Jul"
        when "agosto" then "Aug"
        when "septiembre" then "Sep"
        when "octubre" then "Oct"
        when "noviembre" then "Nov"
        when "diciembre" then "Dec"
      end

      gazette.published_at = (date_split[size - 4] + month + date_split[size] ).to_date
      gazette.save
    end
  end

end