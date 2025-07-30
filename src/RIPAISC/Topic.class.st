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
	dic := WAJsonParser parse: Topic qseTaxonomyAsJson.
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
