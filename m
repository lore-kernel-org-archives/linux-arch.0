Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755849AbdJJAW5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2017 20:22:57 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9A0JPEh117927
        for <linux-arch@vger.kernel.org>; Mon, 9 Oct 2017 20:22:57 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dgcabvs8b-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 09 Oct 2017 20:22:56 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Oct 2017 20:22:56 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/core/rcu 14/15] netfilter: Remove now-redundant smp_read_barrier_depends()
Date: Mon,  9 Oct 2017 17:22:48 -0700
In-Reply-To: <20171010001951.GA6476@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
Message-ID: <1507594969-8347-14-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org
Message-ID: <20171010002248.bGwEtrAX-8DDy6esLbObVWDdln09lHqXNoSa8zX5KIk@z>

READ_ONCE() now implies smp_read_barrier_depends(), which means that
the instances in arpt_do_table(), ipt_do_table(), and ip6t_do_table()
are now redundant.  This commit removes them and adjusts the comments.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Cc: Florian Westphal <fw@strlen.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: <netfilter-devel@vger.kernel.org>
Cc: <coreteam@netfilter.org>
Cc: <netdev@vger.kernel.org>
---
 net/ipv4/netfilter/arp_tables.c | 7 +------
 net/ipv4/netfilter/ip_tables.c  | 7 +------
 net/ipv6/netfilter/ip6_tables.c | 7 +------
 3 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index 9e2770fd00be..d555b3b31c49 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -202,13 +202,8 @@ unsigned int arpt_do_table(struct sk_buff *skb,
 
 	local_bh_disable();
 	addend = xt_write_recseq_begin();
-	private = table->private;
+	private = READ_ONCE(table->private); /* Address dependency. */
 	cpu     = smp_processor_id();
-	/*
-	 * Ensure we load private-> members after we've fetched the base
-	 * pointer.
-	 */
-	smp_read_barrier_depends();
 	table_base = private->entries;
 	jumpstack  = (struct arpt_entry **)private->jumpstack[cpu];
 
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 39286e543ee6..f63752bec442 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -260,13 +260,8 @@ ipt_do_table(struct sk_buff *skb,
 	WARN_ON(!(table->valid_hooks & (1 << hook)));
 	local_bh_disable();
 	addend = xt_write_recseq_begin();
-	private = table->private;
+	private = READ_ONCE(table->private); /* Address dependency. */
 	cpu        = smp_processor_id();
-	/*
-	 * Ensure we load private-> members after we've fetched the base
-	 * pointer.
-	 */
-	smp_read_barrier_depends();
 	table_base = private->entries;
 	jumpstack  = (struct ipt_entry **)private->jumpstack[cpu];
 
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index 01bd3ee5ebc6..52afcab9b0d6 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -282,12 +282,7 @@ ip6t_do_table(struct sk_buff *skb,
 
 	local_bh_disable();
 	addend = xt_write_recseq_begin();
-	private = table->private;
-	/*
-	 * Ensure we load private-> members after we've fetched the base
-	 * pointer.
-	 */
-	smp_read_barrier_depends();
+	private = READ_ONCE(table->private); /* Address dependency. */
 	cpu        = smp_processor_id();
 	table_base = private->entries;
 	jumpstack  = (struct ip6t_entry **)private->jumpstack[cpu];
-- 
2.5.2
