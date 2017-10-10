From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/core/rcu 07/15] rtnetlink: Update now-misleading smp_read_barrier_depends() comment
Date: Mon,  9 Oct 2017 17:22:41 -0700
Message-ID: <1507594969-8347-7-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755724AbdJJAW6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2017 20:22:58 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9A0LPcF143590
        for <linux-arch@vger.kernel.org>; Mon, 9 Oct 2017 20:22:58 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dgd11ab70-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 09 Oct 2017 20:22:57 -0400
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Oct 2017 20:22:56 -0400
In-Reply-To: <20171010001951.GA6476@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "David S. Miller" <davem@davemloft.net>, Vladislav Yasevich <vyasevic@redhat.com>, David Ahern <dsahern@gmail.com>, Vlad Yasevich <vyasevich@gmail.com>

Now that READ_ONCE() implies smp_read_barrier_depends(), update the
rtnl_dereference() header comment accordingly.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Vladislav Yasevich <vyasevic@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Vlad Yasevich <vyasevich@gmail.com>
---
 include/linux/rtnetlink.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 765f7b915475..107720d6b978 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -67,8 +67,7 @@ static inline bool lockdep_rtnl_is_held(void)
  * @p: The pointer to read, prior to dereferencing
  *
  * Return the value of the specified RCU-protected pointer, but omit
- * both the smp_read_barrier_depends() and the READ_ONCE(), because
- * caller holds RTNL.
+ * the READ_ONCE(), because caller holds RTNL.
  */
 #define rtnl_dereference(p)					\
 	rcu_dereference_protected(p, lockdep_rtnl_is_held())
-- 
2.5.2
