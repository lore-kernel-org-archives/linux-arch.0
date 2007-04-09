Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:41059 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbXDINNs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Apr 2007 09:13:48 -0400
Received: by py-out-1112.google.com with SMTP id a29so1021109pyi
        for <linux-arch@vger.kernel.org>; Mon, 09 Apr 2007 06:13:47 -0700 (PDT)
Date: Mon, 9 Apr 2007 22:08:47 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH] slob: handle SLAB_PANIC flag
Message-ID: <20070409130847.GA5048@APFDCB5C>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Matt Mackall <mpm@selenic.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

kmem_cache_create() for slob doesn't handle SLAB_PANIC.

Cc: Matt Mackall <mpm@selenic.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 mm/slob.c |    3 +++
 1 file changed, 3 insertions(+)

Index: 2.6-mm/mm/slob.c
===================================================================
--- 2.6-mm.orig/mm/slob.c
+++ 2.6-mm/mm/slob.c
@@ -298,6 +298,9 @@ struct kmem_cache *kmem_cache_create(con
 		c->align = (flags & SLAB_MUST_HWCACHE_ALIGN) ? SLOB_ALIGN : 0;
 		if (c->align < align)
 			c->align = align;
+	} else {
+		if (flags & SLAB_PANIC)
+			panic("Cannot create slab cache %s\n", name);
 	}
 
 	return c;
