# Mu Authorization configuration file
# Used to decide which people get to access what
# BNB is an open project so to be honest this file won't get much attention
# But it's needed anyway.
# https://github.com/mu-semtech/mu-authorization

alias Acl.Accessibility.Always, as: AlwaysAccessible
alias Acl.GraphSpec.Constraint.Resource, as: ResourceConstraint
alias Acl.GraphSpec, as: GraphSpec
alias Acl.GroupSpec, as: GroupSpec
alias Acl.GroupSpec.GraphCleanup, as: GraphCleanup

defmodule Acl.UserGroups.Config do
  def user_groups do
    # These elements are walked from top to bottom.  Each of them may
    # alter the quads to which the current query applies.  Quads are
    # represented in three sections: current_source_quads,
    # removed_source_quads, new_quads.  The quads may be calculated in
    # many ways.  The useage of a GroupSpec and GraphCleanup are
    # common.
    [
      # // PUBLIC
      %GroupSpec{
        name: "public",
        useage: [:read, :write, :read_for_write],
        access: %AlwaysAccessible{},
        graphs: [
          %GraphSpec{
            graph: "http://mu.semte.ch/graphs/public",
            constraint: %ResourceConstraint{
              resource_types: []
            }
          },
          %GraphSpec{
            graph: "http://mu.semte.ch/graphs/access-for-role/PubliekeBesluitendatabank-BesluitendatabankLezer",
            constraint: %ResourceConstraint{
              resource_types: []
            }
          }
        ]
      },      
      # // CLEANUP
      #
      %GraphCleanup{
        originating_graph: "http://mu.semte.ch/application",
        useage: [:write],
        name: "clean"
      }
    ]
  end
end
