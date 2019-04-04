locals = {
  cluster_name                 = "atlantis2.domainsandbox.net"
  master_autoscaling_group_ids = ["${aws_autoscaling_group.master-us-east-1a-masters-atlantis2-domainsandbox-net.id}"]
  master_security_group_ids    = ["${aws_security_group.masters-atlantis2-domainsandbox-net.id}"]
  masters_role_arn             = "${aws_iam_role.masters-atlantis2-domainsandbox-net.arn}"
  masters_role_name            = "${aws_iam_role.masters-atlantis2-domainsandbox-net.name}"
  node_autoscaling_group_ids   = ["${aws_autoscaling_group.nodes-atlantis2-domainsandbox-net.id}"]
  node_security_group_ids      = ["${aws_security_group.nodes-atlantis2-domainsandbox-net.id}"]
  node_subnet_ids              = ["subnet-003582309bc21e5b1"]
  nodes_role_arn               = "${aws_iam_role.nodes-atlantis2-domainsandbox-net.arn}"
  nodes_role_name              = "${aws_iam_role.nodes-atlantis2-domainsandbox-net.name}"
  region                       = "us-east-1"
  subnet_ids                   = ["subnet-003582309bc21e5b1"]
  subnet_us-east-1a_id         = "subnet-003582309bc21e5b1"
  vpc_id                       = "vpc-02ce3c582cd4ebbff"
}

output "cluster_name" {
  value = "atlantis2.domainsandbox.net"
}

output "master_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.master-us-east-1a-masters-atlantis2-domainsandbox-net.id}"]
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-atlantis2-domainsandbox-net.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-atlantis2-domainsandbox-net.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-atlantis2-domainsandbox-net.name}"
}

output "node_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.nodes-atlantis2-domainsandbox-net.id}"]
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-atlantis2-domainsandbox-net.id}"]
}

output "node_subnet_ids" {
  value = ["subnet-003582309bc21e5b1"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-atlantis2-domainsandbox-net.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-atlantis2-domainsandbox-net.name}"
}

output "region" {
  value = "us-east-1"
}

output "subnet_ids" {
  value = ["subnet-003582309bc21e5b1"]
}

output "subnet_us-east-1a_id" {
  value = "subnet-003582309bc21e5b1"
}

output "vpc_id" {
  value = "vpc-02ce3c582cd4ebbff"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_autoscaling_group" "master-us-east-1a-masters-atlantis2-domainsandbox-net" {
  name                 = "master-us-east-1a.masters.atlantis2.domainsandbox.net"
  launch_configuration = "${aws_launch_configuration.master-us-east-1a-masters-atlantis2-domainsandbox-net.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["subnet-003582309bc21e5b1"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "atlantis2.domainsandbox.net"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-east-1a.masters.atlantis2.domainsandbox.net"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-us-east-1a"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-atlantis2-domainsandbox-net" {
  name                 = "nodes.atlantis2.domainsandbox.net"
  launch_configuration = "${aws_launch_configuration.nodes-atlantis2-domainsandbox-net.id}"
  max_size             = 3
  min_size             = 3
  vpc_zone_identifier  = ["subnet-003582309bc21e5b1"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "atlantis2.domainsandbox.net"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.atlantis2.domainsandbox.net"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "a-etcd-events-atlantis2-domainsandbox-net" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                                   = "atlantis2.domainsandbox.net"
    Name                                                = "a.etcd-events.atlantis2.domainsandbox.net"
    "k8s.io/etcd/events"                                = "a/a"
    "k8s.io/role/master"                                = "1"
    "kubernetes.io/cluster/atlantis2.domainsandbox.net" = "owned"
  }
}

resource "aws_ebs_volume" "a-etcd-main-atlantis2-domainsandbox-net" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                                   = "atlantis2.domainsandbox.net"
    Name                                                = "a.etcd-main.atlantis2.domainsandbox.net"
    "k8s.io/etcd/main"                                  = "a/a"
    "k8s.io/role/master"                                = "1"
    "kubernetes.io/cluster/atlantis2.domainsandbox.net" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-atlantis2-domainsandbox-net" {
  name = "masters.atlantis2.domainsandbox.net"
  role = "${aws_iam_role.masters-atlantis2-domainsandbox-net.name}"
}

resource "aws_iam_instance_profile" "nodes-atlantis2-domainsandbox-net" {
  name = "nodes.atlantis2.domainsandbox.net"
  role = "${aws_iam_role.nodes-atlantis2-domainsandbox-net.name}"
}

resource "aws_iam_role" "masters-atlantis2-domainsandbox-net" {
  name               = "masters.atlantis2.domainsandbox.net"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.atlantis2.domainsandbox.net_policy")}"
}

resource "aws_iam_role" "nodes-atlantis2-domainsandbox-net" {
  name               = "nodes.atlantis2.domainsandbox.net"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.atlantis2.domainsandbox.net_policy")}"
}

resource "aws_iam_role_policy" "masters-atlantis2-domainsandbox-net" {
  name   = "masters.atlantis2.domainsandbox.net"
  role   = "${aws_iam_role.masters-atlantis2-domainsandbox-net.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.atlantis2.domainsandbox.net_policy")}"
}

resource "aws_iam_role_policy" "nodes-atlantis2-domainsandbox-net" {
  name   = "nodes.atlantis2.domainsandbox.net"
  role   = "${aws_iam_role.nodes-atlantis2-domainsandbox-net.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.atlantis2.domainsandbox.net_policy")}"
}

resource "aws_key_pair" "kubernetes-atlantis2-domainsandbox-net-ee432462f5196492507eb57388cf13cc" {
  key_name   = "kubernetes.atlantis2.domainsandbox.net-ee:43:24:62:f5:19:64:92:50:7e:b5:73:88:cf:13:cc"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.atlantis2.domainsandbox.net-ee432462f5196492507eb57388cf13cc_public_key")}"
}

resource "aws_launch_configuration" "master-us-east-1a-masters-atlantis2-domainsandbox-net" {
  name_prefix                 = "master-us-east-1a.masters.atlantis2.domainsandbox.net-"
  image_id                    = "ami-03b850a018c8cd25e"
  instance_type               = "t2.large"
  key_name                    = "${aws_key_pair.kubernetes-atlantis2-domainsandbox-net-ee432462f5196492507eb57388cf13cc.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-atlantis2-domainsandbox-net.id}"
  security_groups             = ["${aws_security_group.masters-atlantis2-domainsandbox-net.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-east-1a.masters.atlantis2.domainsandbox.net_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-atlantis2-domainsandbox-net" {
  name_prefix                 = "nodes.atlantis2.domainsandbox.net-"
  image_id                    = "ami-03b850a018c8cd25e"
  instance_type               = "t2.xlarge"
  key_name                    = "${aws_key_pair.kubernetes-atlantis2-domainsandbox-net-ee432462f5196492507eb57388cf13cc.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-atlantis2-domainsandbox-net.id}"
  security_groups             = ["${aws_security_group.nodes-atlantis2-domainsandbox-net.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.atlantis2.domainsandbox.net_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  spot_price        = "0.07"
  enable_monitoring = false
}

resource "aws_security_group" "masters-atlantis2-domainsandbox-net" {
  name        = "masters.atlantis2.domainsandbox.net"
  vpc_id      = "vpc-02ce3c582cd4ebbff"
  description = "Security group for masters"

  tags = {
    KubernetesCluster                                   = "atlantis2.domainsandbox.net"
    Name                                                = "masters.atlantis2.domainsandbox.net"
    "kubernetes.io/cluster/atlantis2.domainsandbox.net" = "owned"
  }
}

resource "aws_security_group" "nodes-atlantis2-domainsandbox-net" {
  name        = "nodes.atlantis2.domainsandbox.net"
  vpc_id      = "vpc-02ce3c582cd4ebbff"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                                   = "atlantis2.domainsandbox.net"
    Name                                                = "nodes.atlantis2.domainsandbox.net"
    "kubernetes.io/cluster/atlantis2.domainsandbox.net" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-atlantis2-domainsandbox-net.id}"
  source_security_group_id = "${aws_security_group.masters-atlantis2-domainsandbox-net.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-atlantis2-domainsandbox-net.id}"
  source_security_group_id = "${aws_security_group.masters-atlantis2-domainsandbox-net.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-atlantis2-domainsandbox-net.id}"
  source_security_group_id = "${aws_security_group.nodes-atlantis2-domainsandbox-net.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "https-external-to-master-3-90-144-90--32" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-atlantis2-domainsandbox-net.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["3.90.144.90/32"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-atlantis2-domainsandbox-net.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-atlantis2-domainsandbox-net.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-protocol-ipip" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-atlantis2-domainsandbox-net.id}"
  source_security_group_id = "${aws_security_group.nodes-atlantis2-domainsandbox-net.id}"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "4"
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-atlantis2-domainsandbox-net.id}"
  source_security_group_id = "${aws_security_group.nodes-atlantis2-domainsandbox-net.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4001" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-atlantis2-domainsandbox-net.id}"
  source_security_group_id = "${aws_security_group.nodes-atlantis2-domainsandbox-net.id}"
  from_port                = 2382
  to_port                  = 4001
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-atlantis2-domainsandbox-net.id}"
  source_security_group_id = "${aws_security_group.nodes-atlantis2-domainsandbox-net.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-atlantis2-domainsandbox-net.id}"
  source_security_group_id = "${aws_security_group.nodes-atlantis2-domainsandbox-net.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-3-90-144-90--32" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-atlantis2-domainsandbox-net.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["3.90.144.90/32"]
}

resource "aws_security_group_rule" "ssh-external-to-node-3-90-144-90--32" {
  type              = "ingress"
  security_group_id = "${aws_security_group.nodes-atlantis2-domainsandbox-net.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["3.90.144.90/32"]
}

terraform = {
  required_version = ">= 0.9.3"
}
