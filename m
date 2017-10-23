From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 07/19] net: netlink/netfilter: Kill off ACCESS_ONCE()
Date: Mon, 23 Oct 2017 14:07:17 -0700
Message-ID: <1508792849-3115-7-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751617AbdJWVHm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Oct 2017 17:07:42 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9NL7Jcc137693
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:42 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dsheuaqrk-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:41 -0400
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 23 Oct 2017 17:07:41 -0400
In-Reply-To: <20171023210408.GA2930@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org, torvalds@linux-foundation.org, Florian Westphal <fw@strlen.de>, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Pablo Neira Ayuso <pablo@netfilter.org>

From: Mark Rutland <mark.rutland@arm.com>

For several reasons, it is desirable to use {READ,WRITE}_ONCE() in
preference to ACCESS_ONCE(), and new code is expected to use one of the
former. So far, there's been no reason to change most existing uses of
ACCESS_ONCE(), as these aren't currently harmful.

However, for some features it is necessary to instrument reads and
writes separately, which is not possible with ACCESS_ONCE(). This
distinction is critical to correct operation.

It's possible to transform the bulk of kernel code using the Coccinelle
script below. However, this doesn't handle comments, leaving references
to ACCESS_ONCE() instances which have been removed. As a preparatory
step, this patch converts netlink and netfilter code and comments to use
{READ,WRITE}_ONCE() consistently.

----
virtual patch

@ depends on patch @
expression E1, E2;
@@

- ACCESS_ONCE(E1) = E2
+ WRITE_ONCE(E1, E2)

@ depends on patch @
expression E;
@@

- ACCESS_ONCE(E)
+ READ_ONCE(E)
----

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Florian Westphal <fw@strlen.de>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/linux/genetlink.h           | 2 +-
 include/linux/netfilter/nfnetlink.h | 2 +-
 include/linux/rtnetlink.h           | 2 +-
 include/net/netfilter/nf_tables.h   | 4 ++--
 net/netfilter/ipvs/ip_vs_sync.c     | 2 +-
 net/netfilter/nfnetlink_queue.c     | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/genetlink.h b/include/linux/genetlink.h
index a4c61cbce777..0e694cf62414 100644
--- a/include/linux/genetlink.h
+++ b/include/linux/genetlink.h
@@ -30,7 +30,7 @@ extern wait_queue_head_t genl_sk_destructing_waitq;
  * @p: The pointer to read, prior to dereferencing
  *
  * Return the value of the specified RCU-protected pointer, but omit
- * both the smp_read_barrier_depends() and the ACCESS_ONCE(), because
+ * both the smp_read_barrier_depends() and the READ_ONCE(), because
  * caller holds genl mutex.
  */
 #define genl_dereference(p)					\
diff --git a/include/linux/netfilter/nfnetlink.h b/include/linux/netfilter/nfnetlink.h
index 41d04e9d088a..0f47a4aa7fc4 100644
--- a/include/linux/netfilter/nfnetlink.h
+++ b/include/linux/netfilter/nfnetlink.h
@@ -66,7 +66,7 @@ static inline bool lockdep_nfnl_is_held(__u8 subsys_id)
  * @ss: The nfnetlink subsystem ID
  *
  * Return the value of the specified RCU-protected pointer, but omit
- * both the smp_read_barrier_depends() and the ACCESS_ONCE(), because
+ * both the smp_read_barrier_depends() and the READ_ONCE(), because
  * caller holds the NFNL subsystem mutex.
  */
 #define nfnl_dereference(p, ss)					\
diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index dea59c8eec54..765f7b915475 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -67,7 +67,7 @@ static inline bool lockdep_rtnl_is_held(void)
  * @p: The pointer to read, prior to dereferencing
  *
  * Return the value of the specified RCU-protected pointer, but omit
- * both the smp_read_barrier_depends() and the ACCESS_ONCE(), because
+ * both the smp_read_barrier_depends() and the READ_ONCE(), because
  * caller holds RTNL.
  */
 #define rtnl_dereference(p)					\
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 0f5b12a4ad09..5c68e279eaea 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1164,8 +1164,8 @@ static inline u8 nft_genmask_next(const struct net *net)
 
 static inline u8 nft_genmask_cur(const struct net *net)
 {
-	/* Use ACCESS_ONCE() to prevent refetching the value for atomicity */
-	return 1 << ACCESS_ONCE(net->nft.gencursor);
+	/* Use READ_ONCE() to prevent refetching the value for atomicity */
+	return 1 << READ_ONCE(net->nft.gencursor);
 }
 
 #define NFT_GENMASK_ANY		((1 << 0) | (1 << 1))
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 0e5b64a75da0..1cfffd42d1e2 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -457,7 +457,7 @@ static inline bool in_persistence(struct ip_vs_conn *cp)
 static int ip_vs_sync_conn_needed(struct netns_ipvs *ipvs,
 				  struct ip_vs_conn *cp, int pkts)
 {
-	unsigned long orig = ACCESS_ONCE(cp->sync_endtime);
+	unsigned long orig = READ_ONCE(cp->sync_endtime);
 	unsigned long now = jiffies;
 	unsigned long n = (now + cp->timeout) & ~3UL;
 	unsigned int sync_refresh_period;
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index c9796629858f..a16356cacec3 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -401,7 +401,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 
 	outdev = entry->state.out;
 
-	switch ((enum nfqnl_config_mode)ACCESS_ONCE(queue->copy_mode)) {
+	switch ((enum nfqnl_config_mode)READ_ONCE(queue->copy_mode)) {
 	case NFQNL_COPY_META:
 	case NFQNL_COPY_NONE:
 		break;
@@ -412,7 +412,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 		    skb_checksum_help(entskb))
 			return NULL;
 
-		data_len = ACCESS_ONCE(queue->copy_range);
+		data_len = READ_ONCE(queue->copy_range);
 		if (data_len > entskb->len)
 			data_len = entskb->len;
 
-- 
2.5.2
