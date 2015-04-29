From: David Howells <dhowells@redhat.com>
Subject: [PATCH 12/13] netlink: Use bool when returning boolean values
Date: Wed, 29 Apr 2015 20:22:46 +0100
Message-ID: <20150429192246.24909.90963.stgit@warthog.procyon.org.uk>
References: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Return bool from netlink functions that return boolean values.  This allows
gcc to make better choices.

Note that !! on a bool value is not required and that when adding/subtracting
a bool, it is converted to 0 or 1 as appropriate.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/netfilter/nfnetlink.h |    2 +-
 include/linux/netlink.h             |    2 +-
 net/netfilter/nfnetlink.c           |    2 +-
 net/netlink/af_netlink.c            |   21 +++++++++++----------
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/netfilter/nfnetlink.h b/include/linux/netfilter/nfnetlink.h
index e955d4730625..53f7def6b568 100644
--- a/include/linux/netfilter/nfnetlink.h
+++ b/include/linux/netfilter/nfnetlink.h
@@ -33,7 +33,7 @@ struct nfnetlink_subsystem {
 int nfnetlink_subsys_register(const struct nfnetlink_subsystem *n);
 int nfnetlink_subsys_unregister(const struct nfnetlink_subsystem *n);
 
-int nfnetlink_has_listeners(struct net *net, unsigned int group);
+bool nfnetlink_has_listeners(struct net *net, unsigned int group);
 struct sk_buff *nfnetlink_alloc_skb(struct net *net, unsigned int size,
 				    u32 dst_portid, gfp_t gfp_mask);
 int nfnetlink_send(struct sk_buff *skb, struct net *net, u32 portid,
diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index 6835c1279df7..ccb535afb707 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -65,7 +65,7 @@ extern int __netlink_change_ngroups(struct sock *sk, unsigned int groups);
 extern int netlink_change_ngroups(struct sock *sk, unsigned int groups);
 extern void __netlink_clear_multicast_users(struct sock *sk, unsigned int group);
 extern void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err);
-extern int netlink_has_listeners(struct sock *sk, unsigned int group);
+extern bool netlink_has_listeners(struct sock *sk, unsigned int group);
 extern struct sk_buff *netlink_alloc_skb(struct sock *ssk, unsigned int size,
 					 u32 dst_portid, gfp_t gfp_mask);
 extern int netlink_unicast(struct sock *ssk, struct sk_buff *skb, __u32 portid, int nonblock);
diff --git a/net/netfilter/nfnetlink.c b/net/netfilter/nfnetlink.c
index 8b117c90ecd7..503a5561ea96 100644
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -116,7 +116,7 @@ nfnetlink_find_client(u_int16_t type, const struct nfnetlink_subsystem *ss)
 	return &ss->cb[cb_id];
 }
 
-int nfnetlink_has_listeners(struct net *net, unsigned int group)
+bool nfnetlink_has_listeners(struct net *net, unsigned int group)
 {
 	return netlink_has_listeners(net->nfnl, group);
 }
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index ec4adbdcb9b4..06d6c91e4d1c 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1871,9 +1871,9 @@ out:
 }
 EXPORT_SYMBOL_GPL(netlink_alloc_skb);
 
-int netlink_has_listeners(struct sock *sk, unsigned int group)
+bool netlink_has_listeners(struct sock *sk, unsigned int group)
 {
-	int res = 0;
+	bool res = false;
 	struct listeners *listeners;
 
 	BUG_ON(!netlink_is_kernel(sk));
@@ -2042,10 +2042,10 @@ struct netlink_set_err_data {
 	int code;
 };
 
-static int do_one_set_err(struct sock *sk, struct netlink_set_err_data *p)
+static bool do_one_set_err(struct sock *sk, struct netlink_set_err_data *p)
 {
 	struct netlink_sock *nlk = nlk_sk(sk);
-	int ret = 0;
+	bool ret = false;
 
 	if (sk == p->exclude_sk)
 		goto out;
@@ -2058,7 +2058,7 @@ static int do_one_set_err(struct sock *sk, struct netlink_set_err_data *p)
 		goto out;
 
 	if (p->code == ENOBUFS && nlk->flags & NETLINK_RECV_NO_ENOBUFS) {
-		ret = 1;
+		ret = true;
 		goto out;
 	}
 
@@ -2103,13 +2103,14 @@ EXPORT_SYMBOL(netlink_set_err);
 /* must be called with netlink table grabbed */
 static void netlink_update_socket_mc(struct netlink_sock *nlk,
 				     unsigned int group,
-				     int is_new)
+				     bool is_new)
 {
-	int old, new = !!is_new, subscriptions;
+	bool old;
+	int subscriptions;
 
 	old = test_bit(group - 1, nlk->groups);
-	subscriptions = nlk->subscriptions - old + new;
-	if (new)
+	subscriptions = nlk->subscriptions - old + is_new;
+	if (is_new)
 		__set_bit(group - 1, nlk->groups);
 	else
 		__clear_bit(group - 1, nlk->groups);
@@ -2595,7 +2596,7 @@ void __netlink_clear_multicast_users(struct sock *ksk, unsigned int group)
 	struct netlink_table *tbl = &nl_table[ksk->sk_protocol];
 
 	sk_for_each_bound(sk, &tbl->mc_list)
-		netlink_update_socket_mc(nlk_sk(sk), group, 0);
+		netlink_update_socket_mc(nlk_sk(sk), group, false);
 }
 
 struct nlmsghdr *
