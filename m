From: Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH v4] vmlinux.lds: account for destructor sections
Date: Fri,  1 Jul 2016 17:19:23 +0200
Message-ID: <1467386363-120030-1-git-send-email-dvyukov@google.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, ryabinin.a.a@gmail.com
Cc: kasan-dev@googlegroups.com, glider@google.com, Dmitry Vyukov <dvyukov@google.com>
List-Id: linux-arch.vger.kernel.org

If CONFIG_KASAN is enabled and gcc is configured with
--disable-initfini-array and/or gold linker is used,
gcc emits .ctors/.dtors and .text.startup/.text.exit
sections instead of .init_array/.fini_array.
.dtors section is not explicitly accounted in the linker
script and messes vvar/percpu layout. Want:

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

This happens because __vvar_page and .vvar get different
addresses in arch/x86/kernel/vmlinux.lds.S:

	. = ALIGN(PAGE_SIZE);
	__vvar_page = .;

	.vvar : AT(ADDR(.vvar) - LOAD_OFFSET) {
		/* work around gold bug 13023 */
		__vvar_beginning_hack = .;

Discard .dtors/.fini_array/.text.exit, since we don't call dtors.
Merge .text.startup into init text.

Cc: <stable@vger.kernel.org> # v4.0+
Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>

---

Changes since v1:
 - discard .dtors
 - don't define .mem sections

Changes since v2:
 - use 'vmlinux.lds' subsystem prefix instead of 'kasan'

Changes since v3:
 - add 'Cc: <stable@vger.kernel.org> # v4.0+' tag
 - CC linux-kernel@vger.kernel.org,akpm@linux-foundation.org

---
 include/asm-generic/vmlinux.lds.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 6a67ab9..081d0f2 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -542,15 +542,19 @@
 
 #define INIT_TEXT							\
 	*(.init.text)							\
+	*(.text.startup)						\
 	MEM_DISCARD(init.text)
 
 #define EXIT_DATA							\
 	*(.exit.data)							\
+	*(.fini_array)							\
+	*(.dtors)							\
 	MEM_DISCARD(exit.data)						\
 	MEM_DISCARD(exit.rodata)
 
 #define EXIT_TEXT							\
 	*(.exit.text)							\
+	*(.text.exit)							\
 	MEM_DISCARD(exit.text)
 
 #define EXIT_CALL							\
-- 
2.8.0.rc3.226.g39d4020
