Return-Path: <manfred@colorfullife.com>
Received: from dbl.q-ag.de ([213.172.117.3]:4321 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262273AbUEOMYF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 15 May 2004 08:24:05 -0400
Message-ID: <40A60BE1.2060809@colorfullife.com>
Date: Sat, 15 May 2004 14:24:01 +0200
From: Manfred Spraul <manfred@colorfullife.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Allow arch override for kmem_bufctl_t
References: <40A60984.1070202@colorfullife.com>
In-Reply-To: <40A60984.1070202@colorfullife.com>
Content-Type: multipart/mixed;
 boundary="------------000405080309020506010808"
To: Andrew Morton <akpm@digeo.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000405080309020506010808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attached is the patch - sorry.

--
    Manfred

--------------000405080309020506010808
Content-Type: text/plain;
 name="patch-slab-mm-02-bufctl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-mm-02-bufctl"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 6
//  EXTRAVERSION = -mm2
--- 2.6/mm/slab.c	2004-05-15 11:38:22.000000000 +0200
+++ build-2.6/mm/slab.c	2004-05-15 13:01:47.000000000 +0200
@@ -161,10 +161,9 @@
  * is less than 512 (PAGE_SIZE<<3), but greater than 256.
  */
 
-#define BUFCTL_END	0xffffFFFF
-#define BUFCTL_FREE	0xffffFFFE
-#define	SLAB_LIMIT	0xffffFFFD
-typedef unsigned int kmem_bufctl_t;
+#define BUFCTL_END	(((kmem_bufctl_t)(~0U))-0)
+#define BUFCTL_FREE	(((kmem_bufctl_t)(~0U))-1)
+#define	SLAB_LIMIT	(((kmem_bufctl_t)(~0U))-2)
 
 /* Max number of objs-per-slab for caches which use off-slab slabs.
  * Needed to avoid a possible looping condition in cache_grow().
--- 2.6/include/linux/types.h	2004-05-15 11:21:51.000000000 +0200
+++ build-2.6/include/linux/types.h	2004-05-15 12:57:29.000000000 +0200
@@ -140,6 +140,9 @@
 #define pgoff_t unsigned long
 #endif
 
+#ifndef HAVE_KMEM_BUFCTL_T
+typedef unsigned int kmem_bufctl_t;
+#endif
 #endif /* __KERNEL_STRICT_NAMES */
 
 /*
--- 2.6/include/asm-i386/types.h	2004-01-09 07:59:44.000000000 +0100
+++ build-2.6/include/asm-i386/types.h	2004-05-15 12:57:51.000000000 +0200
@@ -63,6 +63,9 @@
 #define HAVE_SECTOR_T
 #endif
 
+#define HAVE_KMEM_BUFCTL_T 1
+typedef unsigned short kmem_bufctl_t;
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */

--------------000405080309020506010808--
