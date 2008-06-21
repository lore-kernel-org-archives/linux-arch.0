From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: [RFC PATCH]rcu,alpha: avoid smp_read_barrier_depends in rcu_dereference
 when pointer==NULL
Date: Sat, 21 Jun 2008 17:54:01 +0800
Message-ID: <485CCFB9.9050208@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:49657 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752781AbYFUJzz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 21 Jun 2008 05:55:55 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-arch@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi, Paul and Alpha hackers

memory barrier is expensive, I think it's worth that adding an if-statement
to avoid it when pointer == NULL.

This patch change nothing in UP or in other architectures for compiler's
optimization.

			Thanks, Lai Jiangshan


Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
---
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index d42dbec..8979f29 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -143,7 +143,8 @@ struct rcu_head {
 
 #define rcu_dereference(p)     ({ \
 				typeof(p) _________p1 = ACCESS_ONCE(p); \
-				smp_read_barrier_depends(); \
+				if (_________p1) \
+					smp_read_barrier_depends(); \
 				(_________p1); \
 				})
 
