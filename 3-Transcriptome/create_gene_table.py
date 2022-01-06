from collections import defaultdict

def return_default_dict(): 
	return {'transcript_id' : '', 'gene_name' : '', 'n_exons' : 1}

data = open('archive/exons_merged.txt').read().split('\n')
data = map(lambda x: x.split(';')[:-1], data)

gene_dict = defaultdict(return_default_dict)

for item in data:
	elements = map(lambda x: x.strip().replace('"','').split(' '), item)
	# print(list(elements), len(list(elements)))
	gene_id, transcript_id, gene_name = ['n/a']*3 
	n_exon = 1
	for _element in elements:
		if _element[0] == 'gene_id':
			gene_id = _element[1]
		elif _element[0] == 'transcript_id':
			transcript_id = _element[1]
		elif _element[0] == 'gene_name':
			gene_name = _element[1]
		elif _element[0] == 'exon_number':
			n_exon = int(_element[1])
	# print(gene_id, transcript_id, gene_name)
	n_exons = gene_dict[gene_id]['n_exons']
	gene_dict[gene_id] = {
		'transcript_id' : transcript_id,
		'gene_name' : gene_name,
		'n_exons' : max(n_exons, n_exon)
	}

print('\t'.join(['gene_id','transcript_id','gene_name','n_exons']))

for gene_id,v in gene_dict.items():
	print('\t'.join([gene_id, v['transcript_id'], v['gene_name'], str(v['n_exons'])]))
