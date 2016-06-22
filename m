From: Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH] kasan: account for new sections when instrumenting globals
Date: Wed, 22 Jun 2016 19:07:18 +0200
Message-ID: <1466615238-57411-1-git-send-email-dvyukov@google.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36951 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbcFVRHY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2016 13:07:24 -0400
Received: by mail-wm0-f46.google.com with SMTP id a66so15086325wme.0
        for <linux-arch@vger.kernel.org>; Wed, 22 Jun 2016 10:07:23 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, ryabinin.a.a@gmail.com
Cc: kasan-dev@googlegroups.com, glider@google.com, Dmitry Vyukov <dvyukov@google.com>

When I build kernel with CONFIG_KASAN and gcc6 (which instruments globals
and inserts global constructors and destructors), vmlinux contains some
new unaccounted sections: .text.exit .text.startup .dtors.
This messes vvar/percpu layout. Want:

ffffffff822bfd80 D _edata
ffffffff822c0000 D __vvar_beginning_hack
ffffffff822c0000 A __vvar_page
ffffffff822c0080 0000000000000098 D vsyscall_gtod_data
ffffffff822c1000 A __init_begin
ffffffff822c1000 D init_per_cpu__irq_stack_union
ffffffff822c1000 A __per_cpu_load
ffffffff822d3000 D init_per_cpu__gdt_page

Got:

ffffffff8279a600 D _edata
ffffffff8279b000 A __vvar_page
ffffffff8279c000 A __init_begin
ffffffff8279c000 D init_per_cpu__irq_stack_union
ffffffff8279c000 A __per_cpu_load
ffffffff8279e000 D __vvar_beginning_hack
ffffffff8279e080 0000000000000098 D vsyscall_gtod_data
ffffffff827ae000 D init_per_cpu__gdt_page

If my reading of the linker script is correct, this happens because
__vvar_page and .vvar get different addresses here:
//arch/x86/kernel/vmlinux.lds.S

	. = ALIGN(PAGE_SIZE);
	__vvar_page = .;

	.vvar : AT(ADDR(.vvar) - LOAD_OFFSET) {
		/* work around gold bug 13023 */
		__vvar_beginning_hack = .;

Merge .text.exit into EXIT_TEXT, .text.startup into INIT_TEXT and
.dtors into INIT_DATA.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>

---

I can't say I fully understand what happens here, but it fixes my
build and boot. I think we need something along these lines,
but I am not sure about details.
---
 include/asm-generic/vmlinux.lds.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 6a67ab9..6067d01 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -510,6 +510,7 @@
 #define KERNEL_CTORS()	. = ALIGN(8);			   \
 			VMLINUX_SYMBOL(__ctors_start) = .; \
 			*(.ctors)			   \
+			*(.dtors)			   \
 			*(SORT(.init_array.*))		   \
 			*(.init_array)			   \
 			VMLINUX_SYMBOL(__ctors_end) = .;
@@ -542,7 +543,9 @@
 
 #define INIT_TEXT							\
 	*(.init.text)							\
-	MEM_DISCARD(init.text)
+	*(.text.startup)						\
+	MEM_DISCARD(init.text)						\
+	MEM_DISCARD(text.startup)
 
 #define EXIT_DATA							\
 	*(.exit.data)							\
@@ -551,7 +554,9 @@
 
 #define EXIT_TEXT							\
 	*(.exit.text)							\
-	MEM_DISCARD(exit.text)
+	*(.text.exit)							\
+	MEM_DISCARD(exit.text)						\
+	MEM_DISCARD(text.exit)
 
 #define EXIT_CALL							\
 	*(.exitcall.exit)
-- 
2.8.0.rc3.226.g39d4020
