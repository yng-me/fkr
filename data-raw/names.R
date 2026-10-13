# Builds R/sysdata.rda: the internal, non-exported name lookup tables used
# by fkr_first_name(), fkr_last_name(), and fkr_full_name().
#
# Sources (public, aggregate name-frequency/reference data -- no personal
# records):
#   * First names: tagaloglang.com's Filipino baby name glossary, fetched
#     per starting letter (A-Z), https://www.tagaloglang.com/popular-filipino-baby-names-<letter>/
#   * Surnames: Forebears.io's Philippines surname frequency ranking
#     (ranks 1-1000), as mirrored by
#     https://baguiocityguide.com/how-common-is-your-last-name-here-are-the-top-1000-filipino-surnames/
#     Rank order is preserved so fkr_last_name() can weight common
#     surnames (dela Cruz, Garcia, Reyes, ...) more heavily than rare
#     ones, instead of sampling all 1000+ surnames uniformly.
#
# Re-run this script (source("data-raw/names.R") from the package root)
# whenever the lookup tables need to be refreshed; it regenerates
# R/sysdata.rda.

# ---- First names, scraped A-Z -----------------------------------------

male_raw <- c(
  # A
  "Aaron", "Abraham", "Adonis", "Adrian", "Agapito", "Agustin", "Alan", "Albert",
  "Alberto", "Alden", "Aldwin", "Alejandro", "Alex", "Alexander", "Alfonso", "Allan",
  "Alvin", "Amado", "Ambrosio", "Andres", "Angelo", "Anthony", "Antonio", "Apolinario",
  "Aquilino", "Aric", "Ariel", "Armand", "Armando", "Arnel", "Arnold", "Arnulfo",
  "Aron", "Arthur", "Arturo", "Arwin", "Aurelio", "Avelino", "Arby",
  # B
  "Bayani", "Baltazar", "Balagtas", "Bartolome", "Bienvenido", "Basilio", "Bernard",
  "Baron", "Basil", "Belticezar", "Benedict", "Benigno", "Benjamin", "Bernardo",
  "Blue", "Brando", "Brandon", "Bryan", "Bonifacio",
  # C
  "Crisanto", "Cesar", "Calvin", "Casimiro", "Carl", "Carlo", "Carlos", "Cedric",
  "Charles", "Chester", "Christian", "Christopher", "Claudio", "Cyrus",
  # D
  "Danilo", "Damien", "Daniel", "Dante", "Darius", "Darryl", "Darwin", "David",
  "Dean", "Deither", "Dennis", "Denzel", "Devon", "Dewey", "Dexter", "Diego",
  "Dionicio", "Dino", "Diwa", "Domingo", "Dominic", "Dominick", "Donald", "Donato",
  "Douglas", "Drew", "Dustin", "Dylan",
  # E
  "Edgardo", "Eduardo", "Engilbert", "Ernesto", "Earl", "Edgar", "Edison", "Edmund",
  "Edric", "Edsel", "Edward", "Edwin", "Efren", "Elias", "Elijah", "Eliseo", "Elmer",
  "Emmanuel", "Emerson", "Emil", "Emilio", "Enrico", "Enrique", "Epifanio", "Eric",
  "Erik", "Ermin", "Errol", "Ervin", "Erwin", "Esteban", "Ethan", "Eugene",
  "Eustaquio", "Everett",
  # F
  "Fermin", "Fabian", "Farrell", "Federico", "Feliciano", "Felipe", "Felix",
  "Ferdinand", "Fernando", "Francis", "Francisco", "Franco", "Francois", "Frank",
  "Franklin", "Frederick", "Fritz",
  # G
  "Gabby", "Gabriel", "Garfield", "Garrett", "Gary", "Gavino", "Gene", "Geoffrey",
  "George", "Geraldo", "Gerard", "Gerardo", "Geronimo", "Gerry", "Gian", "Gibson",
  "Gilbert", "Gilberto", "Gino", "Giovanni", "Glen", "Greg", "Gregorio", "Guillermo",
  "Gulliver", "Gustavo", "Guy",
  # H
  "Hagibis", "Hamlet", "Heherson", "Hilario", "Honesto", "Honorato", "Homobono",
  "Hansel", "Harold", "Harris", "Harvey", "Hayden", "Heath", "Hector", "Hendrix",
  "Henry", "Herbert", "Hercules", "Herman", "Hernando", "Hidalgo", "Hiram", "Homer",
  "Horace", "Howard", "Hubert", "Humberto",
  # I
  "Ian", "Ignacio", "Ignatius", "Ike", "Iman", "Ira", "Irving", "Irwin", "Isaac",
  "Isaiah", "Isandro", "Ishmael", "Isidro", "Israel", "Issay", "Ivan", "Ivory", "Isagani",
  # J
  "Jayden", "Jesus", "Joselito", "Jack", "Jackson", "Jacob", "Jaime", "Jake", "James",
  "Jared", "Jason", "Jasper", "Jay", "Jaybee", "Jaypee", "Jed", "Jedrek", "Jeff",
  "Jeffery", "Jefferson", "Jem", "Jeremiah", "Jeremy", "Jerod", "Jerome", "Jerson",
  "Jerry", "Jerwin", "Jethro", "Joemar", "Joey", "John", "Johnny", "Johnson", "Jomari",
  "Jonas", "Jonathan", "Joenel", "Jopet", "Jordan", "Jorge", "Jory", "Jose", "Joseph",
  "Joshua", "Jovan", "Joven", "Jovie", "Jovit", "Juan", "Jude", "Judson", "Justin",
  # K
  "Karl", "Kevin", "Kelvin", "Kenneth", "Kendi", "Kent", "Kerwin", "Kobe", "Korbin", "Koren",
  # L
  "Lauro", "Liberato", "Lamar", "Lance", "Lancelot", "Lander", "Landon", "Laurence",
  "Lawrence", "Lazaro", "Lazarus", "Leander", "Leo", "Leobardo", "Leon", "Leonard",
  "Leonardo", "Leonidas", "Leopold", "Lester", "Lewis", "Liam", "Lionel", "Lloyd",
  "Logan", "Lou", "Louis", "Louie", "Luciano", "Lucio", "Lucky", "Luigi", "Luis",
  "Lukas", "Luke", "Luther",
  # M
  "Makisig", "Marcialito", "Modesto", "Manila", "Macario", "Mandy", "Manny", "Manolo",
  "Manuel", "Marc", "Marcel", "Marcelino", "Marco", "Marcos", "Marcus", "Mariano",
  "Mark", "Mars", "Marlon", "Martin", "Marvin", "Matthew", "Maurice", "Mauricio",
  "Max", "Maximo", "Maynard", "Melchor", "Melvin", "Mendel", "Mervin", "Michael",
  "Miguel", "Mikel", "Mohammed", "Moises", "Morgan", "Moses", "Muhammad", "Myron",
  # N
  "Narciso", "Nate", "Nathan", "Nathaniel", "Neal", "Neil", "Nelson", "Nemesio",
  "Nero", "Nestor", "Nicholai", "Nicholas", "Nick", "Nicklaus", "Nico", "Nicodemus",
  "Nicolas", "Niel", "Nigel", "Niles", "Nimrod", "Nixon", "Noah", "Noel", "Nolan",
  "Noland", "Norbert", "Norman", "Norton", "Nuncio",
  # O
  "Octavio", "Octavo", "Ogie", "Oliver", "Omar", "Omarion", "Onofre", "Orestes",
  "Oriel", "Orion", "Orlando", "Osborn", "Oscar", "Osmond", "Osmundo", "Owen",
  # P
  "Pacifico", "Pablo", "Paco", "Palmer", "Paolo", "Pascual", "Patrick", "Paul",
  "Pedro", "Percival", "Percy", "Perfecto", "Perry", "Peter", "Pharell", "Philemon",
  "Philip", "Phillip", "Pierce", "Pierre", "Placido", "Plato", "Porter", "Price",
  "Pryce", "Primo", "Prince", "Ptolemy", "Pax", "Phoenix", "Piper", "Presley",
  # Q
  "Qamar", "Quade", "Quana", "Quasim", "Quentin", "Quintin", "Quin", "Quinn",
  "Quincy", "Quinlan", "Quinto", "Quito", "Qwin",
  # R
  "Restituto", "Rizalino", "Rosauro", "Rosito", "Rupert", "Rael", "Rafael", "Rafi",
  "Rainer", "Raja", "Ralph", "Ram", "Ramil", "Ramiro", "Ramon", "Ramses", "Randolph",
  "Raphael", "Raul", "Raymond", "Raymundo", "Rayner", "Redentor", "Redford", "Rejay",
  "Reginald", "Remington", "Remus", "Renato", "Rene", "Rex", "Rexford", "Rey",
  "Reynaldo", "Reynante", "Reynard", "Reza", "Rian", "Ricardo", "Ricci", "Richard",
  "Richmond", "Ricky", "Rico", "Ripley", "Rob", "Robbie", "Robert", "Roberto",
  "Robin", "Robinson", "Rocco", "Rock", "Rocky", "Roderick", "Rodinel", "Rodolfo",
  "Rodrigo", "Rogelio", "Roger", "Rohan", "Roland", "Rolando", "Roman", "Rome",
  "Romeo", "Rommel", "Romney", "Romy", "Ron", "Ronald", "Ronaldo", "Ronan", "Ronnie",
  "Roosevelt", "Ross", "Rowan", "Rowell", "Royce", "Ruben", "Rudolph", "Rudy",
  "Russell", "Rusty", "Ryan",
  # S
  "Sam", "Samson", "Samuel", "Saturn", "Saul", "Scot", "Scott", "Sebastian", "Seth",
  "Seven", "Severino", "Shadow", "Shane", "Shaun", "Shawn", "Shaw", "Sheldon",
  "Sherlock", "Sherman", "Sherwin", "Sherwood", "Sid", "Sidney", "Simon", "Simeon",
  "Socrates", "Sol", "Solomon", "Sonny", "Soren", "Spencer", "Stanley", "Star",
  "Stefan", "Stephan", "Steven", "Stephen", "Steve", "Stewart", "Stuart", "Sylvester",
  # T
  "Taban", "Tadeo", "Tai", "Taite", "Tamir", "Ted", "Teddy", "Teenie", "Tenen", "Teo",
  "Terence", "Thaddeus", "Thane", "Thatcher", "Theo", "Theodore", "Teodulo", "Thomas",
  "Tom", "Thor", "Timothy", "Titus", "Tobias", "Toby", "Todd", "Toddy", "Tomas",
  "Tommy", "Topher", "Toren", "Travis", "Trent", "Trenton", "Trevor", "Tristan",
  "Tristian", "Troy", "Truman", "Tucker", "Tyler", "Tyrone", "Tyson",
  # U
  "Ulysses", "Umberto", "Urbano",
  # V
  "Val", "Valdemar", "Valentine", "Valentino", "Vance", "Varden", "Varian", "Varick",
  "Vern", "Verne", "Vernon", "Vice", "Vicente", "Victor", "Vidal", "Vidar", "Vijay",
  "Vince", "Vincent", "Vincenzo", "Virgil", "Vitalis", "Vito", "Vittorio", "Vlad",
  "Vladimir", "Von",
  # W
  "Walden", "Waldo", "Walker", "Wallace", "Walter", "Warner", "Warren", "Washington",
  "Watson", "Wayne", "Webster", "Weldon", "Wendell", "Wentworth", "Wesley", "Weston",
  "Wilbur", "Wilford", "Wilfred", "Wilkinson", "Willard", "William", "Wilmer",
  "Wilson", "Winfred", "Winston", "Wyatt",
  # X
  "Xadrian", "Xander", "Xandy", "Xannon", "Xavier", "Xenon", "Xenos", "Xylander",
  "Xylon",
  # Y
  "Yanni", "Yardan", "Yaron", "Yeriel", "Yonah", "York", "Yosef", "Yosefu", "Yuri",
  # Z
  "Zach", "Zander", "Zared", "Zed", "Zenon", "Zeus", "Zhander", "Zoren"
)

female_raw <- c(
  # A
  "Abigail", "Adriana", "Aileen", "Aira", "Aiza", "Amihan", "Amparo", "Aimee",
  "Alice", "Alicia", "Alma", "Althea", "Alyssa", "Amanda", "Amor", "Ana", "Analyn",
  "Andrea", "Angelica", "Angelie", "Angelina", "Anita", "Ann", "Annabelle", "Annie",
  "Apple", "April", "Arlene", "Athena", "Aurora", "Arislyne", "Angeleyh", "Ahtisa",
  # B
  "Barbara", "Belen", "Beatrice", "Belinda", "Benilda", "Bernadette", "Bernice",
  "Beryl", "Beverly", "Bianca", "Blanca", "Benedicta", "Bituin", "Bridget",
  "Bridgette", "Britany", "Britney", "Blessica",
  # C
  "Chesa", "Camille", "Caresse", "Carla", "Carol", "Carlota", "Carmela", "Carmelita",
  "Carmen", "Caroline", "Carolyn", "Cassandra", "Catherine", "Cathleen", "Cecilia",
  "Celeste", "Celia", "Celina", "Celine", "Chanda", "Charisse", "Charissa", "Charito",
  "Charlene", "Charmaine", "Charo", "Chelsa", "Chelsea", "Cherry", "Ciara", "Cielo",
  "Claire", "Clara", "Clarinda", "Clarissa", "Cleofe", "Concepcion", "Concesa",
  "Connie", "Consuelo", "Corazon", "Corina", "Crescentia", "Cristina", "Cybille",
  # D
  "Dalisay", "Daisy", "Danica", "Daniela", "Danielle", "Danika", "Daphne", "Daria",
  "Darlene", "Delila", "Demetria", "Denise", "Desiree", "Destiny", "Dian", "Diana",
  "Dina", "Dinah", "Diwata", "Dolores", "Dorotea", "Dorothy", "Dulce", "Darcel",
  "Dharma",
  # E
  "Estrellita", "Eugenia", "Edita", "Edith", "Editha", "Edna", "Elaine", "Eleanor",
  "Elenita", "Elizabeth", "Ellen", "Elvira", "Emmanuelle", "Emerald", "Emma",
  "Epiphany", "Esmeralda", "Esperanza", "Estefania", "Estrella", "Evelyn",
  # F
  "Faith", "Fanny", "Farrah", "Fatima", "Fay", "Fiona", "Flordeliza", "Florence",
  "Florentina", "Flory", "Fortuna", "Fortunata", "Franchesca", "Fuchsia",
  # G
  "Gabriela", "Gabrielle", "Garnet", "Gemma", "Genesis", "Geneva", "Genevieve",
  "Georgette", "Geraldine", "Gerphil", "Gertrude", "Gia", "Gilda", "Gina", "Giselle",
  "Glenda", "Gloria", "Godiva", "Grace", "Graciel", "Graciela", "Gretchen",
  "Guadalupe", "Gwen",
  # H
  "Hilaria", "Honorata", "Hannah", "Harmony", "Hazel", "Heaven", "Heidi", "Helen",
  "Henrietta", "Hero", "Hilda", "Holiday", "Honey", "Honoria", "Hope",
  # I
  "Ida", "Imelda", "Ina", "Indira", "Ines", "Inez", "Ingrid", "Inocencia", "Irene",
  "Iria", "Irina", "Iris", "Irma", "Isabel", "Isabelita", "Isadora", "Isla", "Ivana",
  "Ivette", "Ivie", "Ivy", "Iluminada",
  # J
  "Jesusa", "Jackie", "Jade", "Jacqueline", "Jamie", "Jane", "Janet", "Janeth",
  "Janice", "January", "Jasmin", "Jasmine", "Jaya", "Jemma", "Jennifer", "Jelena",
  "Jessa", "Jessica", "Jessie", "Jewel", "Jezebel", "Jezreel", "Jiselle", "Joan",
  "Jocelyn", "Jonell", "Josephine", "Jovita", "Joy", "Joyce", "Juana", "Juanita",
  "Judith", "Judy", "Julia", "Juliet", "Justine", "Juvie", "Juvy",
  # K
  "Karen", "Karla", "Kate", "Katherine", "Kathleen", "Kathy", "Katrina", "Kayla",
  "Kimberly", "Kendi", "Korrine", "Kourtney", "Kris", "Kriselda", "Kristin", "Kristina",
  # L
  "Laarni", "Ligaya", "Liwanag", "Liwayway", "Luwalhati", "Luningning", "Luzviminda",
  "Lacy", "Lani", "Lara", "Larisa", "Larissa", "Latifah", "Latoya", "Laura", "Laurel",
  "Lavender", "Lavina", "Lavinia", "Lea", "Leah", "Leona", "Leonor", "Leonora",
  "Lesley", "Leslie", "Leticia", "Lian", "Liliana", "Lily", "Linda", "Lindsay",
  "Lindsey", "Lisa", "Liza", "Lolita", "Lorelei", "Loren", "Lorena", "Loretta",
  "Lorretta", "Lori", "Lorie", "Lorna", "Lotlot", "Lotta", "Louisa", "Louise",
  "Lourdes", "Love", "Lovette", "Lovely", "Luciana", "Lucinda", "Lita", "Lulani",
  "Lulu", "Lumina", "Luna", "Lunet", "Lunette", "Lupe", "Lupita", "Luz", "Lydia",
  "Lynda", "Lynette", "Lynn", "Lyca", "Lyra",
  # M
  "Maganda", "Mahal", "Malaya", "Marikit", "Mutya", "Mabel", "Madelyn", "Maggie",
  "Magnolia", "Manuela", "Marcelina", "Margaret", "Margie", "Marjorie", "Margarita",
  "Mari", "Mary", "Maria", "Mariah", "Marian", "Marianne", "Maricar", "Marie",
  "Maribel", "Maribeth", "Mariel", "Marissa", "Marigold", "Marilyn", "Maritess",
  "Marlene", "Martha", "Martina", "Matet", "Maureen", "Maxine", "May", "Maya",
  "Megan", "Melania", "Melanie", "Melody", "Mercedes", "Mercy", "Merlita", "Mia",
  "Michaela", "Michelle", "Mitch", "Mila", "Milagros", "Mildred", "Mina", "Minerva",
  "Miranda", "Mirasol", "Miriam", "Modesty", "Monique", "Mulan", "Myra", "Myrna",
  "Mystery",
  # N
  "Nadia", "Nadine", "Nancy", "Nanette", "Natalia", "Natalie", "Nathalie",
  "Natividad", "Nenet", "Nenita", "Nerissa", "Nichole", "Nicole", "Nida", "Niel",
  "Nike", "Nikita", "Nikki", "Nikkol", "Nilda", "Ningning", "Nita", "Noemi",
  "Noymie", "Nola", "Nona", "Nora", "Noreen", "Norma", "Normandy", "November",
  # O
  "October", "Odelia", "Odessa", "Odette", "Ofelia", "Olive", "Olivia", "Olwen",
  "Olympia", "Opal", "Ophelia", "Oprah", "Orchid", "Orella", "Oriana", "Oriel",
  # P
  "Palma", "Paloma", "Pamela", "Pancho", "Paola", "Paquita", "Paris", "Patience",
  "Patrice", "Patricia", "Patsy", "Paula", "Paulette", "Pauline", "Paulina", "Paz",
  "Peaches", "Pearl", "Pearlie", "Pearly", "Pebbles", "Penelope", "Perlita",
  "Perpetua", "Petra", "Payton", "Philomena", "Phoebe", "Phoenix", "Phyliss",
  "Phyllis", "Pia", "Pierce", "Piper", "Portia", "Precious", "Presley", "Priscilla",
  "Prudence", "Purita", "Pax", "Porter",
  # Q
  "Qamra", "Qing", "Quanda", "Quasar", "Queenie", "Quiana", "Quin", "Quinn",
  "Quincy", "Quinlan", "Quinta", "Quintana", "Quintessa", "Quynh", "Qwara", "Qwin",
  # R
  "Richanee", "Rachael", "Rachel", "Rachelle", "Racquel", "Raisa", "Raquel",
  "Rebecca", "Reena", "Regina", "Remedios", "Renelee", "Reyna", "Rhea", "Rhezel",
  "Rhoda", "Rhona", "Riadel", "Rita", "Riva", "Rivera", "Rizalinda", "Rizalyn",
  "Roberta", "Rochelle", "Rona", "Ronda", "Rosa", "Rosaflor", "Rosalie", "Rosalinda",
  "Rosalyn", "Rosario", "Rose", "Rosemarie", "Rosenda", "Rosie", "Roxy", "Roxanne",
  "Rowan", "Rowena", "Ruby", "Rudylyn", "Ruffa", "Rufina", "Ruth", "Ryan",
  # S
  "Sabina", "Sahara", "Salome", "Salud", "Sam", "Samantha", "Sammy", "Sampaguita",
  "Sandra", "Sara", "Sarah", "Sarahlyn", "Serena", "Seven", "Severina", "Shadow",
  "Shakira", "Shane", "Shannon", "Sharlene", "Sharon", "Sharona", "Sheila", "Shiela",
  "Shelley", "Shelly", "Sheridan", "Sherri", "Sherry", "Shirley", "Siena", "Sienna",
  "Sinagtala", "Socorro", "Sofia", "Sol", "Soledad", "Sonya", "Sonora", "Sophia",
  "Sophie", "Soraya", "Spencer", "Stacy", "Star", "Stefanie", "Stella", "Stephanie",
  "Sugar", "Sunshine", "Susan", "Susane", "Suzanne", "Suzette", "Suzy", "Sylvia",
  # T
  "Tala", "Tabitha", "Tahira", "Tahirah", "Tai", "Taite", "Talitha", "Talulah",
  "Tamal", "Tamar", "Tamara", "Tamia", "Tamika", "Tamira", "Tammy", "Tanika",
  "Tanisha", "Tanya", "Tara", "Tasha", "Tate", "Tatiana", "Taurus", "Taylor",
  "Tazanna", "Tazara", "Tea", "Teenie", "Telma", "Tender", "Terah", "Terri",
  "Terry", "Tess", "Tessa", "Texas", "Thane", "Tho", "Thea", "Thelma", "Thema",
  "Theone", "Theresa", "Therese", "Tia", "Tiara", "Tiffany", "Tiger", "Tisha",
  "Tita", "Toby", "Tomoko", "Tosca", "Tracey", "Tracy", "Trianna", "Tricia",
  "Trinidad", "Trish", "Trisha", "Trixie", "Tuesday", "Tyler",
  # U
  "Urbana", "Urduja", "Ursula",
  # V
  "Val", "Valencia", "Valentina", "Valentine", "Valeria", "Valerie", "Valiant",
  "Vanessa", "Vangie", "Vanna", "Varali", "Varana", "Vea", "Vega", "Velvet",
  "Ventana", "Ventura", "Venus", "Vera", "Verdi", "Verona", "Veronica", "Veronique",
  "Vianca", "Vice", "Vicky", "Victoria", "Vida", "Vienna", "Vilma", "Vina", "Viola",
  "Violet", "Virika", "Viva", "Viveca", "Vivi", "Vivian", "Viviana", "Vivien",
  "Vivienne", "Von",
  # W
  "Wanda", "Wendy", "Wesley", "Whitney", "Wilda", "Wilma", "Winifreda", "Winnie",
  "Winona",
  # X
  "Xanadu", "Xandy", "Xannon", "Xaviera", "Xena", "Xenia", "Ximena", "Xylia",
  # Y
  "Yael", "Yancy", "Yasmin", "Yelena", "Yessica", "Yolanda", "Yonah", "Yori",
  "Yvette", "Yvonne",
  # Z
  "Zabby", "Zabel", "Zabria", "Zabrina", "Zaida", "Zara", "Zarina", "Zarita",
  "Zedena", "Zenaida", "Zharmaine", "Zinnia", "Zoe", "Zoey", "Zorina", "Zsa-Zsa"
)

# ---- Surnames, ranked 1-1000 by real-world frequency -------------------
# Order matters here: rank 1 (most common) first. Mirrors Forebears.io's
# Philippines surname frequency data.

surnames_ranked <- c(
  "Dela Cruz", "Garcia", "Reyes", "Ramos", "Mendoza", "Santos", "Flores", "Gonzales",
  "Bautista", "Villanueva", "Fernandez", "Cruz", "De Guzman", "Lopez", "Perez",
  "Castillo", "Francisco", "Rivera", "Aquino", "Castro", "Sanchez", "Torres",
  "De Leon", "Domingo", "Martinez", "Rodriguez", "Santiago", "Soriano",
  "Delos Santos", "Diaz", "Hernandez", "Tolentino", "Valdez", "Ramirez", "Morales",
  "Mercado", "Tan", "Aguilar", "Navarro", "Manalo", "Gomez", "Dizon", "Del Rosario",
  "Javier", "Corpuz", "Gutierrez", "Salvador", "Velasco", "Miranda", "David",
  "Salazar", "Ferrer", "Alvarez", "Sarmiento", "Pascual", "Lim", "Delos Reyes",
  "Marquez", "Jimenez", "Cortez", "Antonio", "Agustin", "Rosales", "Manuel",
  "Mariano", "Evangelista", "Pineda", "Enriquez", "Ocampo", "Alcantara", "Pascua",
  "De Vera", "Romero", "De Jesus", "Dela Pena", "Valencia", "Ignacio", "Vergara",
  "Padilla", "Angeles", "Espiritu", "Fuentes", "Legaspi", "Canete", "Peralta",
  "Vargas", "Cabrera", "Fajardo", "Gonzaga", "Espinosa", "Guevarra", "Samson",
  "Ortega", "Molina", "Serrano", "Chavez", "Briones", "Medina", "Palma", "Tamayo",
  "Arellano", "Atienza", "Villegas", "Estrada", "Martin", "Acosta", "Ortiz",
  "Sison", "Trinidad", "Zamora", "Asuncion", "Abad", "Moreno", "Valenzuela",
  "Mallari", "Caballero", "Villamor", "Bernardo", "Robles", "Concepcion",
  "Fernando", "Gregorio", "Borja", "Magbanua", "De Castro", "Panganiban", "Galang",
  "Nunez", "Roxas", "Ruiz", "Pangilinan", "Vicente", "Chua", "Suarez", "Avila",
  "Ali", "Austria", "Magno", "Dela Torre", "Luna", "De La Cruz", "Pepito", "Solis",
  "Uy", "Dela Rosa", "Duran", "Abella", "Mahinay", "Esguerra", "Roque", "Andres",
  "Jose", "Sevilla", "Beltran", "Gabriel", "Mateo", "Ybanez", "Nicolas", "Mendez",
  "Cunanan", "Vasquez", "Ancheta", "Ventura", "Lorenzo", "Cordero", "Toledo",
  "Galvez", "Abdul", "Natividad", "Marasigan", "Herrera", "Silva", "Miguel",
  "Gamboa", "Estrella", "Villa", "Bartolome", "Usman", "Sales", "Custodio", "Ong",
  "Lucero", "Abdullah", "Manzano", "Ibanez", "Marcelo", "Ponce", "Gallardo",
  "Rosario", "Delgado", "Canlas", "Carino", "Yap", "Go", "Esteban", "Ilagan",
  "Tuazon", "Carpio", "Carreon", "Baltazar", "Pablo", "Lozada", "Guzman",
  "Guerrero", "Padua", "Salcedo", "Camacho", "Bueno", "Blanco", "Cuevas", "Carlos",
  "Andaya", "Lozano", "Aguirre", "Baguio", "Cervantes", "Bernal", "Bustamante",
  "Arevalo", "Villar", "Sabado", "Labrador", "Ronquillo", "Panes", "Cristobal",
  "Prado", "Guillermo", "Dulay", "Apostol", "Oliveros", "Santillan", "Abalos",
  "Quinto", "Montero", "Alfonso", "Umali", "Campos", "San Juan", "Constantino",
  "Baylon", "Malinao", "Franco", "Calderon", "Quijano", "Velasquez", "Marcos",
  "Alonzo", "Lazaro", "Mata", "Cinco", "Geronimo", "Cordova", "Eugenio", "Rubio",
  "Viray", "Delfin", "Canoy", "Crisostomo", "Mejia", "Rico", "Punzalan", "Benitez",
  "Bernabe", "Buenaventura", "Ballesteros", "Clemente", "Sy", "Pena", "Jacinto",
  "Vidal", "Salas", "Tomas", "Matias", "Yu", "De Asis", "Andrade", "Magallanes",
  "Roldan", "Asis", "Ledesma", "Cortes", "Feliciano", "Sayson", "De Luna",
  "Borromeo", "Del Mundo", "Bello", "Manansala", "Bondoc", "Lacson", "Salinas",
  "Barrientos", "Conde", "Collado", "Juan", "Villareal", "Teves", "Laurente",
  "Quiambao", "Mohammad", "Oliva", "Bonifacio", "Rojas", "Alejandro", "Sebastian",
  "Frias", "Catalan", "Espina", "Lee", "Lucas", "Sali", "Dominguez", "Mangubat",
  "Calma", "Chan", "Villarin", "Cayabyab", "Rosal", "Basa", "Basilio", "Tejada",
  "Samonte", "Viernes", "Plaza", "Gallego", "Castor", "Dionisio", "Musa",
  "Sultan", "Tenorio", "Solomon", "Espana", "Narciso", "Pangan", "Pelayo",
  "Romano", "Lachica", "Arcilla", "Alba", "Espino", "Raymundo", "Pilapil",
  "Cuizon", "Aragon", "Medrano", "Ang", "Guinto", "Castaneda", "Paras", "Alvarado",
  "Omar", "Hipolito", "Porras", "De Mesa", "Tecson", "Basco", "Pimentel",
  "Adriano", "Santa Ana", "Sagun", "Pacheco", "Munoz", "Landicho", "Arroyo",
  "Rodrigo", "Neri", "Malabanan", "Bravo", "Lara", "Dela Cerna", "Villaflor",
  "Galicia", "San Jose", "Junio", "De Los Santos", "Villaruel", "Hilario",
  "Anonuevo", "Felipe", "Montes", "Gaspar", "Belen", "Sotto", "Patricio",
  "Bernardino", "Madrid", "Alarcon", "Verano", "Casas", "Barrios", "Ariola",
  "Cano", "Advincula", "Marcelino", "Macaraeg", "Alejo", "Andal", "Dalisay",
  "Aguila", "Lao", "Sunga", "De Chavez", "Montemayor", "Coronel", "Silvestre",
  "Carillo", "Bermudez", "Zapanta", "Co", "Murillo", "Billones", "Belarmino",
  "Dimaano", "Mahilum", "Alegre", "Nepomuceno", "De Ocampo", "Alberto", "Abas",
  "Manlangit", "Vega", "Manalang", "Liwanag", "Paglinawan", "Meneses", "Ibrahim",
  "Aguinaldo", "Bacani", "Hassan", "Cariaga", "Burgos", "Maranan", "Recto",
  "Villafuerte", "Imperial", "Manabat", "Zabala", "Figueroa", "Amante", "Paz",
  "Sandoval", "Delima", "Urbano", "Quinones", "Decena", "De Villa", "Salonga",
  "Andrada", "Policarpio", "Pasion", "Roa", "Capistrano", "Cabahug", "Carandang",
  "Madriaga", "Ismael", "Saavedra", "Mama", "Dela Vega", "Julian", "De Los Reyes",
  "Pancho", "Nolasco", "Jacob", "Fontanilla", "Tobias", "Benito", "Donato",
  "Bacus", "Magsino", "Valerio", "Dy", "Rivas", "Paraiso", "Viloria", "Paredes",
  "Solano", "Jumawan", "Regala", "Villena", "Rojo", "Magpantay", "Arceo", "Mina",
  "Florendo", "Centeno", "Encarnacion", "Mendiola", "Regalado", "Baluyot",
  "Mojica", "Mayo", "Acuna", "Alfaro", "De Torres", "Gatchalian", "Mahusay",
  "Soria", "Osorio", "Araneta", "San Pedro", "Divinagracia", "Montano",
  "Barredo", "Sumalinog", "Akmad", "Largo", "Lauron", "Simon", "Sabanal",
  "Hidalgo", "Barrera", "Valiente", "Macapagal", "Barcelona", "Isidro",
  "Bacalso", "Rafael", "Loyola", "Resurreccion", "Santa Maria", "Razon",
  "Capili", "Felix", "Velarde", "Teodoro", "Bernales", "Infante", "Navales",
  "Dorado", "Yabut", "Duque", "Caballes", "Benedicto", "Pastor", "Abubakar",
  "Mondejar", "Faustino", "Pasco", "Estacio", "Hermoso", "Lazo", "Buenaflor",
  "Danao", "Penaflor", "Mesa", "Bantilan", "Marzan", "Dayrit", "Bohol",
  "Catacutan", "Pagaduan", "Palacio", "Belleza", "Dacanay", "Magnaye",
  "Penaranda", "Arguelles", "Almazan", "Pamintuan", "Candelaria", "Inocencio",
  "Macatangay", "Morillo", "Lapuz", "Palmes", "Sarip", "Amil", "Suan", "Borres",
  "Sulit", "Tadeo", "Magat", "Padernal", "Dumlao", "Balbuena", "Villarosa",
  "Guanzon", "Parreno", "Puno", "Revilla", "Cardenas", "Paulino", "Mijares",
  "Panaligan", "Alih", "Manlapaz", "Cabral", "Manalili", "Maravilla", "Ampuan",
  "Llagas", "Arenas", "Parcon", "Leonardo", "Alcala", "Bermejo", "Buenafe",
  "Sangalang", "Gallo", "Diego", "Fabian", "Costales", "Soliman", "Jordan",
  "Salva", "De Guia", "Tayag", "Comia", "Amor", "Jayme", "Rosete", "Cuaresma",
  "Nazareno", "Abayon", "Pastrana", "Maglasang", "Tupas", "Catapang", "Adam",
  "Belmonte", "Mamaril", "Cayetano", "Cacho", "Duenas", "Florentino", "Barrameda",
  "Poblete", "Papa", "Real", "Laxamana", "Abarquez", "Cadiz", "Amparo", "Singson",
  "Cueto", "Dela Paz", "Moral", "Abao", "Banaag", "Montoya", "Pitogo", "Campo",
  "Valle", "Gloria", "Cuenca", "Salik", "Eusebio", "Bulan", "Ampaso", "Arias",
  "Rey", "Victoria", "Granada", "Pama", "Celis", "Almonte", "Malate", "Almario",
  "Balingit", "Olivar", "Joaquin", "Tagalog", "Sibayan", "Contreras", "Montejo",
  "Palomo", "Lagman", "Quizon", "Apolinario", "Paragas", "Gaviola", "Dayao",
  "Andales", "Silvano", "Montilla", "Estrera", "Aban", "Alcaraz", "Fronda",
  "Ibarra", "Morada", "Diamante", "Naval", "Pulido", "Balansag", "Rosas",
  "Marinas", "Cornelio", "Banez", "Palomar", "Adolfo", "Amaro", "Rendon",
  "Sanico", "Valera", "Buan", "Amores", "Caro", "Castillon", "Mora", "Ando",
  "Baron", "Coronado", "Balmes", "Nacario", "Datu", "Gorospe", "Simbajon",
  "Pantaleon", "De Lara", "San Diego", "Ceniza", "Olarte", "Samillano", "Torio",
  "Rama", "Escalante", "Tagle", "Claro", "Escobar", "Avenido", "Rabino",
  "Salvacion", "Pelaez", "Yumul", "Leal", "Amar", "Gerona", "Nava", "Zulueta",
  "Tampus", "Alferez", "Aranas", "Galvan", "Francia", "Agcaoili", "Mirasol",
  "Kasim", "Nacion", "Posadas", "Canillo", "De Dios", "Estabillo", "Gumban",
  "Buena", "Doria", "Ilao", "Alano", "Velez", "Daniel", "Noble", "Pardillo",
  "Sarabia", "Bayani", "Llanes", "Catubig", "Quirante", "Abbas", "Vinluan",
  "Salem", "Villas", "Dagohoy", "Lariosa", "Caparas", "Verzosa", "Sicat",
  "Vinas", "Buendia", "Manalastas", "Alipio", "Candelario", "Pareja", "Esmael",
  "Manahan", "Amerol", "Abello", "Rivero", "Nobleza", "Coloma", "Maceda",
  "Marcial", "Pamplona", "Mauricio", "Veloso", "Balaba", "Banares", "Adlawan",
  "Aba", "Dano", "Arce", "Magtibay", "Alburo", "Isip", "Gervacio", "Manatad",
  "Jumao-As", "Opena", "Parungao", "Arnaiz", "Cayanan", "Abuan", "Daud",
  "Montecillo", "Claveria", "Gatdula", "Royo", "Galo", "Binas", "Pedro",
  "Celeste", "Villaruz", "Ayson", "Rada", "Palermo", "Roble", "Gallano",
  "Minoza", "Suico", "Barbosa", "Arcega", "Mission", "Grande", "Candido",
  "Cerezo", "Bolivar", "Untalan", "Pajarillo", "Maquiling", "Alim", "Maghanoy",
  "Tolosa", "Cabiles", "Tiu", "Ordonez", "Del Castillo", "Palencia",
  "Dimaculangan", "Labajo", "Guarin", "Cagas", "Dalida", "Menor", "Monte",
  "Soliven", "Garces", "Mabini", "Balbin", "Celestial", "Esmail", "Balagtas",
  "Sampang", "Tejero", "Camba", "Villaflores", "Barba", "Joson", "Abubacar",
  "Paran", "Espejo", "Monares", "Macalalad", "Mayor", "Cuyos", "Mohamad",
  "Somera", "Malana", "Marco", "Pino", "Brillantes", "Barroga", "Vallejo",
  "Cantos", "Segovia", "Marfil", "Abdulla", "Paclibar", "Piamonte", "Baquiran",
  "Bustillo", "Tizon", "Amper", "Abordo", "Garay", "Palmares", "Bayot",
  "Formentera", "Dacillo", "Mallorca", "Ricafort", "Solaiman", "Bacolod",
  "Quintana", "Montenegro", "Agbayani", "Manaloto", "Paguio", "Tumbaga",
  "Pedrosa", "Ubaldo", "Baring", "Dungca", "Borbon", "Mapa", "Bobis",
  "Pagulayan", "Villalobos", "Abo", "Gascon", "Alon", "Vista", "Galon",
  "Badilla", "Villaluz", "Layug", "Zafra", "Abing", "Dinglasan", "Divina",
  "Lanuza", "Antolin", "Evangelio", "Rondina", "Macaraig", "Tapia", "Baluyut",
  "Canada", "Soberano", "Madera", "Kusain", "Espanol", "Silverio", "Abellana",
  "Palad", "Medalla", "Ferolino", "Doctor", "Cajes", "Azucena", "Villagracia",
  "Bato", "Garrido", "Cabarles", "Ambrocio", "Paloma", "Padillo", "Juarez",
  "Prieto", "Cabasag", "Acob", "De Juan", "Montalban", "Bulatao", "Guerra",
  "Morante", "Escala", "Palo", "Yambao", "Talib", "Jocson", "Amador", "Alegado",
  "Lising", "Millan", "Loreto", "Maturan", "Credo", "Caringal", "Wenceslao",
  "Bernaldez", "Laguna", "Ebrahim", "Tupaz", "Sia", "Yuson", "Agravante",
  "Joven", "Balasabas", "Nieva", "Taruc", "Capulong", "Avelino", "Leano",
  "Mira", "Amora", "Victoriano", "Tiongson", "Cabaluna", "Simbulan", "Wong",
  "Laureta", "Camposano", "Mercader", "Dolor", "Usop", "Guevara", "Villacorta",
  "Salgado", "Degamo"
)

# ---- Assemble & write R/sysdata.rda -------------------------------------

unisex_extra <- c("Darcel", "Dharma", "Pax", "Phoenix", "Piper", "Porter", "Presley", "Yonah")

.ph_male_names <- sort(unique(c(male_raw, unisex_extra)))
.ph_female_names <- sort(unique(c(female_raw, unisex_extra)))

.ph_surnames <- unique(surnames_ranked)
# Zipf-style weights from rank so common surnames (rank 1) are drawn far
# more often than rare ones (rank ~1000), instead of uniformly.
.ph_surname_weights <- 1 / seq_along(.ph_surnames)
.ph_surname_weights <- .ph_surname_weights / sum(.ph_surname_weights)

.ph_civil_status <- c("Single", "Married", "Widowed", "Separated", "Annulled")

save(
  .ph_male_names, .ph_female_names, .ph_surnames, .ph_surname_weights,
  .ph_civil_status,
  file = "R/sysdata.rda", compress = "bzip2"
)
