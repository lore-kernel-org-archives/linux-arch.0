From: David Howells <dhowells@redhat.com>
Subject: [PATCH 13/35] UAPI: elf_read_implies_exec() is a kernel-only feature
 - so hide from userspace
Date: Sat, 02 Jul 2011 12:09:27 +0100
Message-ID: <20110702110927.21948.8187.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47715 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201Ab1GBLJb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:09:31 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62B9Umm028471
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:09:31 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

elf_read_implies_exec() is a kernel-only feature as the second parameter is a
constant that isn't exported to userspace.  Not only that, but the
arch-specific overrides are not exported either.

So hide the macro from userspace.

Similarly, struct file should not be predeclared in userspace.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/elf.h |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/elf.h b/include/linux/elf.h
index 110821c..411d7b8 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -7,15 +7,6 @@
 #include <asm/elf.h>
 #endif
 
-struct file;
-
-#ifndef elf_read_implies_exec
-  /* Executables for which elf_read_implies_exec() returns TRUE will
-     have the READ_IMPLIES_EXEC personality flag set automatically.
-     Override in asm/elf.h as needed.  */
-# define elf_read_implies_exec(ex, have_pt_gnu_stack)	0
-#endif
-
 /* 32-bit ELF base types. */
 typedef __u32	Elf32_Addr;
 typedef __u16	Elf32_Half;
@@ -413,6 +404,13 @@ typedef struct elf64_note {
 } Elf64_Nhdr;
 
 #ifdef __KERNEL__
+#ifndef elf_read_implies_exec
+  /* Executables for which elf_read_implies_exec() returns TRUE will
+     have the READ_IMPLIES_EXEC personality flag set automatically.
+     Override in asm/elf.h as needed.  */
+# define elf_read_implies_exec(ex, have_pt_gnu_stack)	0
+#endif
+
 #if ELF_CLASS == ELFCLASS32
 
 extern Elf32_Dyn _DYNAMIC [];
@@ -436,6 +434,8 @@ extern Elf64_Dyn _DYNAMIC [];
 #endif
 
 /* Optional callbacks to write extra ELF notes. */
+struct file;
+
 #ifndef ARCH_HAVE_EXTRA_ELF_NOTES
 static inline int elf_coredump_extra_notes_size(void) { return 0; }
 static inline int elf_coredump_extra_notes_write(struct file *file,
