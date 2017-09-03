public class caseRoundRobinAssignment{
    public static Boolean runOnce = false;
    public static Boolean runMerge = false;
    public static void assignTicketsRoundRobin(Set<Id> ticketIdsSet){
        /* get list of all the tickets */
        List<Case> ticketList = [Select Id, OwnerId, Case__c FROM Case Where Id IN:ticketIdsSet];
        Integer index;
        Integer ticketNumber;
        Integer agentSize;
        List<User> agentList = new List<User>();
        Set<Id> queueIdsSet = new Set<Id>();
        System.debug('#### ticketList = '+ticketList);
        // Fetch Ids of the group.
        For(Case c : ticketList){
            If(String.valueOf(c.ownerId).startsWith('00G')){
                queueIdsSet.add(c.ownerId);
            }
        }
        // return if Case is already assigned to user
        If(queueIdsSet==null || queueIdsSet.size()==0)return;
        System.debug('#### queueIdsSet = '+queueIdsSet);
        Set<Id> userIdsSet = new Set<Id>();
        // Fetch Ids of the users
        For(GroupMember gm : [Select Id, UserOrGroupId FROM GROUPMEMBER WHERE GroupId IN : queueIdsSet]){
            userIdsSet.add(gm.UserOrGroupId);
        }
        System.debug('#### userIdsSet = '+userIdsSet);
        /* fetch the total no of users for RRD that are active */
       agentList = [Select Id, Name,  Profile.Name From User Where Id In : userIdsSet AND ISACTIVE = true];
// return if there are no active users 
        If(agentList==null || agentList.size()==0)return;
        System.debug('#### agentList = '+agentList);
        For(Case c : ticketList){
            if(c.Case__c!=null){
                ticketNumber = Integer.valueOf(c.Case__c);
                System.debug('#### ticketNumber = '+ticketNumber);
                agentSize = agentList.size();
                index = Math.MOD(ticketNumber ,agentSize);//+1;
                System.debug('#### index = '+index);
                c.OwnerId = agentList[index].id;
            }
        }
        If(ticketList!=null && ticketList.size()>0){
            System.debug('#### Updating tickets = '+ticketList);
            
            update ticketList;
        }
    }
}
