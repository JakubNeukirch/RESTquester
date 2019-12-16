class Response {
  final String login;
  final int id;
  final String nodeId;
  final String url;
  final String reposUrl;
  final String eventsUrl;
  final String hooksUrl;
  final String issuesUrl;
  final String membersUrl;
  final String publicMembersUrl;
  final String avatarUrl;
  final String description;
  final Null name;
  final Null company;
  final String blog;
  final Null location;
  final Null email;
  final bool isVerified;
  final bool hasOrganizationProjects;
  final bool hasRepositoryProjects;
  final int publicRepos;
  final int publicGists;
  final int followers;
  final int following;
  final String htmlUrl;
  final String createdAt;
  final String updatedAt;
  final String type;

  Response({this.login,
    this.id,
    this.nodeId,
    this.url,
    this.reposUrl,
    this.eventsUrl,
    this.hooksUrl,
    this.issuesUrl,
    this.membersUrl,
    this.publicMembersUrl,
    this.avatarUrl,
    this.description,
    this.name,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.isVerified,
    this.hasOrganizationProjects,
    this.hasRepositoryProjects,
    this.publicRepos,
    this.publicGists,
    this.followers,
    this.following,
    this.htmlUrl,
    this.createdAt,
    this.updatedAt,
    this.type});

  Response.fromJson(Map<String, dynamic> json)
      :
        login = json['login'],
        id = json['id'],
        nodeId = json['node_id'],
        url = json['url'],
        reposUrl = json['repos_url'],
        eventsUrl = json['events_url'],
        hooksUrl = json['hooks_url'],
        issuesUrl = json['issues_url'],
        membersUrl = json['members_url'],
        publicMembersUrl = json['public_members_url'],
        avatarUrl = json['avatar_url'],
        description = json['description'],
        name = json['name'],
        company = json['company'],
        blog = json['blog'],
        location = json['location'],
        email = json['email'],
        isVerified = json['is_verified'],
        hasOrganizationProjects = json['has_organization_projects'],
        hasRepositoryProjects = json['has_repository_projects'],
        publicRepos = json['public_repos'],
        publicGists = json['public_gists'],
        followers = json['followers'],
        following = json['following'],
        htmlUrl = json['html_url'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        type = json['type'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['id'] = this.id;
    data['node_id'] = this.nodeId;
    data['url'] = this.url;
    data['repos_url'] = this.reposUrl;
    data['events_url'] = this.eventsUrl;
    data['hooks_url'] = this.hooksUrl;
    data['issues_url'] = this.issuesUrl;
    data['members_url'] = this.membersUrl;
    data['public_members_url'] = this.publicMembersUrl;
    data['avatar_url'] = this.avatarUrl;
    data['description'] = this.description;
    data['name'] = this.name;
    data['company'] = this.company;
    data['blog'] = this.blog;
    data['location'] = this.location;
    data['email'] = this.email;
    data['is_verified'] = this.isVerified;
    data['has_organization_projects'] = this.hasOrganizationProjects;
    data['has_repository_projects'] = this.hasRepositoryProjects;
    data['public_repos'] = this.publicRepos;
    data['public_gists'] = this.publicGists;
    data['followers'] = this.followers;
    data['following'] = this.following;
    data['html_url'] = this.htmlUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type'] = this.type;
    return data;
  }
}