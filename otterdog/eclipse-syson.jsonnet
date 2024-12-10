local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-syson') {
  settings+: {
    description: "",
    name: "Eclipse SysON",
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  secrets+: [
    orgs.newOrgSecret('ORG_DOCKER_HUB_TOKEN') {
      value: "pass:bots/modeling.syson/docker.com/api-token",
    },
    orgs.newOrgSecret('ORG_DOCKER_HUB_USER') {
      value: "pass:bots/modeling.syson/docker.com/username",
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
      description: "SysON: web-based graphical modelers for SysMLv2. Please visit https://mbse-syson.org and contact Obeo https://www.obeosoft.com/en/contact for more details!",
      gh_pages_build_type: "workflow",
      has_discussions: true,
      has_wiki: false,
      homepage: "https://mbse-syson.org",
      web_commit_signoff_required: false,
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          required_approving_review_count: 0,
          requires_linear_history: true,
          requires_strict_status_checks: true,
        },
      ],
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "main",
            "v*"
          ],
          deployment_branch_policy: "selected",
        },
      ],
    },
    orgs.newRepo('syson-website') {
      allow_squash_merge: false,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "main",
      gh_pages_source_path: "/",
      has_wiki: false,
      web_commit_signoff_required: false,
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "main"
          ],
          deployment_branch_policy: "selected",
        },
      ],
    },
  ],
} + {
  # snippet added due to 'https://github.com/EclipseFdn/otterdog-configs/blob/main/blueprints/add-dot-github-repo.yml'
  _repositories+:: [
    orgs.newRepo('.github')
  ],
}