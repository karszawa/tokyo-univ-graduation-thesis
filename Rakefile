NAME = 'document'

def preprocess
	Dir.glob("src/*.md").map do |md|
		next if md =~ /.pp.md$/

		preprocessed = md.sub(".md", ".pp.md")
		filters = Dir.glob("filters/*").join(' | ')
		`cat #{md} | #{filters} > #{preprocessed}`
  end
end

task :preprocess do preprocess end

def remove_preprocessed
	Dir.glob("src/*.pp.md").map do |md|
		tx = md.sub(".md", ".tex")

		File.delete(md) if File.exist?(md)
		File.delete(tx) if File.exist?(tx)
	end
end

def pandoc
	Dir.glob("src/*.pp.md").map do |md|
    tex = md.sub(".pp.md", ".tex")
    `pandoc -f markdown -t latex+smart #{md} -o #{tex}`
  end
end

task :pandoc do pandoc end

def latex
	puts `env TEXINPUTS='.//;' latexmk src/#{NAME}.tex`
  `mv #{NAME}.pdf build/`
end

task :latex do latex end

task :build do
	raise 'Failed preprocess' unless preprocess
	raise 'Failed pandoc' unless pandoc
	raise 'Failed latex' unless latex
	raise 'Failed remove_preprocessed' unless remove_preprocessed
end

task :clean do
	remove_preprocessed

  Dir.glob("src/*.md").map do |md|
    tex = md.sub('.md', '.tex')
		File.delete(tex) if md != "src/#{NAME}.tex" && File.exist?(tex)
  end

	[ '.bbl', '-blx.bib', '.run.xml', '.out.ps' ].each do |ext|
		filename = "#{NAME}#{ext}"
		File.delete(filename) if File.exist?(filename)
	end

	puts `latexmk -C src/#{NAME}.tex`
end

task :open do
  `open build/#{NAME}.pdf`
end

task :eps do
  Dir.glob('fig/**/*.png').each do |png|
    eps = png.sub('.png', '.eps')
    `convert #{png} eps2:#{eps}`
  end
end

task :plot do |task, args|
	Dir.glob("data/*.plt") do |plot|
		next if ENV['target'] && plot != ENV['target']

		puts "[Plotting 🏃 ] gnuplot #{plot}"

		`gnuplot #{plot}`
	end
end

task default: [ 'build', 'clean' ]
