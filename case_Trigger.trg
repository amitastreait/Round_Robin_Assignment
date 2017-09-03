trigger case_Trigger on Case (After Update) {
            caseRoundRobinAssignment.assignTicketsRoundRobin(Trigger.NewMap.keySet());
}
