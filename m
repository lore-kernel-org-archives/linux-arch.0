Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:51803 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761751AbXKPXLH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Nov 2007 18:11:07 -0500
Message-Id: <20071116231106.754876432@sgi.com>
References: <20071116230920.278761667@sgi.com>
Date: Fri, 16 Nov 2007 15:09:39 -0800
From: Christoph Lameter <clameter@sgi.com>
Subject: [patch 19/30] cpu alloc: tcp statistics
Content-Disposition: inline; filename=0029-cpu-alloc-tcp-statistics.patch
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-arch.vger.kernel.org>

Signed-off-by: Christoph Lameter <clameter@sgi.com>
---
 net/ipv4/tcp.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6/net/ipv4/tcp.c
===================================================================
--- linux-2.6.orig/net/ipv4/tcp.c	2007-11-15 21:17:24.267654551 -0800
+++ linux-2.6/net/ipv4/tcp.c	2007-11-15 21:25:34.214404334 -0800
@@ -2273,7 +2273,7 @@ static void __tcp_free_md5sig_pool(struc
 {
 	int cpu;
 	for_each_possible_cpu(cpu) {
-		struct tcp_md5sig_pool *p = *per_cpu_ptr(pool, cpu);
+		struct tcp_md5sig_pool *p = *CPU_PTR(pool, cpu);
 		if (p) {
 			if (p->md5_desc.tfm)
 				crypto_free_hash(p->md5_desc.tfm);
@@ -2281,7 +2281,7 @@ static void __tcp_free_md5sig_pool(struc
 			p = NULL;
 		}
 	}
-	free_percpu(pool);
+	CPU_FREE(pool);
 }
 
 void tcp_free_md5sig_pool(void)
@@ -2305,7 +2305,7 @@ static struct tcp_md5sig_pool **__tcp_al
 	int cpu;
 	struct tcp_md5sig_pool **pool;
 
-	pool = alloc_percpu(struct tcp_md5sig_pool *);
+	pool = CPU_ALLOC(struct tcp_md5sig_pool *, GFP_KERNEL);
 	if (!pool)
 		return NULL;
 
@@ -2316,7 +2316,7 @@ static struct tcp_md5sig_pool **__tcp_al
 		p = kzalloc(sizeof(*p), GFP_KERNEL);
 		if (!p)
 			goto out_free;
-		*per_cpu_ptr(pool, cpu) = p;
+		*CPU_PTR(pool, cpu) = p;
 
 		hash = crypto_alloc_hash("md5", 0, CRYPTO_ALG_ASYNC);
 		if (!hash || IS_ERR(hash))
@@ -2381,7 +2381,7 @@ struct tcp_md5sig_pool *__tcp_get_md5sig
 	if (p)
 		tcp_md5sig_users++;
 	spin_unlock_bh(&tcp_md5sig_pool_lock);
-	return (p ? *per_cpu_ptr(p, cpu) : NULL);
+	return (p ? *CPU_PTR(p, cpu) : NULL);
 }
 
 EXPORT_SYMBOL(__tcp_get_md5sig_pool);

-- 
