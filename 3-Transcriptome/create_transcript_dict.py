data = open('archive/transcripts_merged.txt').read().split('\n')
data = map(lambda x: x.split('\t')[1:], data)

print('\t'.join(['transcript_id','start','end','gene_id','gene_name']))

for start, end, sequence in data:
	items = sequence.split(';')[:-1]
	items = map(lambda x: x.strip().replace('"','').split(' '), items)
	gene_id, transcript_id, gene_name = ['n/a']*3
	for item in items:
		if item[0] == 'gene_id':
			gene_id = item[1]
		elif item[0] == 'transcript_id':
			transcript_id = item[1]
		elif item[0] == 'gene_name':
			gene_name = item[1]
	print('\t'.join([transcript_id, start, end, gene_id, gene_name]))
