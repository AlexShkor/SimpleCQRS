﻿Feature: Insert events
	In order to add events to my SQL Server event store
	As a Simple CQRS developer
	I want to pass an array of events and have them added to the appropriate table

# Special Note:  I think it's probably better to test the final results 
# in the SQL server, for now I'm just going to test the SQL statements
# that are to be run against the DB.  I think it's worth demonstrating 
# that you can bend these types of specs to fit what you want (instead
# of just throwing away this type of testing alltogether).

Scenario: Insert one domain event
	Given I have a SomethingHappenedEvent to be added to the store with the following values
	| Field           | Value                                |
	| EventDate       | 3/20/2010 3:01:04 AM                 |
	| AggregateRootId | 8312E92C-DF1C-4970-A9D5-6414120C3CF7 |
	| Sequence        | 2                                    |
	And that event will serialize to 'Serialized Object'
	When I add the domain events to the store
	Then I should have the following events in the database
	| EventId | EventDate            | Sequence | Data  | AggregateRootId                      |
	| 1       | 3/20/2010 3:01:04 AM | 2        | Data1 | 8312E92C-DF1C-4970-A9D5-6414120C3CF7 |

Scenario: Insert two domain events
	Given I have a SomethingHappenedEvent to be added to the store with the following values
	| Field           | Value                                |
	| EventDate       | 3/20/2010 3:01:04 AM                 |
	| AggregateRootId | 8312E92C-DF1C-4970-A9D5-6414120C3CF7 |
	| Sequence        | 2                                    |
	Given I have a SomethingElseHappenedEvent to be added to the store with the following values
	| Field           | Value                                |
	| EventDate       | 4/24/2010 3:01:04 AM                 |
	| AggregateRootId | C3579C12-C29B-4F65-8D83-B79AC5C85718 |
	| Sequence        | 4                                    |
	When I add the domain events to the store
	Then I should have the following events in the database
	| EventId | EventDate            | Sequence | Data  | AggregateRootId                      |
	| 1       | 3/20/2010 3:01:04 AM | 2        | Data1 | 8312E92C-DF1C-4970-A9D5-6414120C3CF7 |
	| 2       | 4/24/2010 3:01:04 AM | 4        | Data2 | C3579C12-C29B-4F65-8D83-B79AC5C85718 |