BEGIN;

SELECT evergreen.upgrade_deps_block_check('1070', :eg_version); --miker/gmcharlt/kmlussier

CREATE TRIGGER thes_code_tracking_trigger
    AFTER UPDATE ON authority.thesaurus
    FOR EACH ROW EXECUTE PROCEDURE oils_i18n_code_tracking('at');

ALTER TABLE authority.thesaurus ADD COLUMN short_code TEXT, ADD COLUMN uri TEXT;

DELETE FROM authority.thesaurus WHERE control_set = 1 AND code NOT IN ('n',' ','|');
UPDATE authority.thesaurus SET short_code = code;

CREATE TEMP TABLE thesauri (code text, uri text, name text, xlate hstore);
COPY thesauri (code, uri, name, xlate) FROM STDIN;
migfg	http://id.loc.gov/vocabulary/genreFormSchemes/migfg	Moving image genre-form guide	
reveal	http://id.loc.gov/vocabulary/genreFormSchemes/reveal	REVEAL: fiction indexing and genre headings	
dct	http://id.loc.gov/vocabulary/genreFormSchemes/dct	Dublin Core list of resource types	
gmgpc	http://id.loc.gov/vocabulary/genreFormSchemes/gmgpc	Thesaurus for graphic materials: TGM II, Genre and physical characteristic terms	
rbgenr	http://id.loc.gov/vocabulary/genreFormSchemes/rbgenr	Genre terms: a thesaurus for use in rare book and special collections cataloguing	
sgp	http://id.loc.gov/vocabulary/genreFormSchemes/sgp	Svenska genrebeteckningar fr periodika	"sv"=>"Svenska genrebeteckningar fr periodika"
estc	http://id.loc.gov/vocabulary/genreFormSchemes/estc	Eighteenth century short title catalogue, the cataloguing rules. New ed.	
ftamc	http://id.loc.gov/vocabulary/genreFormSchemes/ftamc	Form terms for archival and manuscripts control	
alett	http://id.loc.gov/vocabulary/genreFormSchemes/alett	An alphabetical list of English text types	
gtlm	http://id.loc.gov/vocabulary/genreFormSchemes/gtlm	Genre terms for law materials: a thesaurus	
rbprov	http://id.loc.gov/vocabulary/genreFormSchemes/rbprov	Provenance evidence: a thesaurus for use in rare book and special collections cataloging	
rbbin	http://id.loc.gov/vocabulary/genreFormSchemes/rbbin	Binding terms: a thesaurus for use in rare book and special collections cataloguing	
fbg	http://id.loc.gov/vocabulary/genreFormSchemes/fbg	Films by genre /dd>	
isbdmedia	http://id.loc.gov/vocabulary/genreFormSchemes/isbdmedia	ISBD Area 0 [media]	
marccategory	http://id.loc.gov/vocabulary/genreFormSchemes/marccategory	MARC form category term list	
gnd-music	http://id.loc.gov/vocabulary/genreFormSchemes/gnd-music	Gemeinsame Normdatei: Musikalische Ausgabeform	
proysen	http://id.loc.gov/vocabulary/genreFormSchemes/proysen	Pr????ysen: emneord for Pr????ysen-bibliografien	
rdacarrier	http://id.loc.gov/vocabulary/genreFormSchemes/rdacarrier	Term and code list for RDA carrier types	
gnd	http://id.loc.gov/vocabulary/genreFormSchemes/gnd	Gemeinsame Normdatei	
cjh	http://id.loc.gov/vocabulary/genreFormSchemes/cjh	Center for Jewish History thesaurus	
rbpri	http://id.loc.gov/vocabulary/genreFormSchemes/rbpri	Printing & publishing evidence: a thesaurus for use in rare book and special collections cataloging	
fgtpcm	http://id.loc.gov/vocabulary/genreFormSchemes/fgtpcm	Form/genre terms for printed cartoon material	
rbpub	http://id.loc.gov/vocabulary/genreFormSchemes/rbpub	Printing and publishing evidence: a thesaurus for use in rare book and special collections cataloging	
gmd	http://id.loc.gov/vocabulary/genreFormSchemes/gmd	Anglo-American Cataloguing Rules general material designation	
rbpap	http://id.loc.gov/vocabulary/genreFormSchemes/rbpap	Paper terms: a thesaurus for use in rare book and special collections cataloging	
rdamedia	http://id.loc.gov/vocabulary/genreFormSchemes/rdamedia	Term and code list for RDA media types	
marcsmd	http://id.loc.gov/vocabulary/genreFormSchemes/marcsmd	MARC specific material form term list	
saogf	http://id.loc.gov/vocabulary/genreFormSchemes/saogf	Svenska ????mnesord - Genre/Form	"sv"=>"Svenska ????mnesord - Genre/Form"
lcgft	http://id.loc.gov/vocabulary/genreFormSchemes/lcgft	Library of Congress genre/form terms for library and archival materials	
muzeukv	http://id.loc.gov/vocabulary/genreFormSchemes/muzeukv	MuzeVideo UK DVD and UMD film genre classification	
mim	http://id.loc.gov/vocabulary/genreFormSchemes/mim	Moving image materials: genre terms	
nmc	http://id.loc.gov/vocabulary/genreFormSchemes/nmc	Revised nomenclature for museum cataloging: a revised and expanded version of Robert C. Chenhall's system for classifying man-made objects	
gnd-content	http://id.loc.gov/vocabulary/genreFormSchemes/gnd-content	Gemeinsame Normdatei: Beschreibung des Inhalts	
bgtchm	http://id.loc.gov/vocabulary/genreFormSchemes/bgtchm	Basic genre terms for cultural heritage materials	
gsafd	http://id.loc.gov/vocabulary/genreFormSchemes/gsafd	Guidelines on subject access to individual works of fiction, drama, etc	
marcform	http://id.loc.gov/vocabulary/genreFormSchemes/marcform	MARC form of item term list	
marcgt	http://id.loc.gov/vocabulary/genreFormSchemes/marcgt	MARC genre terms	
barngf	http://id.loc.gov/vocabulary/genreFormSchemes/barngf	Svenska ????mnesord f????r barn - Genre/Form	"sv"=>"Svenska ????mnesord f????r barn - Genre/Form"
ngl	http://id.loc.gov/vocabulary/genreFormSchemes/ngl	Newspaper genre list	
rvmgf	http://id.loc.gov/vocabulary/genreFormSchemes/rvmgf	Th????saurus des descripteurs de genre/forme de l'Universit???? Laval	"fr"=>"Th????saurus des descripteurs de genre/forme de l'Universit???? Laval"
tgfbne	http://id.loc.gov/vocabulary/genreFormSchemes/tgfbne	T????rminos de g????nero/forma de la Biblioteca Nacional de Espa????a	
nbdbgf	http://id.loc.gov/vocabulary/genreFormSchemes/nbdbgf	NBD Biblion Genres Fictie	
rbtyp	http://id.loc.gov/vocabulary/genreFormSchemes/rbtyp	Type evidence: a thesaurus for use in rare book and special collections cataloging	
radfg	http://id.loc.gov/vocabulary/genreFormSchemes/radfg	Radio form / genre terms guide	
gnd-carrier	http://id.loc.gov/vocabulary/genreFormSchemes/gnd-carrier	Gemeinsame Normdatei: Datentr????gertyp	
gatbeg	http://id.loc.gov/vocabulary/genreFormSchemes/gatbeg	Gattungsbegriffe	"de"=>"Gattungsbegriffe"
rdacontent	http://id.loc.gov/vocabulary/genreFormSchemes/rdacontent	Term and code list for RDA content types	
isbdcontent	http://id.loc.gov/vocabulary/genreFormSchemes/isbdcontent	ISBD Area 0 [content]	
nimafc	http://id.loc.gov/vocabulary/genreFormSchemes/nimafc	NIMA form codes	
amg	http://id.loc.gov/vocabulary/genreFormSchemes/amg	Audiovisual material glossary	
local	http://id.loc.gov/vocabulary/subjectSchemes/local	Locally assigned term	
taika	http://id.loc.gov/vocabulary/subjectSchemes/taika	Taideteollisuuden asiasanasto	"fi"=>"Taideteollisuuden asiasanasto"
nasat	http://id.loc.gov/vocabulary/subjectSchemes/nasat	NASA thesaurus	
rswkaf	http://id.loc.gov/vocabulary/subjectSchemes/rswkaf	Alternativform zum Hauptschlagwort	"de"=>"Alternativform zum Hauptschlagwort"
jhpk	http://id.loc.gov/vocabulary/subjectSchemes/jhpk	J????zyk hase???? przedmiotowych KABA	"pl"=>"J????zyk hase???? przedmiotowych KABA"
asrcrfcd	http://id.loc.gov/vocabulary/subjectSchemes/asrcrfcd	Australian Standard Research Classification: Research Fields, Courses and Disciplines (RFCD) classification	
bt	http://id.loc.gov/vocabulary/subjectSchemes/bt	Bioethics thesaurus	
lcstt	http://id.loc.gov/vocabulary/subjectSchemes/lcstt	List of Chinese subject terms	
netc	http://id.loc.gov/vocabulary/subjectSchemes/netc	National Emergency Training Center Thesaurus (NETC)	
aat	http://id.loc.gov/vocabulary/subjectSchemes/aat	Art & architecture thesaurus	
bet	http://id.loc.gov/vocabulary/subjectSchemes/bet	British education thesaurus	
ncjt	http://id.loc.gov/vocabulary/subjectSchemes/ncjt	National criminal justice thesaurus	
samisk	http://id.loc.gov/vocabulary/subjectSchemes/samisk	Sami bibliography	"no"=>"S????mi bibliografia = Samisk bibliografi (Norge)"
tips	http://id.loc.gov/vocabulary/subjectSchemes/tips	Tesauro ISOC de psicolog????a	"es"=>"Tesauro ISOC de psicolog????a"
ukslc	http://id.loc.gov/vocabulary/subjectSchemes/ukslc	UK Standard Library Categories	
tekord	http://id.loc.gov/vocabulary/subjectSchemes/tekord	TEK-ord : UBiTs emneordliste for arkitektur, realfag, og teknolog	"no"=>"TEK-ord : UBiTs emneordliste for arkitektur, realfag, og teknolog"
umitrist	http://id.loc.gov/vocabulary/subjectSchemes/umitrist	University of Michigan Transportation Research Institute structured thesaurus	
wgst	http://id.loc.gov/vocabulary/subjectSchemes/wgst	Washington GILS Subject Tree	
rasuqam	http://id.loc.gov/vocabulary/subjectSchemes/rasuqam	R????pertoire d'autorit????s-sujet de l'UQAM	"fr"=>"R????pertoire d'autorit????s-sujet de l'UQAM"
ntids	http://id.loc.gov/vocabulary/subjectSchemes/ntids	Norske tidsskrifter 1700-1820: emneord	"no"=>"Norske tidsskrifter 1700-1820: emneord"
kaa	http://id.loc.gov/vocabulary/subjectSchemes/kaa	Kasvatusalan asiasanasto	"fi"=>"Kasvatusalan asiasanasto"
yso	http://id.loc.gov/vocabulary/subjectSchemes/yso	YSO - Yleinen suomalainen ontologia	"fi"=>"YSO - Yleinen suomalainen ontologia"
gcipmedia	http://id.loc.gov/vocabulary/subjectSchemes/gcipmedia	GAMECIP - Computer Game Media Formats (GAMECIP (Game Metadata and Citation Project))	
inspect	http://id.loc.gov/vocabulary/subjectSchemes/inspect	INSPEC thesaurus	
ordnok	http://id.loc.gov/vocabulary/subjectSchemes/ordnok	Ordnokkelen: tesaurus for kulturminnevern	"no"=>"Ordnokkelen: tesaurus for kulturminnevern"
helecon	http://id.loc.gov/vocabulary/subjectSchemes/helecon	Asiasanasto HELECON-tietikantoihin	"fi"=>"Asiasanasto HELECON-tietikantoihin"
dltlt	http://id.loc.gov/vocabulary/subjectSchemes/dltlt	Cuddon, J. A. A dictionary of literary terms and literary theory	
csapa	http://id.loc.gov/vocabulary/subjectSchemes/csapa	"Controlled vocabulary" in Pollution abstracts	
gtt	http://id.loc.gov/vocabulary/subjectSchemes/gtt	GOO-trefwoorden thesaurus	"nl"=>"GOO-trefwoorden thesaurus"
iescs	http://id.loc.gov/vocabulary/subjectSchemes/iescs	International energy subject categories and scope	
itrt	http://id.loc.gov/vocabulary/subjectSchemes/itrt	International Thesaurus of Refugee Terminology	
sanb	http://id.loc.gov/vocabulary/subjectSchemes/sanb	South African national bibliography authority file	
blmlsh	http://id.loc.gov/vocabulary/subjectSchemes/blmlsh	British Library - Map library subject headings	
bhb	http://id.loc.gov/vocabulary/subjectSchemes/bhb	Bibliography of the Hebrew Book	
csh	http://id.loc.gov/vocabulary/subjectSchemes/csh	Kapsner, Oliver Leonard. Catholic subject headings	
fire	http://id.loc.gov/vocabulary/subjectSchemes/fire	FireTalk, IFSI thesaurus	
jlabsh	http://id.loc.gov/vocabulary/subjectSchemes/jlabsh	Basic subject headings	"ja"=>"Kihon kenmei hy????mokuhy????"
udc	http://id.loc.gov/vocabulary/subjectSchemes/udc	Universal decimal classification	
lcshac	http://id.loc.gov/vocabulary/subjectSchemes/lcshac	Children's subject headings in Library of Congress subject headings: supplementary vocabularies	
geonet	http://id.loc.gov/vocabulary/subjectSchemes/geonet	NGA GEOnet Names Server (GNS)	
humord	http://id.loc.gov/vocabulary/subjectSchemes/humord	HUMORD	"no"=>"HUMORD"
no-ubo-mr	http://id.loc.gov/vocabulary/subjectSchemes/no-ubo-mr	Menneskerettighets-tesaurus	"no"=>"Menneskerettighets-tesaurus"
sgce	http://id.loc.gov/vocabulary/subjectSchemes/sgce	COBISS.SI General List of subject headings (English subject headings)	"sl"=>"Splo????ni geslovnik COBISS.SI"
kdm	http://id.loc.gov/vocabulary/subjectSchemes/kdm	Khung d???? muc h???? th????ng th????ng tin khoa hoc v???? ky thu????t qu????c gia	"vi"=>"Khung d???? muc h???? th????ng th????ng tin khoa hoc v???? ky thu????t qu????c gia"
thesoz	http://id.loc.gov/vocabulary/subjectSchemes/thesoz	Thesaurus for the Social Sciences	
asth	http://id.loc.gov/vocabulary/subjectSchemes/asth	Astronomy thesaurus	
muzeukc	http://id.loc.gov/vocabulary/subjectSchemes/muzeukc	MuzeMusic UK classical music classification	
norbok	http://id.loc.gov/vocabulary/subjectSchemes/norbok	Norbok: emneord i Norsk bokfortegnelse	"no"=>"Norbok: emneord i Norsk bokfortegnelse"
masa	http://id.loc.gov/vocabulary/subjectSchemes/masa	Museoalan asiasanasto	"fi"=>"Museoalan asiasanasto"
conorsi	http://id.loc.gov/vocabulary/subjectSchemes/conorsi	CONOR.SI (name authority file) (Maribor, Slovenia: Institut informacijskih znanosti (IZUM))	
eurovocen	http://id.loc.gov/vocabulary/subjectSchemes/eurovocen	Eurovoc thesaurus (English)	
kto	http://id.loc.gov/vocabulary/subjectSchemes/kto	KTO - Kielitieteen ontologia	"fi"=>"KTO - Kielitieteen ontologia"
muzvukci	http://id.loc.gov/vocabulary/subjectSchemes/muzvukci	MuzeVideo UK contributor index	
kaunokki	http://id.loc.gov/vocabulary/subjectSchemes/kaunokki	Kaunokki: kaunokirjallisuuden asiasanasto	"fi"=>"Kaunokki: kaunokirjallisuuden asiasanasto"
maotao	http://id.loc.gov/vocabulary/subjectSchemes/maotao	MAO/TAO - Ontologi f????r museibranschen och Konstindustriella ontologin	"fi"=>"MAO/TAO - Ontologi f????r museibranschen och Konstindustriella ontologin"
psychit	http://id.loc.gov/vocabulary/subjectSchemes/psychit	Thesaurus of psychological index terms.	
tlsh	http://id.loc.gov/vocabulary/subjectSchemes/tlsh	Subject heading authority list	
csalsct	http://id.loc.gov/vocabulary/subjectSchemes/csalsct	CSA life sciences collection thesaurus	
ciesiniv	http://id.loc.gov/vocabulary/subjectSchemes/ciesiniv	CIESIN indexing vocabulary	
ebfem	http://id.loc.gov/vocabulary/subjectSchemes/ebfem	Encabezamientos biling????es de la Fundaci????n Educativa Ana G. Mendez	
mero	http://id.loc.gov/vocabulary/subjectSchemes/mero	MERO - Merenkulkualan ontologia	"fi"=>"MERO - Merenkulkualan ontologia"
mmm	http://id.loc.gov/vocabulary/subjectSchemes/mmm	"Subject key" in Marxism and the mass media	
pascal	http://id.loc.gov/vocabulary/subjectSchemes/pascal	PASCAL database classification scheme	"fr"=>"Base de donne????s PASCAL: plan de classement"
chirosh	http://id.loc.gov/vocabulary/subjectSchemes/chirosh	Chiropractic Subject Headings	
cilla	http://id.loc.gov/vocabulary/subjectSchemes/cilla	Cilla: specialtesaurus f????r musik	"fi"=>"Cilla: specialtesaurus f????r musik"
aiatsisl	http://id.loc.gov/vocabulary/subjectSchemes/aiatsisl	AIATSIS language thesaurus	
nskps	http://id.loc.gov/vocabulary/subjectSchemes/nskps	Priru????nik za izradu predmetnog kataloga u Nacionalnoj i sveu????ili????noj knji????nici u Zagrebu	"hr"=>"Priru????nik za izradu predmetnog kataloga u Nacionalnoj i sveu????ili????noj knji????nici u Zagrebu"
lctgm	http://id.loc.gov/vocabulary/subjectSchemes/lctgm	Thesaurus for graphic materials: TGM I, Subject terms	
muso	http://id.loc.gov/vocabulary/subjectSchemes/muso	MUSO - Ontologi f????r musik	"fi"=>"MUSO - Ontologi f????r musik"
blcpss	http://id.loc.gov/vocabulary/subjectSchemes/blcpss	COMPASS subject authority system	
fast	http://id.loc.gov/vocabulary/subjectSchemes/fast	Faceted application of subject terminology	
bisacmt	http://id.loc.gov/vocabulary/subjectSchemes/bisacmt	BISAC Merchandising Themes	
lapponica	http://id.loc.gov/vocabulary/subjectSchemes/lapponica	Lapponica	"fi"=>"Lapponica"
juho	http://id.loc.gov/vocabulary/subjectSchemes/juho	JUHO - Julkishallinnon ontologia	"fi"=>"JUHO - Julkishallinnon ontologia"
idas	http://id.loc.gov/vocabulary/subjectSchemes/idas	ID-Archivschl????ssel	"de"=>"ID-Archivschl????ssel"
tbjvp	http://id.loc.gov/vocabulary/subjectSchemes/tbjvp	Tesauro de la Biblioteca Dr. Jorge Villalobos Padilla, S.J.	"es"=>"Tesauro de la Biblioteca Dr. Jorge Villalobos Padilla, S.J."
test	http://id.loc.gov/vocabulary/subjectSchemes/test	Thesaurus of engineering and scientific terms	
finmesh	http://id.loc.gov/vocabulary/subjectSchemes/finmesh	FinMeSH	"fi"=>"FinMeSH"
kssbar	http://id.loc.gov/vocabulary/subjectSchemes/kssbar	Klassifikationssystem for svenska bibliotek. ????mnesordregister. Alfabetisk del	"sv"=>"Klassifikationssystem for svenska bibliotek. ????mnesordregister. Alfabetisk del"
kupu	http://id.loc.gov/vocabulary/subjectSchemes/kupu	Maori Wordnet	"mi"=>"He puna kupu"
rpe	http://id.loc.gov/vocabulary/subjectSchemes/rpe	Rubricator on economics	"ru"=>"Rubrikator po ekonomike"
dit	http://id.loc.gov/vocabulary/subjectSchemes/dit	Defense intelligence thesaurus	
she	http://id.loc.gov/vocabulary/subjectSchemes/she	SHE: subject headings for engineering	
idszbzna	http://id.loc.gov/vocabulary/subjectSchemes/idszbzna	Thesaurus IDS Nebis Zentralbibliothek Z????rich, Nordamerika-Bibliothek	"de"=>"Thesaurus IDS Nebis Zentralbibliothek Z????rich, Nordamerika-Bibliothek"
msc	http://id.loc.gov/vocabulary/subjectSchemes/msc	Mathematical subject classification	
muzeukn	http://id.loc.gov/vocabulary/subjectSchemes/muzeukn	MuzeMusic UK non-classical music classification	
ipsp	http://id.loc.gov/vocabulary/subjectSchemes/ipsp	Defense intelligence production schedule.	
sthus	http://id.loc.gov/vocabulary/subjectSchemes/sthus	Subject Taxonomy of the History of U.S. Foreign Relations	
poliscit	http://id.loc.gov/vocabulary/subjectSchemes/poliscit	Political science thesaurus II	
qtglit	http://id.loc.gov/vocabulary/subjectSchemes/qtglit	A queer thesaurus : an international thesaurus of gay and lesbian index terms	
unbist	http://id.loc.gov/vocabulary/subjectSchemes/unbist	UNBIS thesaurus	
gcipplatform	http://id.loc.gov/vocabulary/subjectSchemes/gcipplatform	GAMECIP - Computer Game Platforms (GAMECIP (Game Metadata and Citation Project))	
puho	http://id.loc.gov/vocabulary/subjectSchemes/puho	PUHO - Puolustushallinnon ontologia	"fi"=>"PUHO - Puolustushallinnon ontologia"
thub	http://id.loc.gov/vocabulary/subjectSchemes/thub	Thesaurus de la Universitat de Barcelona	"ca"=>"Thesaurus de la Universitat de Barcelona"
ndlsh	http://id.loc.gov/vocabulary/subjectSchemes/ndlsh	National Diet Library list of subject headings	"ja"=>"Koktsu Kokkai Toshokan kenmei hy????mokuhy????"
czenas	http://id.loc.gov/vocabulary/subjectSchemes/czenas	CZENAS thesaurus: a list of subject terms used in the National Library of the Czech Republic	"cs"=>"Soubor v????cn????ch autorit N????rodn???? knihovny ????R"
idszbzzh	http://id.loc.gov/vocabulary/subjectSchemes/idszbzzh	Thesaurus IDS Nebis Zentralbibliothek Z????rich, Handschriftenabteilung	"de"=>"Thesaurus IDS Nebis Zentralbibliothek Z????rich, Handschriftenabteilung"
unbisn	http://id.loc.gov/vocabulary/subjectSchemes/unbisn	UNBIS name authority list (New York, NY: Dag Hammarskjld Library, United Nations; : Chadwyck-Healey)	
rswk	http://id.loc.gov/vocabulary/subjectSchemes/rswk	Regeln f????r den Schlagwortkatalog	"de"=>"Regeln f????r den Schlagwortkatalog"
larpcal	http://id.loc.gov/vocabulary/subjectSchemes/larpcal	Lista de assuntos referente ao programa de cadastramento automatizado de livros da USP	"pt"=>"Lista de assuntos referente ao programa de cadastramento automatizado de livros da USP"
biccbmc	http://id.loc.gov/vocabulary/subjectSchemes/biccbmc	BIC Children's Books Marketing Classifications	
kulo	http://id.loc.gov/vocabulary/subjectSchemes/kulo	KULO - Kulttuurien tutkimuksen ontologia	"fi"=>"KULO - Kulttuurien tutkimuksen ontologia"
popinte	http://id.loc.gov/vocabulary/subjectSchemes/popinte	POPIN thesaurus: population multilingual thesaurus	
tisa	http://id.loc.gov/vocabulary/subjectSchemes/tisa	Villagr???? Rubio, Angel. Tesauro ISOC de sociolog????a autores	"es"=>"Villagr???? Rubio, Angel. Tesauro ISOC de sociolog????a autores"
atg	http://id.loc.gov/vocabulary/subjectSchemes/atg	Agricultural thesaurus and glossary	
eflch	http://id.loc.gov/vocabulary/subjectSchemes/eflch	E4Libraries Category Headings	
maaq	http://id.loc.gov/vocabulary/subjectSchemes/maaq	Mad????khil al-asm????' al-'arab????yah al-qad????mah	"ar"=>"Mad????khil al-asm????' al-'arab????yah al-qad????mah"
rvmgd	http://id.loc.gov/vocabulary/subjectSchemes/rvmgd	Th????saurus des descripteurs de groupes d????mographiques de l'Universit???? Laval	"fr"=>"Th????saurus des descripteurs de groupes d????mographiques de l'Universit???? Laval"
csahssa	http://id.loc.gov/vocabulary/subjectSchemes/csahssa	"Controlled vocabulary" in Health and safety science abstracts	
sigle	http://id.loc.gov/vocabulary/subjectSchemes/sigle	SIGLE manual, Part 2, Subject category list	
blnpn	http://id.loc.gov/vocabulary/subjectSchemes/blnpn	British Library newspaper place names	
asrctoa	http://id.loc.gov/vocabulary/subjectSchemes/asrctoa	Australian Standard Research Classification: Type of Activity (TOA) classification	
lcdgt	http://id.loc.gov/vocabulary/subjectSchemes/lcdgt	Library of Congress demographic group term and code List	
bokbas	http://id.loc.gov/vocabulary/subjectSchemes/bokbas	Bokbasen	"no"=>"Bokbasen"
gnis	http://id.loc.gov/vocabulary/subjectSchemes/gnis	Geographic Names Information System (GNIS)	
nbiemnfag	http://id.loc.gov/vocabulary/subjectSchemes/nbiemnfag	NBIs emneordsliste for faglitteratur	"no"=>"NBIs emneordsliste for faglitteratur"
nlgaf	http://id.loc.gov/vocabulary/subjectSchemes/nlgaf	Archeio Kathier????men????n Epikephalid????n	"el"=>"Archeio Kathier????men????n Epikephalid????n"
bhashe	http://id.loc.gov/vocabulary/subjectSchemes/bhashe	BHA, Bibliography of the history of art, subject headings/English	
tsht	http://id.loc.gov/vocabulary/subjectSchemes/tsht	Thesaurus of subject headings for television	
scbi	http://id.loc.gov/vocabulary/subjectSchemes/scbi	Soggettario per i cataloghi delle biblioteche italiane	"it"=>"Soggettario per i cataloghi delle biblioteche italiane"
valo	http://id.loc.gov/vocabulary/subjectSchemes/valo	VALO - Fotografiska ontologin	"fi"=>"VALO - Fotografiska ontologin"
wpicsh	http://id.loc.gov/vocabulary/subjectSchemes/wpicsh	WPIC Library thesaurus of subject headings	
aktp	http://id.loc.gov/vocabulary/subjectSchemes/aktp	Alphav????tikos Katalogos Thematik????n Perigraphe????n	"el"=>"Alphav????tikos Katalogos Thematik????n Perigraphe????n"
stw	http://id.loc.gov/vocabulary/subjectSchemes/stw	STW Thesaurus for Economics	"de"=>"Standard-Thesaurus Wirtschaft"
mesh	http://id.loc.gov/vocabulary/subjectSchemes/mesh	Medical subject headings	
ica	http://id.loc.gov/vocabulary/subjectSchemes/ica	Index of Christian art	
emnmus	http://id.loc.gov/vocabulary/subjectSchemes/emnmus	Emneord for musikkdokument i EDB-kataloger	"no"=>"Emneord for musikkdokument i EDB-kataloger"
sao	http://id.loc.gov/vocabulary/subjectSchemes/sao	Svenska ????mnesord	"sv"=>"Svenska ????mnesord"
sgc	http://id.loc.gov/vocabulary/subjectSchemes/sgc	COBISS.SI General List of subject headings (Slovenian subject headings)	"sl"=>"Splo????ni geslovnik COBISS.SI"
bib1814	http://id.loc.gov/vocabulary/subjectSchemes/bib1814	1814-bibliografi: emneord for 1814-bibliografi	"no"=>"1814-bibliografi: emneord for 1814-bibliografi"
bjornson	http://id.loc.gov/vocabulary/subjectSchemes/bjornson	Bjornson: emneord for Bjornsonbibliografien	"no"=>"Bjornson: emneord for Bjornsonbibliografien"
liito	http://id.loc.gov/vocabulary/subjectSchemes/liito	LIITO - Liiketoimintaontologia	"fi"=>"LIITO - Liiketoimintaontologia"
apaist	http://id.loc.gov/vocabulary/subjectSchemes/apaist	APAIS thesaurus: a list of subject terms used in the Australian Public Affairs Information Service	
itglit	http://id.loc.gov/vocabulary/subjectSchemes/itglit	International thesaurus of gay and lesbian index terms (Chicago?: Thesaurus Committee, Gay and Lesbian Task Force, American Library Association)	
ntcsd	http://id.loc.gov/vocabulary/subjectSchemes/ntcsd	"National Translations Center secondary descriptors" in National Translation Center primary subject classification and secondary descriptor	
scisshl	http://id.loc.gov/vocabulary/subjectSchemes/scisshl	SCIS subject headings	
opms	http://id.loc.gov/vocabulary/subjectSchemes/opms	Opetusministeri????n asiasanasto	"fi"=>"Opetusministeri????n asiasanasto"
ttka	http://id.loc.gov/vocabulary/subjectSchemes/ttka	Teologisen tiedekunnan kirjaston asiasanasto	"fi"=>"Teologisen tiedekunnan kirjaston asiasanasto"
watrest	http://id.loc.gov/vocabulary/subjectSchemes/watrest	Thesaurus of water resources terms: a collection of water resources and related terms for use in indexing technical information	
ysa	http://id.loc.gov/vocabulary/subjectSchemes/ysa	Yleinen suomalainen asiasanasto	"fi"=>"Yleinen suomalainen asiasanasto"
kitu	http://id.loc.gov/vocabulary/subjectSchemes/kitu	Kirjallisuudentutkimuksen asiasanasto	"fi"=>"Kirjallisuudentutkimuksen asiasanasto"
sk	http://id.loc.gov/vocabulary/subjectSchemes/sk	'Zhong guo gu ji shan ban shu zong mu' fen lei biao	"zh"=>"'Zhong guo gu ji shan ban shu zong mu' fen lei biao"
aiatsisp	http://id.loc.gov/vocabulary/subjectSchemes/aiatsisp	AIATSIS place thesaurus	
ram	http://id.loc.gov/vocabulary/subjectSchemes/ram	RAMEAU: r????pertoire d'authorit???? de mati????res encyclop????dique unifi????	"fr"=>"RAMEAU: r????pertoire d'authorit???? de mati????res encyclop????dique unifi????"
aedoml	http://id.loc.gov/vocabulary/subjectSchemes/aedoml	Listado de encabezamientos de materia de m????sica	"es"=>"Listado de encabezamientos de materia de m????sica"
ated	http://id.loc.gov/vocabulary/subjectSchemes/ated	Australian Thesaurus of Education Descriptors (ATED)	
cabt	http://id.loc.gov/vocabulary/subjectSchemes/cabt	CAB thesaurus (Slough [England]: Commonwealth Agricultural Bureaux)	
kassu	http://id.loc.gov/vocabulary/subjectSchemes/kassu	Kassu - Kasvien suomenkieliset nimet	"fi"=>"Kassu - Kasvien suomenkieliset nimet"
nbdbt	http://id.loc.gov/vocabulary/subjectSchemes/nbdbt	NBD Biblion Trefwoordenthesaurus	"nl"=>"NBD Biblion Trefwoordenthesaurus"
jhpb	http://id.loc.gov/vocabulary/subjectSchemes/jhpb	J????zyk hase???? przedmiotowych Biblioteki Narodowej	"pl"=>"J????zyk hase???? przedmiotowych Biblioteki Narodowej"
bidex	http://id.loc.gov/vocabulary/subjectSchemes/bidex	Bilindex: a bilingual Spanish-English subject heading list	
ccsa	http://id.loc.gov/vocabulary/subjectSchemes/ccsa	Catalogue collectif suisse des affiches	"fr"=>"Catalogue collectif suisse des affiches"
noraf	http://id.loc.gov/vocabulary/subjectSchemes/noraf	Norwegian Authority File	
kito	http://id.loc.gov/vocabulary/subjectSchemes/kito	KITO - Kirjallisuudentutkimuksen ontologia	"fi"=>"KITO - Kirjallisuudentutkimuksen ontologia"
tho	http://id.loc.gov/vocabulary/subjectSchemes/tho	Thesauros Hell????nik????n Oron	"el"=>"Thesauros Hell????nik????n Oron"
pmont	http://id.loc.gov/vocabulary/subjectSchemes/pmont	Powerhouse Museum Object Name Thesaurus	
ssg	http://id.loc.gov/vocabulary/subjectSchemes/ssg	Splo????ni slovenski geslovnik	"sl"=>"Splo????ni slovenski geslovnik"
huc	http://id.loc.gov/vocabulary/subjectSchemes/huc	U.S. Geological Survey water-supply paper 2294: hydrologic basins unit codes	
isis	http://id.loc.gov/vocabulary/subjectSchemes/isis	"Classification scheme" in Isis	
ibsen	http://id.loc.gov/vocabulary/subjectSchemes/ibsen	Ibsen: emneord for Den internasjonale Ibsen-bibliografien	"no"=>"Ibsen: emneord for Den internasjonale Ibsen-bibliografien"
lacnaf	http://id.loc.gov/vocabulary/subjectSchemes/lacnaf	Library and Archives Canada name authority file	
swemesh	http://id.loc.gov/vocabulary/subjectSchemes/swemesh	Swedish MeSH	"sv"=>"Svenska MeSH"
hamsun	http://id.loc.gov/vocabulary/subjectSchemes/hamsun	Hamsun: emneord for Hamsunbibliografien	"no"=>"Hamsun: emneord for Hamsunbibliografien"
qrma	http://id.loc.gov/vocabulary/subjectSchemes/qrma	List of Arabic subject headings	"ar"=>"Q????'imat ru'????s al-mawd????????t al-'Arab????yah"
qrmak	http://id.loc.gov/vocabulary/subjectSchemes/qrmak	Q????'imat ru'????s al-mawd????'????t al-'Arab????yah al-qiy????s????yah al-maktab????t wa-mar????kaz al-ma'l????m????t wa-qaw????id al-bay????n????t	"ar"=>"Q????'imat ru'????s al-mawd????'????t al-'Arab????yah al-qiy????s????yah al-maktab????t wa-mar????kaz al-ma'l????m????t wa-qaw????id al-bay????n????t"
ceeus	http://id.loc.gov/vocabulary/subjectSchemes/ceeus	Counties and equivalent entities of the United States its possessions, and associated areas	
taxhs	http://id.loc.gov/vocabulary/subjectSchemes/taxhs	A taxonomy or human services: a conceptual framework with standardized terminology and definitions for the field	
noram	http://id.loc.gov/vocabulary/subjectSchemes/noram	Noram: emneord for Norsk-amerikansk samling	"no"=>"Noram: emneord for Norsk-amerikansk samling"
eurovocfr	http://id.loc.gov/vocabulary/subjectSchemes/eurovocfr	Eurovoc thesaurus (French)	
jurivoc	http://id.loc.gov/vocabulary/subjectSchemes/jurivoc	JURIVOC	
agrifors	http://id.loc.gov/vocabulary/subjectSchemes/agrifors	AGRIFOREST-sanasto	"fi"=>"AGRIFOREST-sanasto"
noubojur	http://id.loc.gov/vocabulary/subjectSchemes/noubojur	Thesaurus of Law	"no"=>"Thesaurus of Law"
pha	http://id.loc.gov/vocabulary/subjectSchemes/pha	Puolostushallinnon asiasanasto	"fi"=>"Puolostushallinnon asiasanasto"
ddcrit	http://id.loc.gov/vocabulary/subjectSchemes/ddcrit	DDC retrieval and indexing terminology; posting terms with hierarchy and KWOC	
mar	http://id.loc.gov/vocabulary/subjectSchemes/mar	Merenkulun asiasanasto	"fi"=>"Merenkulun asiasanasto"
sbt	http://id.loc.gov/vocabulary/subjectSchemes/sbt	Soggettario Sistema Bibliotecario Ticinese	"it"=>"Soggettario Sistema Bibliotecario Ticinese"
nzggn	http://id.loc.gov/vocabulary/subjectSchemes/nzggn	New Zealand gazetteer of official geographic names (New Zealand Geographic Board Ng?? Pou Taunaha o Aotearoa (NZGB))	
kta	http://id.loc.gov/vocabulary/subjectSchemes/kta	Kielitieteen asiasanasto	"fi"=>"Kielitieteen asiasanasto"
snt	http://id.loc.gov/vocabulary/subjectSchemes/snt	Sexual nomenclature : a thesaurus	
francis	http://id.loc.gov/vocabulary/subjectSchemes/francis	FRANCIS database classification scheme	"fr"=>"Base de donne????s FRANCIS: plan de classement"
eurovocsl	http://id.loc.gov/vocabulary/subjectSchemes/eurovocsl	Eurovoc thesaurus	"sl"=>"Eurovoc thesaurus"
idszbzes	http://id.loc.gov/vocabulary/subjectSchemes/idszbzes	Thesaurus IDS Nebis Bibliothek Englisches Seminar der Universit????t Z????rich	"de"=>"Thesaurus IDS Nebis Bibliothek Englisches Seminar der Universit????t Z????rich"
nlmnaf	http://id.loc.gov/vocabulary/subjectSchemes/nlmnaf	National Library of Medicine name authority file	
rugeo	http://id.loc.gov/vocabulary/subjectSchemes/rugeo	Natsional'nyi normativnyi fail geograficheskikh nazvanii Rossiiskoi Federatsii	"ru"=>"Natsional'nyi normativnyi fail geograficheskikh nazvanii Rossiiskoi Federatsii"
sipri	http://id.loc.gov/vocabulary/subjectSchemes/sipri	SIPRI library thesaurus	
kkts	http://id.loc.gov/vocabulary/subjectSchemes/kkts	Katalogos Kathier????men????n Typ????n Syllogikou Katalogou Demosion Vivliothekon	"el"=>"Katalogos Kathier????men????n Typ????n Syllogikou Katalogou Demosion Vivliothekon"
tucua	http://id.loc.gov/vocabulary/subjectSchemes/tucua	Thesaurus for use in college and university archives	
pmbok	http://id.loc.gov/vocabulary/subjectSchemes/pmbok	Guide to the project management body of knowledge (PMBOK Guide)	
agrovoc	http://id.loc.gov/vocabulary/subjectSchemes/agrovoc	AGROVOC multilingual agricultural thesaurus	
nal	http://id.loc.gov/vocabulary/subjectSchemes/nal	National Agricultural Library subject headings	
lnmmbr	http://id.loc.gov/vocabulary/subjectSchemes/lnmmbr	Lietuvos nacionalines Martyno Mazvydo bibliotekos rubrikynas	"lt"=>"Lietuvos nacionalines Martyno Mazvydo bibliotekos rubrikynas"
vmj	http://id.loc.gov/vocabulary/subjectSchemes/vmj	Vedettes-mati????re jeunesse	"fr"=>"Vedettes-mati????re jeunesse"
ddcut	http://id.loc.gov/vocabulary/subjectSchemes/ddcut	Dewey Decimal Classification user terms	
eks	http://id.loc.gov/vocabulary/subjectSchemes/eks	Eduskunnan kirjaston asiasanasto	"fi"=>"Eduskunnan kirjaston asiasanasto"
wot	http://id.loc.gov/vocabulary/subjectSchemes/wot	A Women's thesaurus	
noubomn	http://id.loc.gov/vocabulary/subjectSchemes/noubomn	University of Oslo Library Thesaurus of Science	"no"=>"University of Oslo Library Thesaurus of Science"
idszbzzg	http://id.loc.gov/vocabulary/subjectSchemes/idszbzzg	Thesaurus IDS Nebis Zentralbibliothek Z????rich, Graphische Sammlung	"de"=>"Thesaurus IDS Nebis Zentralbibliothek Z????rich, Graphische Sammlung"
precis	http://id.loc.gov/vocabulary/subjectSchemes/precis	PRECIS: a manual of concept analysis and subject indexing	
cstud	http://id.loc.gov/vocabulary/subjectSchemes/cstud	Classificatieschema's Bibliotheek TU Delft	"nl"=>"Classificatieschema's Bibliotheek TU Delft"
nlgkk	http://id.loc.gov/vocabulary/subjectSchemes/nlgkk	Katalogos kathier????men????n onomat????n physik????n pros????p????n	"el"=>"Katalogos kathier????men????n onomat????n physik????n pros????p????n"
pmt	http://id.loc.gov/vocabulary/subjectSchemes/pmt	Project management terminology. Newtown Square, PA: Project Management Institute	
ericd	http://id.loc.gov/vocabulary/subjectSchemes/ericd	Thesaurus of ERIC descriptors	
rvm	http://id.loc.gov/vocabulary/subjectSchemes/rvm	R????pertoire de vedettes-mati????re	"fr"=>"R????pertoire de vedettes-mati????re"
sfit	http://id.loc.gov/vocabulary/subjectSchemes/sfit	Svenska filminstitutets tesaurus	"sv"=>"Svenska filminstitutets tesaurus"
trtsa	http://id.loc.gov/vocabulary/subjectSchemes/trtsa	Teatterin ja tanssin asiasanasto	"fi"=>"Teatterin ja tanssin asiasanasto"
ulan	http://id.loc.gov/vocabulary/subjectSchemes/ulan	Union list of artist names	
unescot	http://id.loc.gov/vocabulary/subjectSchemes/unescot	UNESCO thesaurus	"fr"=>"Th????saurus de l'UNESCO","es"=>"Tesauro de la UNESCO"
koko	http://id.loc.gov/vocabulary/subjectSchemes/koko	KOKO-ontologia	"fi"=>"KOKO-ontologia"
msh	http://id.loc.gov/vocabulary/subjectSchemes/msh	Trimboli, T., and Martyn S. Marianist subject headings	
trt	http://id.loc.gov/vocabulary/subjectSchemes/trt	Transportation resource thesaurus	
agrovocf	http://id.loc.gov/vocabulary/subjectSchemes/agrovocf	AGROVOC th????saurus agricole multilingue	"fr"=>"AGROVOC th????saurus agricole multilingue"
aucsh	http://id.loc.gov/vocabulary/subjectSchemes/aucsh	Arabic Union Catalog Subject Headings	"ar"=>"Q????'imat ru'????s mawd????'????t al-fahras al-'Arab????yah al-mowahad"
ddcri	http://id.loc.gov/vocabulary/subjectSchemes/ddcri	Dewey Decimal Classification Relative Index	
est	http://id.loc.gov/vocabulary/subjectSchemes/est	International energy: subject thesaurus (: International Energy Agency, Energy Technology Data Exchange)	
lua	http://id.loc.gov/vocabulary/subjectSchemes/lua	Liikunnan ja urheilun asiasanasto	"fi"=>"Liikunnan ja urheilun asiasanasto"
mipfesd	http://id.loc.gov/vocabulary/subjectSchemes/mipfesd	Macrothesaurus for information processing in the field of economic and social development	
rurkp	http://id.loc.gov/vocabulary/subjectSchemes/rurkp	Predmetnye rubriki Rossiiskoi knizhnoi palaty	"ru"=>"Predmetnye rubriki Rossiiskoi knizhnoi palaty"
albt	http://id.loc.gov/vocabulary/subjectSchemes/albt	Arbetslivsbibliotekets tesaurus	"sv"=>"Arbetslivsbibliotekets tesaurus"
fmesh	http://id.loc.gov/vocabulary/subjectSchemes/fmesh	Liste syst????matique et liste permut????e des descripteurs fran????ais MeSH	"fr"=>"Liste syst????matique et liste permut????e des descripteurs fran????ais MeSH"
bicssc	http://id.loc.gov/vocabulary/subjectSchemes/bicssc	BIC standard subject categories	
cctf	http://id.loc.gov/vocabulary/subjectSchemes/cctf	Carto-Canadiana th????saurus - Fran????ais	"fr"=>"Carto-Canadiana th????saurus - Fran????ais"
reo	http://id.loc.gov/vocabulary/subjectSchemes/reo	M??ori Subject Headings thesaurus	"mi"=>"Ng?? ????poko Tukutuku"
icpsr	http://id.loc.gov/vocabulary/subjectSchemes/icpsr	ICPSR controlled vocabulary system	
kao	http://id.loc.gov/vocabulary/subjectSchemes/kao	KVINNSAM ????mnesordsregister	"sv"=>"KVINNSAM ????mnesordsregister"
asrcseo	http://id.loc.gov/vocabulary/subjectSchemes/asrcseo	Australian Standard Research Classification: Socio-Economic Objective (SEO) classification	
georeft	http://id.loc.gov/vocabulary/subjectSchemes/georeft	GeoRef thesaurus	
cct	http://id.loc.gov/vocabulary/subjectSchemes/cct	Chinese Classified Thesaurus	"zh"=>"Zhong guo fen lei zhu ti ci biao"
dcs	http://id.loc.gov/vocabulary/subjectSchemes/dcs	Health Sciences Descriptors	"es"=>"Descriptores en Ciencias de la Salud","pt"=>"Descritores em Ci????ncias da Sa????de"
musa	http://id.loc.gov/vocabulary/subjectSchemes/musa	Musiikin asiasanasto: erikoissanasto	"fi"=>"Musiikin asiasanasto: erikoissanasto"
ntissc	http://id.loc.gov/vocabulary/subjectSchemes/ntissc	NTIS subject categories	
idszbz	http://id.loc.gov/vocabulary/subjectSchemes/idszbz	Thesaurus IDS Nebis Zentralbibliothek Z????rich	"de"=>"Thesaurus IDS Nebis Zentralbibliothek Z????rich"
tlka	http://id.loc.gov/vocabulary/subjectSchemes/tlka	Investigaci????, Proc????s T????cnicn kirjaston asiasanasto	"fi"=>"Investigaci????, Proc????s T????cnicn kirjaston asiasanasto"
usaidt	http://id.loc.gov/vocabulary/subjectSchemes/usaidt	USAID thesaurus: Keywords used to index documents included in the USAID Development Experience System.	
embne	http://id.loc.gov/vocabulary/subjectSchemes/embne	Encabezamientos de Materia de la Biblioteca Nacional de Espa????a	"es"=>"Encabezamientos de Materia de la Biblioteca Nacional de Espa????a"
vcaadu	http://id.loc.gov/vocabulary/subjectSchemes/vcaadu	Vocabulario controlado de arquitectura, arte, dise????o y urbanismo	"es"=>"Vocabulario controlado de arquitectura, arte, dise????o y urbanismo"
ntcpsc	http://id.loc.gov/vocabulary/subjectSchemes/ntcpsc	"National Translations Center primary subject classification" in National Translations Center primary subject classification and secondary descriptors	
quiding	http://id.loc.gov/vocabulary/subjectSchemes/quiding	Quiding, Nils Herman. Svenskt allm????nt f????rfattningsregister f????r tiden fr????n ????r 1522 till och med ????r 1862	"sv"=>"Quiding, Nils Herman. Svenskt allm????nt f????rfattningsregister f????r tiden fr????n ????r 1522 till och med ????r 1862"
allars	http://id.loc.gov/vocabulary/subjectSchemes/allars	All????rs: allm????n tesaurus p???? svenska	"fi"=>"All????rs: allm????n tesaurus p???? svenska"
ogst	http://id.loc.gov/vocabulary/subjectSchemes/ogst	Oregon GILS Subject Tree (Oregon: Oregon State Library and Oregon Information Resource Management Division (IRMD))	
bella	http://id.loc.gov/vocabulary/subjectSchemes/bella	Bella: specialtesaurus f????r sk????nlitteratur	"fi"=>"Bella: specialtesaurus f????r sk????nlitteratur"
bibalex	http://id.loc.gov/vocabulary/subjectSchemes/bibalex	Bibliotheca Alexandrina name and subject authority file	
pepp	http://id.loc.gov/vocabulary/subjectSchemes/pepp	The Princeton encyclopedia of poetry and poetics	
hkcan	http://id.loc.gov/vocabulary/subjectSchemes/hkcan	Hong Kong Chinese Authority File (Name) - HKCAN	
dissao	http://id.loc.gov/vocabulary/subjectSchemes/dissao	"Dissertation abstracts online" in Search tools: the guide to UNI/Data Courier Online	
ltcsh	http://id.loc.gov/vocabulary/subjectSchemes/ltcsh	Land Tenure Center Library list of subject headings	
mpirdes	http://id.loc.gov/vocabulary/subjectSchemes/mpirdes	Macrothesaurus para el procesamiento de la informaci????n relativa al desarrollo econ????mico y social	"es"=>"Macrothesaurus para el procesamiento de la informaci????n relativa al desarrollo econ????mico y social"
asft	http://id.loc.gov/vocabulary/subjectSchemes/asft	Aquatic sciences and fisheries thesaurus	
naf	http://id.loc.gov/vocabulary/subjectSchemes/naf	NACO authority file	
nimacsc	http://id.loc.gov/vocabulary/subjectSchemes/nimacsc	NIMA cartographic subject categories	
khib	http://id.loc.gov/vocabulary/subjectSchemes/khib	Emneord, KHiB Biblioteket	"no"=>"Emneord, KHiB Biblioteket"
cdcng	http://id.loc.gov/vocabulary/subjectSchemes/cdcng	Catalogage des documents cartographiques: forme et structure des vedettes noms g????ographiques - NF Z 44-081	"fr"=>"Catalogage des documents cartographiques: forme et structure des vedettes noms g????ographiques - NF Z 44-081"
afset	http://id.loc.gov/vocabulary/subjectSchemes/afset	American Folklore Society Ethnographic Thesaurus	
erfemn	http://id.loc.gov/vocabulary/subjectSchemes/erfemn	Erfaringskompetanses emneord	"no"=>"Erfaringskompetanses emneord"
sbiao	http://id.loc.gov/vocabulary/subjectSchemes/sbiao	Svenska barnboksinstitutets ????mnesordslista	"sv"=>"Svenska barnboksinstitutets ????mnesordslista"
socio	http://id.loc.gov/vocabulary/subjectSchemes/socio	Sociological Abstracts Thesaurus	
bisacrt	http://id.loc.gov/vocabulary/subjectSchemes/bisacrt	BISAC Regional Themes	
eum	http://id.loc.gov/vocabulary/subjectSchemes/eum	Eesti uldine m????rksonastik	"et"=>"Eesti uldine m????rksonastik"
kula	http://id.loc.gov/vocabulary/subjectSchemes/kula	Kulttuurien tutkimuksen asiasanasto	"fi"=>"Kulttuurien tutkimuksen asiasanasto"
odlt	http://id.loc.gov/vocabulary/subjectSchemes/odlt	Baldick, C. The Oxford dictionary of literary terms	
rerovoc	http://id.loc.gov/vocabulary/subjectSchemes/rerovoc	Indexation mati????res RERO autorit????s	"fr"=>"Indexation mati????res RERO autorit????s"
tsr	http://id.loc.gov/vocabulary/subjectSchemes/tsr	TSR-ontologia	"fi"=>"TSR-ontologia"
czmesh	http://id.loc.gov/vocabulary/subjectSchemes/czmesh	Czech MeSH	"cs"=>"Czech MeSH"
dltt	http://id.loc.gov/vocabulary/subjectSchemes/dltt	Quinn, E. A dictionary of literary and thematic terms	
idsbb	http://id.loc.gov/vocabulary/subjectSchemes/idsbb	Thesaurus IDS Basel Bern	"de"=>"Thesaurus IDS Basel Bern"
inist	http://id.loc.gov/vocabulary/subjectSchemes/inist	INIS: thesaurus	
idszbzzk	http://id.loc.gov/vocabulary/subjectSchemes/idszbzzk	Thesaurus IDS Nebis Zentralbibliothek Z????rich, Kartensammlung	"de"=>"Thesaurus IDS Nebis Zentralbibliothek Z????rich, Kartensammlung"
tesa	http://id.loc.gov/vocabulary/subjectSchemes/tesa	Tesauro Agr????cola	"es"=>"Tesauro Agr????cola"
liv	http://id.loc.gov/vocabulary/subjectSchemes/liv	Legislative indexing vocabulary	
collett	http://id.loc.gov/vocabulary/subjectSchemes/collett	Collett-bibliografi: litteratur av og om Camilla Collett	"no"=>"Collett-bibliografi: litteratur av og om Camilla Collett"
nsbncf	http://id.loc.gov/vocabulary/subjectSchemes/nsbncf	Nuovo Soggettario	"it"=>"Nuovo Soggettario"
ipat	http://id.loc.gov/vocabulary/subjectSchemes/ipat	IPA thesaurus and frequency list	
skon	http://id.loc.gov/vocabulary/subjectSchemes/skon	Att indexera sk????nlitteratur: ????mnesordslista, vuxenlitteratur	"sv"=>"Att indexera sk????nlitteratur: ????mnesordslista, vuxenlitteratur"
renib	http://id.loc.gov/vocabulary/subjectSchemes/renib	Renib	"es"=>"Renib"
hrvmesh	http://id.loc.gov/vocabulary/subjectSchemes/hrvmesh	Croatian MeSH / Hrvatski MeSH	"no"=>"Croatian MeSH / Hrvatski MeSH"
swd	http://id.loc.gov/vocabulary/subjectSchemes/swd	Schlagwortnormdatei	"de"=>"Schlagwortnormdatei"
aass	http://id.loc.gov/vocabulary/subjectSchemes/aass	"Asian American Studies Library subject headings" in A Guide for establishing Asian American core collections	
cht	http://id.loc.gov/vocabulary/subjectSchemes/cht	Chicano thesaurus for indexing Chicano materials in Chicano periodical index	
galestne	http://id.loc.gov/vocabulary/subjectSchemes/galestne	Gale Group subject thesaurus and named entity vocabulary	
nlgsh	http://id.loc.gov/vocabulary/subjectSchemes/nlgsh	Katalogos Hell????nik????n thematik????n epikephalid????n	"el"=>"Katalogos Hell????nik????n thematik????n epikephalid????n"
hoidokki	http://id.loc.gov/vocabulary/subjectSchemes/hoidokki	Hoitotieteellinen asiasanasto	
vffyl	http://id.loc.gov/vocabulary/subjectSchemes/vffyl	Vocabulario de la Biblioteca Central de la FFyL	"es"=>"Vocabulario de la Biblioteca Central de la FFyL"
kubikat	http://id.loc.gov/vocabulary/subjectSchemes/kubikat	kubikat	"de"=>"kubikat"
waqaf	http://id.loc.gov/vocabulary/subjectSchemes/waqaf	Maknas Uloom Al Waqaf	"ar"=>"Maknas Uloom Al Waqaf"
hapi	http://id.loc.gov/vocabulary/subjectSchemes/hapi	HAPI thesaurus and name authority, 1970-2000	
drama	http://id.loc.gov/vocabulary/subjectSchemes/drama	Drama: specialtesaurus f????r teater och dans	
sosa	http://id.loc.gov/vocabulary/subjectSchemes/sosa	Sociaalialan asiasanasto	"fi"=>"Sociaalialan asiasanasto"
ilpt	http://id.loc.gov/vocabulary/subjectSchemes/ilpt	Index to legal periodicals: thesaurus	
nicem	http://id.loc.gov/vocabulary/subjectSchemes/nicem	NICEM subject headings and classification system	
qlsp	http://id.loc.gov/vocabulary/subjectSchemes/qlsp	Queens Library Spanish language subject headings	
eet	http://id.loc.gov/vocabulary/subjectSchemes/eet	European education thesaurus	
nalnaf	http://id.loc.gov/vocabulary/subjectSchemes/nalnaf	National Agricultural Library name authority file	
eclas	http://id.loc.gov/vocabulary/subjectSchemes/eclas	ECLAS thesaurus	
agrovocs	http://id.loc.gov/vocabulary/subjectSchemes/agrovocs	AGROVOC tesauro agr????cola multiling????e	"es"=>"AGROVOC tesauro agr????cola multiling????e"
shbe	http://id.loc.gov/vocabulary/subjectSchemes/shbe	Subject headings in business and economics	"sv"=>"Subject headings in business and economics"
barn	http://id.loc.gov/vocabulary/subjectSchemes/barn	Svenska ????mnesord f????r barn	"sv"=>"Svenska ????mnesord f????r barn"
bhammf	http://id.loc.gov/vocabulary/subjectSchemes/bhammf	BHA, Bibliographie d'histoire de l'art, mots-mati????re/fran????ais	"fr"=>"BHA, Bibliographie d'histoire de l'art, mots-mati????re/fran????ais"
gccst	http://id.loc.gov/vocabulary/subjectSchemes/gccst	Government of Canada core subject thesaurus (Gatineau : Library and Archives Canada)	
fnhl	http://id.loc.gov/vocabulary/subjectSchemes/fnhl	First Nations House of Learning Subject Headings	
kauno	http://id.loc.gov/vocabulary/subjectSchemes/kauno	KAUNO - Kaunokki-ontologin	"fi"=>"KAUNO - Kaunokki-ontologin"
dtict	http://id.loc.gov/vocabulary/subjectSchemes/dtict	Defense Technical Information Center thesaurus	
mech	http://id.loc.gov/vocabulary/subjectSchemes/mech	Iskanje po zbirki MECH	"sl"=>"Iskanje po zbirki MECH"
jupo	http://id.loc.gov/vocabulary/subjectSchemes/jupo	JUPO - Julkisen hallinnon palveluontologia	"fi"=>"JUPO - Julkisen hallinnon palveluontologia"
ktpt	http://id.loc.gov/vocabulary/subjectSchemes/ktpt	Kirjasto- ja tietopalvelualan tesaurus	"fi"=>"Kirjasto- ja tietopalvelualan tesaurus"
aiatsiss	http://id.loc.gov/vocabulary/subjectSchemes/aiatsiss	AIATSIS subject Thesaurus	
lcac	http://id.loc.gov/vocabulary/subjectSchemes/lcac	Library of Congress Annotated Children's Cataloging Program subject headings	
lemac	http://id.loc.gov/vocabulary/subjectSchemes/lemac	Llista d'encap????alaments de mat????ria en catal????	"ca"=>"Llista d'encap????alaments de mat????ria en catal????"
lemb	http://id.loc.gov/vocabulary/subjectSchemes/lemb	Lista de encabezamientos de materia para bibliotecas	"es"=>"Lista de encabezamientos de materia para bibliotecas"
henn	http://id.loc.gov/vocabulary/subjectSchemes/henn	Hennepin County Library cumulative authority list	
mtirdes	http://id.loc.gov/vocabulary/subjectSchemes/mtirdes	Macroth????saurus pour le traitement de l'information relative au d????veloppement ????conomique et social	"fr"=>"Macroth????saurus pour le traitement de l'information relative au d????veloppement ????conomique et social"
cash	http://id.loc.gov/vocabulary/subjectSchemes/cash	Canadian subject headings	
nznb	http://id.loc.gov/vocabulary/subjectSchemes/nznb	New Zealand national bibliographic	
prvt	http://id.loc.gov/vocabulary/subjectSchemes/prvt	Patent- och registreringsverkets tesaurus	"sv"=>"Patent- och registreringsverkets tesaurus"
scgdst	http://id.loc.gov/vocabulary/subjectSchemes/scgdst	Subject categorization guide for defense science and technology	
gem	http://id.loc.gov/vocabulary/subjectSchemes/gem	GEM controlled vocabularies	
lcsh	http://id.loc.gov/vocabulary/subjectSchemes/lcsh	Library of Congress subject headings	
rero	http://id.loc.gov/vocabulary/subjectSchemes/rero	Indexation matires RERO	"fr"=>"Indexation matires RERO"
peri	http://id.loc.gov/vocabulary/subjectSchemes/peri	Perinnetieteiden asiasanasto	"fi"=>"Perinnetieteiden asiasanasto"
shsples	http://id.loc.gov/vocabulary/subjectSchemes/shsples	Encabezamientos de materia para bibliotecas escolares y p????blicas	"es"=>"Encabezamientos de materia para bibliotecas escolares y p????blicas"
slem	http://id.loc.gov/vocabulary/subjectSchemes/slem	Sears: lista de encabezamientos de materia	"es"=>"Sears: lista de encabezamientos de materia"
afo	http://id.loc.gov/vocabulary/subjectSchemes/afo	AFO - Viikin kampuskirjaston ontologia	"fi"=>"AFO - Viikin kampuskirjaston ontologia"
gst	http://id.loc.gov/vocabulary/subjectSchemes/gst	Gay studies thesaurus: a controlled vocabulary for indexing and accessing materials of relevance to gay culture, history, politics and psychology	
hlasstg	http://id.loc.gov/vocabulary/subjectSchemes/hlasstg	HLAS subject term glossary	
iest	http://id.loc.gov/vocabulary/subjectSchemes/iest	International energy: subject thesaurus	
pkk	http://id.loc.gov/vocabulary/subjectSchemes/pkk	Predmetnik za katoli????ke knji????nice	"sl"=>"Predmetnik za katoli????ke knji????nice"
atla	http://id.loc.gov/vocabulary/subjectSchemes/atla	Religion indexes: thesaurus	
scot	http://id.loc.gov/vocabulary/subjectSchemes/scot	Schools Online Thesaurus (ScOT)	
smda	http://id.loc.gov/vocabulary/subjectSchemes/smda	Smithsonian National Air and Space Museum Directory of Airplanes	
solstad	http://id.loc.gov/vocabulary/subjectSchemes/solstad	Solstad: emneord for Solstadbibliografien	"no"=>"Solstad: emneord for Solstadbibliografien"
abne	http://id.loc.gov/vocabulary/subjectSchemes/abne	Autoridades de la Biblioteca Nacional de Espa????a	"es"=>"Autoridades de la Biblioteca Nacional de Espa????a"
spines	http://id.loc.gov/vocabulary/subjectSchemes/spines	Tesauro SPINES: un vocabulario controlado y estructurado para el tratamiento de informaci????n sobre ciencia y tecnolog????a para el desarrollo	"es"=>"Tesauro SPINES: un vocabulario controlado y estructurado para el tratamiento de informaci????n sobre ciencia y tecnolog????a para el desarrollo"
ktta	http://id.loc.gov/vocabulary/subjectSchemes/ktta	K????si - ja taideteollisuuden asiasanasto	"fi"=>"K????si - ja taideteollisuuden asiasanasto"
ccte	http://id.loc.gov/vocabulary/subjectSchemes/ccte	Carto-Canadiana thesaurus - English	
pmcsg	http://id.loc.gov/vocabulary/subjectSchemes/pmcsg	Combined standards glossary	
bisacsh	http://id.loc.gov/vocabulary/subjectSchemes/bisacsh	BISAC Subject Headings	
fssh	http://id.loc.gov/vocabulary/subjectSchemes/fssh	FamilySearch Subject Headings (FamilySearch)	
tasmas	http://id.loc.gov/vocabulary/subjectSchemes/tasmas	Tesaurus de Asuntos Sociales del Ministerio de Asuntos Sociales de Espa????a	"es"=>"Tesaurus de Asuntos Sociales del Ministerio de Asuntos Sociales de Espa????a"
tero	http://id.loc.gov/vocabulary/subjectSchemes/tero	TERO - Terveyden ja hyvinvoinnin ontologia	"fi"=>"TERO - Terveyden ja hyvinvoinnin ontologia"
rma	http://id.loc.gov/vocabulary/subjectSchemes/rma	Ru'us al-mawdu'at al-'Arabiyah	"ar"=>"Ru'us al-mawdu'at al-'Arabiyah"
tgn	http://id.loc.gov/vocabulary/subjectSchemes/tgn	Getty thesaurus of geographic names	
tha	http://id.loc.gov/vocabulary/subjectSchemes/tha	Barcala de Moyano, Graciela G., Cristina Voena. Tesauro de Historia Argentina	"es"=>"Barcala de Moyano, Graciela G., Cristina Voena. Tesauro de Historia Argentina"
ttll	http://id.loc.gov/vocabulary/subjectSchemes/ttll	Roggau, Zunilda. Tell. Tesauro de lengua y literatura	"es"=>"Roggau, Zunilda. Tell. Tesauro de lengua y literatura"
sears	http://id.loc.gov/vocabulary/subjectSchemes/sears	Sears list of subject headings	
csht	http://id.loc.gov/vocabulary/subjectSchemes/csht	Chinese subject headings	
\.

-- ' ...blah

INSERT INTO authority.thesaurus (code, uri, name, control_set)
  SELECT code, uri, name, 1 FROM thesauri;

UPDATE authority.thesaurus SET short_code = 'a' WHERE code = 'lcsh';
UPDATE authority.thesaurus SET short_code = 'b' WHERE code = 'lcshac';
UPDATE authority.thesaurus SET short_code = 'c' WHERE code = 'mesh';
UPDATE authority.thesaurus SET short_code = 'd' WHERE code = 'nal';
UPDATE authority.thesaurus SET short_code = 'k' WHERE code = 'cash';
UPDATE authority.thesaurus SET short_code = 'r' WHERE code = 'aat';
UPDATE authority.thesaurus SET short_code = 's' WHERE code = 'sears';
UPDATE authority.thesaurus SET short_code = 'v' WHERE code = 'rvm';

UPDATE  authority.thesaurus
  SET   short_code = 'z'
  WHERE short_code IS NULL
        AND control_set = 1;

INSERT INTO config.i18n_core (fq_field, identity_value, translation, string )
  SELECT  'at.name', t.code, xlate->key, xlate->value
    FROM  thesauri t
          JOIN LATERAL each(t.xlate) AS xlate ON TRUE
    WHERE NOT EXISTS
            (SELECT id
              FROM  config.i18n_core
              WHERE fq_field = 'at.name'
                    AND identity_value = t.code
                    AND translation = xlate->key)
          AND t.xlate IS NOT NULL
          AND t.name <> (xlate->value);

CREATE OR REPLACE FUNCTION authority.extract_thesaurus( marcxml TEXT ) RETURNS TEXT AS $func$
DECLARE
    thes_code TEXT;
BEGIN
    thes_code := vandelay.marc21_extract_fixed_field(marcxml,'Subj');
    IF thes_code IS NULL THEN
        thes_code := '|';
    ELSIF thes_code = 'z' THEN
        thes_code := COALESCE( oils_xpath_string('//*[@tag="040"]/*[@code="f"][1]', marcxml), 'z' );
    ELSE
        SELECT code INTO thes_code FROM authority.thesaurus WHERE short_code = thes_code;
        IF NOT FOUND THEN
            thes_code := '|'; -- default
        END IF;
    END IF;
    RETURN thes_code;
END;
$func$ LANGUAGE PLPGSQL STABLE STRICT;

CREATE OR REPLACE FUNCTION authority.map_thesaurus_to_control_set () RETURNS TRIGGER AS $func$
BEGIN
    IF NEW.control_set IS NULL THEN
        SELECT control_set INTO NEW.control_set
        FROM authority.thesaurus
        WHERE code = authority.extract_thesaurus(NEW.marc);
    END IF;

    RETURN NEW;
END;
$func$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION authority.reingest_authority_rec_descriptor( auth_id BIGINT ) RETURNS VOID AS $func$
BEGIN
    DELETE FROM authority.rec_descriptor WHERE record = auth_id;
    INSERT INTO authority.rec_descriptor (record, record_status, encoding_level, thesaurus)
        SELECT  auth_id,
                vandelay.marc21_extract_fixed_field(marc,'RecStat'),
                vandelay.marc21_extract_fixed_field(marc,'ELvl'),
                authority.extract_thesaurus(marc)
          FROM  authority.record_entry
          WHERE id = auth_id;
    RETURN;
END;
$func$ LANGUAGE PLPGSQL;

COMMIT;

