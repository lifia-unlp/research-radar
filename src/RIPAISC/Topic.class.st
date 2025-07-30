Class {
	#name : #Topic,
	#superclass : #Object,
	#instVars : [
		'label',
		'description',
		'subtopics'
	],
	#category : #'RIPAISC-model'
}

{ #category : #constants }
Topic class >> domainsTaxonomy [

	^ self fromJSON: Topic domainsTaxonomyAsJson
]

{ #category : #constants }
Topic class >> domainsTaxonomyAsJson [

	^ '{
  "label": "Application Areas of Quantum Software Engineering",
  "short_description": "Problem domains where quantum software engineering methods, tools, or systems are applied or developed for real-world impact.",
  "subtopics": [
    {
      "label": "Health and Life Sciences",
      "short_description": "Applications that support diagnostics, drug discovery, genomics, and healthcare optimization using quantum-enhanced methods.",
      "subtopics": [
        {
          "label": "Drug Discovery and Molecular Simulation",
          "short_description": "Use of quantum algorithms for simulating molecular structures and reactions."
        },
        {
          "label": "Genomic Data Analysis",
          "short_description": "Quantum machine learning and optimization for processing large-scale biological data."
        },
        {
          "label": "Healthcare Resource Optimization",
          "short_description": "Scheduling, logistics, and planning applications in hospital or public health contexts."
        }
      ]
    },
    {
      "label": "Finance and Economics",
      "short_description": "Applications in financial modeling, risk analysis, optimization, and cryptography in economic contexts.",
      "subtopics": [
        {
          "label": "Portfolio Optimization",
          "short_description": "Use of quantum annealing or VQAs for selecting optimal investment strategies."
        },
        {
          "label": "Fraud Detection and Risk Modeling",
          "short_description": "Quantum-enhanced ML techniques for anomaly detection and prediction of financial risks."
        },
        {
          "label": "Cryptocurrency and Blockchain",
          "short_description": "Analysis of cryptographic primitives and blockchain systems in the quantum era."
        }
      ]
    },
    {
      "label": "Cybersecurity",
      "short_description": "Design and evaluation of secure systems in a post-quantum world or using quantum protocols.",
      "subtopics": [
        {
          "label": "Quantum-Safe Cryptography",
          "short_description": "Evaluation and implementation of cryptographic systems secure against quantum attacks."
        },
        {
          "label": "Quantum Key Distribution",
          "short_description": "Deployment of secure communication systems based on quantum mechanics."
        },
        {
          "label": "Security in IoT and Smart Systems",
          "short_description": "Application of quantum techniques to protect connected devices and embedded systems."
        }
      ]
    },
    {
      "label": "Logistics and Transportation",
      "short_description": "Use of quantum methods to address complex optimization problems in supply chains and transportation systems.",
      "subtopics": [
        {
          "label": "Traveling Salesperson and Routing",
          "short_description": "Mapping of routing problems to quantum annealing or hybrid solvers."
        },
        {
          "label": "Supply Chain Optimization",
          "short_description": "Quantum-inspired or quantum-native algorithms for minimizing cost and time in logistics."
        }
      ]
    },
    {
      "label": "Smart Cities and Urban Systems",
      "short_description": "Applications of QSE in optimizing energy, transport, security, and infrastructure in urban environments.",
      "subtopics": [
        {
          "label": "Traffic Optimization",
          "short_description": "Real-time route planning and congestion management using quantum optimization."
        },
        {
          "label": "Resource Management",
          "short_description": "Scheduling and distribution of water, electricity, or services in smart cities."
        }
      ]
    },
    {
      "label": "Energy and Climate",
      "short_description": "Quantum approaches to sustainable energy generation, distribution, and climate modeling.",
      "subtopics": [
        {
          "label": "Energy Grid Optimization",
          "short_description": "Quantum-enhanced methods for optimizing power grids and demand response."
        },
        {
          "label": "Climate Modeling and Forecasting",
          "short_description": "Quantum simulation for understanding complex atmospheric and ecological systems."
        }
      ]
    },
    {
      "label": "Artificial Intelligence and Machine Learning",
      "short_description": "Use of quantum computing to train or accelerate learning algorithms and AI systems.",
      "subtopics": [
        {
          "label": "Quantum Machine Learning",
          "short_description": "Use of variational circuits and hybrid models for classification, regression, or clustering."
        },
        {
          "label": "Quantum Neural Networks",
          "short_description": "Design of neural architectures operating on quantum principles (e.g., QBNNs, QPAMs)."
        }
      ]
    },
    {
      "label": "Education and Training",
      "short_description": "Development of quantum software systems, tools, or platforms for pedagogical use.",
      "subtopics": [
        {
          "label": "Educational Simulators",
          "short_description": "Quantum programming environments aimed at teaching concepts to students."
        },
        {
          "label": "Curriculum Design Tools",
          "short_description": "Software and frameworks to assist in building and evaluating educational materials for QSE."
        }
      ]
    },
    {
      "label": "Fundamental Science and Research",
      "short_description": "Use of quantum software to support research in chemistry, physics, biology, or mathematics.",
      "subtopics": [
        {
          "label": "Quantum Chemistry",
          "short_description": "Simulations of molecular systems for understanding fundamental chemical properties."
        },
        {
          "label": "High-Energy and Particle Physics",
          "short_description": "Use of quantum algorithms to model systems in theoretical or experimental physics."
        },
        {
          "label": "Mathematical and Algorithmic Exploration",
          "short_description": "Research on foundational quantum algorithms and theoretical computation models."
        }
      ]
    }
  ]
}
'
]

{ #category : #constants }
Topic class >> fromDictionary: aDictionary [

	^ self new
		  description: (aDictionary at: 'short_description');
		  label: (aDictionary at: 'label');
		  subtopics:
			  ((aDictionary at: 'subtopics' ifAbsent: [ Set new ]) collect: [
					   :each | self fromDictionary: each ])
]

{ #category : #constants }
Topic class >> fromJSON: aJSONString [

	| dic |
	dic := WAJsonParser parse: aJSONString.
	^ self fromDictionary: dic
]

{ #category : #'as yet unclassified' }
Topic class >> labeled: aLabel [

	^ self new
		  label: aLabel;
		  yourself
]

{ #category : #constants }
Topic class >> qseTaxonomy [

	^ self fromJSON: Topic qseTaxonomyAsJson
]

{ #category : #constants }
Topic class >> qseTaxonomyAsJson [

	^ '{
  "label": "Quantum Software Engineering",
  "short_description": "Systematic engineering of software systems involving quantum computing, integrating classical software engineering principles with quantum-specific requirements.",
  "subtopics": [
    {
      "label": "Requirements Engineering",
      "short_description": "The process of eliciting, analyzing, specifying, and validating functional and non-functional requirements for quantum and hybrid systems.",
      "subtopics": [
        {
          "label": "Non-functional Requirements for Quantum Systems",
          "short_description": "Specification of constraints such as qubit count, decoherence time, execution cost, and hardware availability."
        },
        {
          "label": "Hybrid System Requirements",
          "short_description": "Definition of interactions and interfaces between quantum and classical components."
        }
      ]
    },
    {
      "label": "Design",
      "short_description": "Design of the software architecture and detailed models, identifying quantum and classical components and their interactions.",
      "subtopics": [
        {
          "label": "Quantum-Classical Co-Design",
          "short_description": "Architectural design approaches that integrate quantum and classical software in hybrid systems."
        },
        {
          "label": "Quantum Software Modeling Languages",
          "short_description": "Extensions to UML and other modeling tools to represent quantum states, gates, and entanglement."
        },
        {
          "label": "Formal Specification for Quantum Software",
          "short_description": "Use of formal methods and logics adapted to quantum computation (e.g., Q-CTL, quantum logic)."
        }
      ]
    },
    {
      "label": "Implementation",
      "short_description": "Translation of design models into code using quantum programming languages, APIs, and frameworks.",
      "subtopics": [
        {
          "label": "Quantum Programming Languages",
          "short_description": "Development and use of quantum-specific programming languages such as Qiskit, Q#, or Silq."
        },
        {
          "label": "Hybrid Microservices and APIs",
          "short_description": "Service-oriented and API-based approaches for exposing quantum functionality in classical systems."
        },
        {
          "label": "Quantum Development Tools",
          "short_description": "Editors, debuggers, and toolchains tailored to quantum programming."
        }
      ]
    },
    {
      "label": "Testing",
      "short_description": "Validation and verification of quantum software, considering the probabilistic and non-deterministic nature of quantum execution.",
      "subtopics": [
        {
          "label": "Quantum Software Testing Strategies",
          "short_description": "Approaches like black-box, white-box, and statistical testing adapted to quantum programs."
        },
        {
          "label": "Test Oracle and Correctness Criteria",
          "short_description": "Definition of expected behavior in quantum programs, often based on probability distributions."
        },
        {
          "label": "Simulation and Emulation-based Testing",
          "short_description": "Use of classical simulators to test quantum software before deployment on quantum hardware."
        }
      ]
    },
    {
      "label": "Maintenance",
      "short_description": "Adaptation and evolution of quantum software in response to hardware changes, library updates, or shifting requirements.",
      "subtopics": [
        {
          "label": "Quantum Software Reengineering",
          "short_description": "Modernization or migration of classical components to quantum equivalents to optimize performance."
        },
        {
          "label": "Hardware-Aware Portability",
          "short_description": "Ensuring quantum software compatibility across different hardware platforms with varying qubit technologies."
        },
        {
          "label": "Reverse Engineering and Code Analysis",
          "short_description": "Extraction of design and architectural insights from existing quantum software systems."
        }
      ]
    },
    {
      "label": "Process and Methodologies",
      "short_description": "Definition and use of structured processes and practices to guide the development of quantum software.",
      "subtopics": [
        {
          "label": "Quantum-Aware Software Development Processes",
          "short_description": "Adaptations of Agile, DevOps, and Waterfall for quantum software lifecycles."
        },
        {
          "label": "Quantum Software Methodologies",
          "short_description": "Methodological frameworks that account for hybrid computation and quantum constraints."
        }
      ]
    },
    {
      "label": "Tooling and Infrastructure",
      "short_description": "Supporting tools, simulators, execution platforms, and deployment infrastructure for QSE.",
      "subtopics": [
        {
          "label": "Quantum IDEs and Plugins",
          "short_description": "Integrated development environments tailored for quantum programming (e.g., extensions to VS Code or Jupyter)."
        },
        {
          "label": "Quantum Execution Backends",
          "short_description": "Remote or local access to quantum processors (e.g., IBM Q, IonQ, Rigetti) and cloud-based services."
        },
        {
          "label": "CI/CD for Quantum Software",
          "short_description": "Continuous integration and deployment strategies adapted to hybrid classical-quantum pipelines."
        }
      ]
    },
    {
      "label": "Quality Assurance",
      "short_description": "Ensuring the reliability, performance, and correctness of quantum software systems.",
      "subtopics": [
        {
          "label": "Fault Models for Quantum Software",
          "short_description": "Understanding and modeling faults unique to quantum software, including noise-induced errors."
        },
        {
          "label": "Metrics and Benchmarks",
          "short_description": "Definition of metrics for quality, performance, and resource efficiency in quantum programs."
        }
      ]
    },
    {
      "label": "Project Management and Collaboration",
      "short_description": "Planning, coordinating, and monitoring quantum software development projects.",
      "subtopics": [
        {
          "label": "Collaboration in Hybrid Teams",
          "short_description": "Processes and tools to coordinate multidisciplinary teams (physicists, computer scientists, engineers)."
        },
        {
          "label": "Documentation and Versioning",
          "short_description": "Managing the lifecycle of code and design artifacts in evolving quantum projects."
        }
      ]
    },
    {
      "label": "Education and Training",
      "short_description": "Development of curricula, tools, and practices to train quantum software engineers.",
      "subtopics": [
        {
          "label": "Pedagogical Tools for QSE",
          "short_description": "Simulators, visualizers, and course materials that simplify QSE learning."
        },
        {
          "label": "Curriculum Design",
          "short_description": "Educational pathways that integrate software engineering and quantum computing."
        }
      ]
    }
  ]
}
'
]

{ #category : #accessing }
Topic >> description [

	^ description
]

{ #category : #accessing }
Topic >> description: anObject [

	description := anObject
]

{ #category : #accessing }
Topic >> initialize [

	subtopics := OrderedCollection new
]

{ #category : #accessing }
Topic >> label [

	^ label
]

{ #category : #accessing }
Topic >> label: anObject [

	label := anObject
]

{ #category : #accessing }
Topic >> subtopics [

	^ subtopics
]

{ #category : #accessing }
Topic >> subtopics: anObject [

	subtopics := anObject
]

{ #category : #accessing }
Topic >> withSubtopicsOn: aCollection atLevel: myLevel [

	aCollection add: myLevel -> self.
	subtopics do: [ :each |
		each withSubtopicsOn: aCollection atLevel: myLevel + 1 ]
]
