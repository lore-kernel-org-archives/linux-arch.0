Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:35421 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755657AbXEJWVw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 May 2007 18:21:52 -0400
Date: Thu, 10 May 2007 15:21:52 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: New slab allocator SLUB
In-Reply-To: <20070510.151353.89387383.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0705101516520.13504@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0705081145360.11368@schroedinger.engr.sgi.com>
 <20070510.151353.89387383.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 10 May 2007, David Miller wrote:

> What SLAB allows you to do is define LARGE_ALLOCS but not necessarily
> set MAX_ORDER large enough for the largest kmalloc SLAB.  SLAB would
> ignore the kmalloc cache creation failures for these largest ones that
> are over MAX_ORDER.

Hmmm... How about limiting KMALLOC_SHIFT_HIGH to max order?

---
 include/linux/slub_def.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: slub/include/linux/slub_def.h
===================================================================
--- slub.orig/include/linux/slub_def.h	2007-05-10 15:19:39.000000000 -0700
+++ slub/include/linux/slub_def.h	2007-05-10 15:20:39.000000000 -0700
@@ -59,7 +59,7 @@ struct kmem_cache {
 #define KMALLOC_SHIFT_LOW 3
 
 #ifdef CONFIG_LARGE_ALLOCS
-#define KMALLOC_SHIFT_HIGH 25
+#define KMALLOC_SHIFT_HIGH (min(25, MAX_ORDER + PAGE_SHIFT))
 #else
 #if !defined(CONFIG_MMU) || NR_CPUS > 512 || MAX_NUMNODES > 256
 #define KMALLOC_SHIFT_HIGH 20
