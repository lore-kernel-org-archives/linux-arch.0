From: akpm@linux-foundation.org
Subject: [patch 097/176] vmlinux.lds.h: lower init ramfs alignment to 4
Date: Tue, 26 Oct 2010 14:22:30 -0700
Message-ID: <201010262122.o9QLMU9a016668@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40432 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760453Ab0JZVXh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 26 Oct 2010 17:23:37 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, vapier@gentoo.org, linux-arch@vger.kernel.org, sam@ravnborg.org, viro@zeniv.linux.org.uk

From: Mike Frysinger <vapier@gentoo.org>

The new init ramfs format (cpio based) requires an alignment of 4 (per the
documentation and per the source files themselves).  As for compressed
sources, the decompressors can all deal with unaligned buffers.

The cpio source is also found in the __init sections of the kernel, so
once they are read and expanded into a tmpfs, the source is freed.  That
means there is no need to force page alignment here either.

This has been used on Blackfin systems for many releases without issue.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/asm-generic/vmlinux.lds.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN include/asm-generic/vmlinux.lds.h~vmlinuxldsh-lower-init-ramfs-alignment-to-4 include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h~vmlinuxldsh-lower-init-ramfs-alignment-to-4
+++ a/include/asm-generic/vmlinux.lds.h
@@ -637,7 +637,7 @@
 
 #ifdef CONFIG_BLK_DEV_INITRD
 #define INIT_RAM_FS							\
-	. = ALIGN(PAGE_SIZE);						\
+	. = ALIGN(4);							\
 	VMLINUX_SYMBOL(__initramfs_start) = .;				\
 	*(.init.ramfs)							\
 	VMLINUX_SYMBOL(__initramfs_end) = .;
_
