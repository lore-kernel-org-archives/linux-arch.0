Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:49189 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752859AbcILUi7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Sep 2016 16:38:59 -0400
Subject: [PATCH] x86/pkeys: fix pkeys build breakage for some non-x86 arches
From: Dave Hansen <dave@sr71.net>
Date: Mon, 12 Sep 2016 13:38:42 -0700
Message-ID: <20160912203842.48E7AC50@viggo.jf.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Dave Hansen <dave@sr71.net>, dave.hansen@intel.com, arnd@arndb.de, tglx@linutronix.de, linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20160912203842.JZEwLTpGeTp9KStrDKavV01aIBwiDRqR6aQV0ZI8wVM@z>


From: Dave Hansen <dave.hansen@intel.com>

Guenter Roeck reported [1] breakage on the h8300 and c6x
architectures (among others) caused by the new memory protection
keys syscalls.  This patch does what Arnd suggested and adds them
to kernel/sys_ni.c.

1. http://marc.info/?l=linux-kernel&m=147369214820072&w=2

Signed-off-by: Dave Hansen <dave.hansen@intel.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "open list:ABI/API" <linux-api@vger.kernel.org>
Cc: linux-arch@vger.kernel.org
---

 b/kernel/sys_ni.c |    5 +++++
 1 file changed, 5 insertions(+)

diff -puN kernel/sys_ni.c~fix-pkeys-arch-breakage kernel/sys_ni.c
--- a/kernel/sys_ni.c~fix-pkeys-arch-breakage	2016-09-12 13:35:17.449066541 -0700
+++ b/kernel/sys_ni.c	2016-09-12 13:35:17.452066676 -0700
@@ -250,3 +250,8 @@ cond_syscall(sys_execveat);
 
 /* membarrier */
 cond_syscall(sys_membarrier);
+
+/* memory protection keys */
+cond_syscall(sys_pkey_mprotect);
+cond_syscall(sys_pkey_alloc);
+cond_syscall(sys_pkey_free);
_
