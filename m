From: akpm@linux-foundation.org
Subject: [patch 096/176] vmlinux.lds.h: gather .data..shared_aligned sections in DATA_DATA
Date: Tue, 26 Oct 2010 14:22:29 -0700
Message-ID: <201010262122.o9QLMTXA016665@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34278 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758206Ab0JZVX5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 26 Oct 2010 17:23:57 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, vapier@gentoo.org, alan-jenkins@tuffmail.co.uk, gerg@snapgear.com, jeremy@xensource.com, linux-arch@vger.kernel.org, rusty@rustcorp.com.au, sam@ravnborg.org

From: Mike Frysinger <vapier@gentoo.org>

With the recent change "net: remove time limit in process_backlog()", the
softnet_data variable changed from "DEFINE_PER_CPU()" to
"DEFINE_PER_CPU_ALIGNED()" which moved it from the .data section to the
.data.shared_align section.  I'm not saying this patch is wrong, just that
is what caused me to notice this larger problem.  No one else in the
kernel is using this aligned macro variant, so I imagine that's why no one
has noticed yet.

Since .data..shared_align isn't declared in any vmlinux files that I can
see, the linker just places it last.  This "just works" for most people,
but when building a ROM kernel on Blackfin systems, it causes section
overlap errors:

bfin-uclinux-ld.real:
	section .init.data [00000000202e06b8 -> 00000000202e48b7] overlaps
	section .data.shared_aligned [00000000202e06b8 -> 00000000202e0723]

I imagine other arches which support the ROM config option and thus do
funky placement would see similar issues ...

On x86, it is stuck in a dedicated section at the end:
 [8] .data             PROGBITS ffffffff810ec000 2ec0000303a8 00 WA 0 0 4096
 [9] .data.shared_alig PROGBITS ffffffff8111c3c0 31c3c00000c8 00 WA 0 0 64

So make sure we include this section in the DATA_DATA macro so that it is
placed in the right location.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Greg Ungerer <gerg@snapgear.com>
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/asm-generic/vmlinux.lds.h |    1 +
 1 file changed, 1 insertion(+)

diff -puN include/asm-generic/vmlinux.lds.h~vmlinuxldsh-gather-datashared_aligned-sections-in-data_data include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h~vmlinuxldsh-gather-datashared_aligned-sections-in-data_data
+++ a/include/asm-generic/vmlinux.lds.h
@@ -150,6 +150,7 @@
 #define DATA_DATA							\
 	*(.data)							\
 	*(.ref.data)							\
+	*(.data..shared_aligned) /* percpu related */			\
 	DEV_KEEP(init.data)						\
 	DEV_KEEP(exit.data)						\
 	CPU_KEEP(init.data)						\
_
