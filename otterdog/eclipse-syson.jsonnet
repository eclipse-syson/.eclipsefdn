local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-syson') {
  settings+: {
    dependabot_security_updates_enabled_for_new_repositories: false,
    description: "",
    name: "Eclipse SysON",
    packages_containers_internal: false,
    readers_can_create_discussions: true,
    two_factor_requirement: false,
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  secrets+: [
    orgs.newOrgSecret('AWS_ACCESS_KEY_ID') {
      selected_repositories+: [
        "syson"
      ],
      value: "********",
      visibility: "selected",
    },
    orgs.newOrgSecret('AWS_SECRET_ACCESS_KEY') {
      selected_repositories+: [
        "syson"
      ],
      value: "********",
      visibility: "selected",
    },
  ],
  _repositories+:: [
    orgs.newRepo('eclipse-syson.github.io') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "main",
      gh_pages_source_path: "/",
      web_commit_signoff_required: false,
      workflows+: {
        actions_can_approve_pull_request_reviews: false,
      },
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "main"
          ],
          deployment_branch_policy: "selected",
        },
      ],
    },
    orgs.newRepo('syson') {
      allow_squash_merge: false,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      description: "SysON: web-based graphical modelers for SysMLv2",
      has_discussions: true,
      has_wiki: false,
      web_commit_signoff_required: false,
      workflows+: {
        actions_can_approve_pull_request_reviews: false,
      },
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          required_approving_review_count: 0,
          requires_linear_history: true,
          requires_strict_status_checks: true,
        },
      ],
    },
    orgs.newRepo('syson-website') {
      allow_squash_merge: false,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      has_wiki: false,
      web_commit_signoff_required: false,
      workflows+: {
        actions_can_approve_pull_request_reviews: false,
      },
    },
  ],
}
