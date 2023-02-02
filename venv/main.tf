#user creation on pagerduty
resource "pagerduty_user" "lisa" {
  name = "lisa lindson"
  role    = "user"
  email = "lisa.lindson@techmahindra.com"
  description   = "user details"
  job_title = "user1"
}

resource "pagerduty_user" "CiscoAdmin" {
  name = "CiscoAdmin"
  role    = "admin"
  email = "anudeep.fusion@techmahindra.com"
  description   = "user details"
  job_title = "admin"
}

#team creation
resource "pagerduty_team" "cisco-terraformteam" {
  name        = "cisco-terraformteam"
  description = "team creation using terraform script"
}

#pagerduty membership(user assign to team)

resource "pagerduty_team_membership" "cisco-terraformteam" {
  user_id = pagerduty_user.lisa.id
  team_id = pagerduty_team.cisco-terraformteam.id
  role    = "observer"
}

resource "pagerduty_team_membership" "cisco-terraformteam2" {
  user_id = pagerduty_user.CiscoAdmin.id
  team_id = pagerduty_team.cisco-terraformteam.id
  role    = "manager"
}

#pagerduty membership using id

resource "pagerduty_team_membership" "cisco-terraformteam3" {
  user_id = "PFY5OVF"
  team_id = "PJV5NO7"
  role    = "responder"
}



#escalation policy

resource "pagerduty_escalation_policy" "Ciscoescalationpolicy" {
  name      = "Cisco Escalation Policy"
  num_loops = 2
  teams     = [pagerduty_team.cisco-terraformteam.id]

  rule {
    escalation_delay_in_minutes = 10
    target {
      type = "user_reference"
      id   = pagerduty_user.lisa.id
    }
    target {
      type = "user_reference"
      id   = pagerduty_user.CiscoAdmin.id
    }
  }
}

#service creation

resource "pagerduty_service" "CiscoService" {
  name                    = "CiscoService"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.Ciscoescalationpolicy.id
  alert_creation          = "create_alerts_and_incidents"

}