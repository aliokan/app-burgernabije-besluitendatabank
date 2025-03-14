export default [
    ...["http://data.vlaanderen.be/ns/besluit#Agendapunt",
        "http://data.vlaanderen.be/ns/besluit#Besluit",
        "http://data.vlaanderen.be/ns/besluit#Bestuursorgaan",
        "http://data.vlaanderen.be/ns/besluit#BehandelingVanAgendapunt",
        "http://data.vlaanderen.be/ns/besluit#Zitting",
        "http://data.vlaanderen.be/ns/besluit#Stemming",
        "http://data.vlaanderen.be/ns/mandaat#Mandataris",
        "http://www.w3.org/ns/person#Person",
    ].map((type) => ({
        match: {
            predicate: {
                type: 'uri',
                value: 'http://www.w3.org/1999/02/22-rdf-syntax-ns#type'
            },
            object: {
                type: 'uri',
                value: type
            }
        },
        callback: {
            url: 'http://uuid-generation/delta',
            method: 'POST'
        },
        options: {
            resourceFormat: 'v0.0.1',
            gracePeriod: 250,
            ignoreFromSelf: false
        }
    }))
]