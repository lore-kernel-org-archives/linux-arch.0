From: Christoph Lameter <clameter@sgi.com>
Subject: [patch 16/41] cpu alloc: Tcp statistics conversion
Date: Thu, 29 May 2008 20:56:36 -0700
Message-ID: <20080530040015.783737944@sgi.com>
References: <20080530035620.587204923@sgi.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:40501 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751995AbYE3EAS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 00:00:18 -0400
Content-Disposition: inline; filename=cpu_alloc_tcp_statistics_conversion
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Mike Travis <travis@sgi.com>

Convert tcp statistics to cpu alloc.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
---
 net/ipv4/tcp.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6/net/ipv4/tcp.c
===================================================================
--- linux-2.6.orig/net/ipv4/tcp.c	2008-04-29 14:55:55.000000000 -0700
+++ linux-2.6/net/ipv4/tcp.c	2008-05-21 21:46:54.000000000 -0700
@@ -2456,7 +2456,7 @@
 {
 	int cpu;
 	for_each_possible_cpu(cpu) {
-		struct tcp_md5sig_pool *p = *per_cpu_ptr(pool, cpu);
+		struct tcp_md5sig_pool *p = *CPU_PTR(pool, cpu);
 		if (p) {
 			if (p->md5_desc.tfm)
 				crypto_free_hash(p->md5_desc.tfm);
@@ -2464,7 +2464,7 @@
 			p = NULL;
 		}
 	}
-	free_percpu(pool);
+	CPU_FREE(pool);
 }
 
 void tcp_free_md5sig_pool(void)
@@ -2488,7 +2488,7 @@
 	int cpu;
 	struct tcp_md5sig_pool **pool;
 
-	pool = alloc_percpu(struct tcp_md5sig_pool *);
+	pool = CPU_ALLOC(struct tcp_md5sig_pool *, GFP_KERNEL);
 	if (!pool)
 		return NULL;
 
@@ -2499,7 +2499,7 @@
 		p = kzalloc(sizeof(*p), GFP_KERNEL);
 		if (!p)
 			goto out_free;
-		*per_cpu_ptr(pool, cpu) = p;
+		*CPU_PTR(pool, cpu) = p;
 
 		hash = crypto_alloc_hash("md5", 0, CRYPTO_ALG_ASYNC);
 		if (!hash || IS_ERR(hash))
@@ -2564,7 +2564,7 @@
 	if (p)
 		tcp_md5sig_users++;
 	spin_unlock_bh(&tcp_md5sig_pool_lock);
-	return (p ? *per_cpu_ptr(p, cpu) : NULL);
+	return (p ? *CPU_PTR(p, cpu) : NULL);
 }
 
 EXPORT_SYMBOL(__tcp_get_md5sig_pool);

-- 
