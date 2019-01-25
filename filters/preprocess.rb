#! /usr/bin/env ruby

class String
	# ![caption](path){option} =>
	# \begin{figure}[htbp]
	# 	\centering
	# 	\includegraphics[option]{path}
	# 	\caption{caption \label{fig:filename(exclude extension)}}
	# \end{figure}
	def figure
		self.gsub(/^!\[(.+)\]\(((?:.*\/)*(.+)\..*)\)\{(.+)\}/, <<~EOS)
			\\begin{figure}[htbp]
				\\centering
				\\includegraphics[\\4]{\\2}
				\\caption{\\1 \\label{fig:\\3}}
			\\end{figure}
		EOS
	end

	# `< `から行を始めると段落のはじめのインデントなくす
	# 画像を挟んで段落を続けたいときなどに使う
	def noindent
		self.gsub(/^<\ /, '\noindent ')
	end

	# NOTE: cite, ref, labelの略記。そんなに必要でもないのでなくす
	# @key => ~\cite{key}
	# line.gsub!(/@(.+)/, '~\cite{\1}')
	# @{key} => ~\ref{key}
	#	input.gsub!(/@{(.+)}/, '\ref{\1}')
	# #{key} => ~\label{key}
	# input.gsub!(/\#{(.+)}/, '\label{\1}')

	def eqnarray
		self.gsub(/\$\$(.*?)\$\$/m, <<~EOS)
			\\begin{eqnarray}
				\\1
			\\end{eqnarray}
		EOS
	end
end

inputs = ''

while input = gets
	inputs += input
end

print inputs.figure.noindent.eqnarray
