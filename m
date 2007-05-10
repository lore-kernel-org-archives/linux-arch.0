Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:36882 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754996AbXEJWoP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 May 2007 18:44:15 -0400
Date: Thu, 10 May 2007 15:44:12 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: New slab allocator SLUB
In-Reply-To: <20070510.153843.66277978.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0705101543320.13998@schroedinger.engr.sgi.com>
References: <20070510.153019.124084029.davem@davemloft.net>
 <Pine.LNX.4.64.0705101533140.13801@schroedinger.engr.sgi.com>
 <20070510.153531.82102171.davem@davemloft.net> <20070510.153843.66277978.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 10 May 2007, David Miller wrote:

> Ugh, it won't build, you can't use min() because this is
> evaluated at compile time to compute array sizes etc.
> 
> include/linux/slub_def.h:76: error: braced-group within expression allowed only inside a function

Rats. Then we have to do it by hand. This compiles here...


---
 include/linux/slub_def.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: slub/include/linux/slub_def.h
===================================================================
--- slub.orig/include/linux/slub_def.h	2007-05-10 15:19:39.000000000 -0700
+++ slub/include/linux/slub_def.h	2007-05-10 15:42:57.000000000 -0700
@@ -59,7 +59,8 @@ struct kmem_cache {
 #define KMALLOC_SHIFT_LOW 3
 
 #ifdef CONFIG_LARGE_ALLOCS
-#define KMALLOC_SHIFT_HIGH 25
+#define KMALLOC_SHIFT_HIGH ((MAX_ORDER + PAGE_SHIFT) < 25 ? \
+				MAX_ORDER + PAGE_SHIFT : 25)
 #else
 #if !defined(CONFIG_MMU) || NR_CPUS > 512 || MAX_NUMNODES > 256
 #define KMALLOC_SHIFT_HIGH 20
@@ -86,6 +87,9 @@ static inline int kmalloc_index(int size
 	 */
 	WARN_ON_ONCE(size == 0);
 
+	if (size >= (1UL << KMALLOC_SHIFT_HIGH))
+		return -1;
+
 	if (size > 64 && size <= 96)
 		return 1;
 	if (size > 128 && size <= 192)
 
