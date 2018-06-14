class SampleMailer < ApplicationMailer
    def send_when_update
        @greeting = "Hi"
        @cnt = CtaLoc.count
        @time = Time.now.strftime("%Y-%m-%d_%H:%M:%S")

        
        # file name  
        fn = "CTA data (p)_"+ @time+".csv"

        #if there is no temp direcotyr, make temporary directory
        if Dir.exist?(Rails.root.join("public", "temp"))
            keepDir = 1
        else
            keepDir = 0
            Dir.mkdir(Rails.root.join("public", "temp"))
        end

        # extract csv from database and store in temp directory
        Dir.chdir(Rails.root.join("public", "temp")) do
            # Convert CtaLoc to csv and write into csv file generated
            File.open(fn, 'w') do |content|
                content.puts(CtaLoc.to_csv)
            end
        end

        # Attach file 
        attachments[fn] = File.read(Rails.root.join("public", "temp", fn))

        #clean up by deleting file and then deleting temp folder
        File.delete(Rails.root.join("public", "temp", fn))

        
        # If the directory existed below, keep it and if not delete it
        if keepDir == 1
            # Do nothing
        else
            Dir.delete(Rails.root.join("public", "temp"))
        end

        mail to: "kiwamu.sato@kellogg.northwestern.edu",
        subject: "Today's CTA data"

    end
end
