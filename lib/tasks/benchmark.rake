def query
  Post.order(created_at: :desc).offset(200).limit(10).load
end

namespace :benchmark do
  task :ips => :environment do
    require "benchmark/ips"

    Benchmark.ips do |x|
      x.report("Query") { query }
    end
  end

  task :memory => :environment do
    require "benchmark-memory"

    Benchmark.memory do |x|
      x.report("Query") { query }
    end
  end

  task :all => :environment do
    Rake::Task["benchmark:ips"].invoke
    Rake::Task["benchmark:memory"].invoke
  end
end
