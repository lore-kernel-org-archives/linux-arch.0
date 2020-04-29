Return-Path: <SRS0=W8sI=6N=kvack.org=owner-linux-mm@kernel.org>
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v10 16/26] mm: Add guard pages around a shadow stack.
Date: Wed, 29 Apr 2020 15:07:22 -0700
Message-ID: <20200429220732.31602-17-yu-cheng.yu@intel.com>
In-Reply-To: <20200429220732.31602-1-yu-cheng.yu@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200429220722.JL0xFHYb0Lq4-2nvVTewpAayO6NzIYVbCnj40NtDK7o@z>

INCSSP(Q/D) increments shadow stack pointer and 'pops and discards' the
first and the last elements in the range, effectively touches those memor=
y
areas.

The maximum moving distance by INCSSPQ is 255 * 8 =3D 2040 bytes and
255 * 4 =3D 1020 bytes by INCSSPD.  Both ranges are far from PAGE_SIZE.
Thus, putting a gap page on both ends of a shadow stack prevents INCSSP,
CALL, and RET from going beyond.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
v10:
- Define ARCH_SHADOW_STACK_GUARD_GAP.

 arch/x86/include/asm/processor.h | 10 ++++++++++
 include/linux/mm.h               | 24 ++++++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
index 3bcf27caf6c9..eb9536f803f9 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -907,6 +907,16 @@ static inline void spin_lock_prefetch(const void *x)
 #define STACK_TOP		TASK_SIZE_LOW
 #define STACK_TOP_MAX		TASK_SIZE_MAX
=20
+/*
+ * Shadow stack pointer is moved by CALL, JMP, and INCSSP(Q/D).  INCSSPQ
+ * moves shadow stack pointer up to 255 * 8 =3D ~2 KB (~1KB for INCSSPD)=
 and
+ * touches the first and the last element in the range, which triggers a
+ * page fault if the range is not in a shadow stack.  Because of this,
+ * creating 4-KB guard pages around a shadow stack prevents these
+ * instructions from going beyond.
+ */
+#define ARCH_SHADOW_STACK_GUARD_GAP PAGE_SIZE
+
 #define INIT_THREAD  {						\
 	.addr_limit		=3D KERNEL_DS,			\
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f0669e3cdd37..68eadf2c466d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2630,6 +2630,10 @@ void page_cache_async_readahead(struct address_spa=
ce *mapping,
 				pgoff_t offset,
 				unsigned long size);
=20
+#ifndef ARCH_SHADOW_STACK_GUARD_GAP
+#define ARCH_SHADOW_STACK_GUARD_GAP 0
+#endif
+
 extern unsigned long stack_guard_gap;
 /* Generic expand stack which grows the stack according to GROWS{UP,DOWN=
} */
 extern int expand_stack(struct vm_area_struct *vma, unsigned long addres=
s);
@@ -2662,9 +2666,15 @@ static inline struct vm_area_struct * find_vma_int=
ersection(struct mm_struct * m
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
 {
 	unsigned long vm_start =3D vma->vm_start;
+	unsigned long gap =3D 0;
=20
-	if (vma->vm_flags & VM_GROWSDOWN) {
-		vm_start -=3D stack_guard_gap;
+	if (vma->vm_flags & VM_GROWSDOWN)
+		gap =3D stack_guard_gap;
+	else if (vma->vm_flags & VM_SHSTK)
+		gap =3D ARCH_SHADOW_STACK_GUARD_GAP;
+
+	if (gap !=3D 0) {
+		vm_start -=3D gap;
 		if (vm_start > vma->vm_start)
 			vm_start =3D 0;
 	}
@@ -2674,9 +2684,15 @@ static inline unsigned long vm_start_gap(struct vm=
_area_struct *vma)
 static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
 {
 	unsigned long vm_end =3D vma->vm_end;
+	unsigned long gap =3D 0;
+
+	if (vma->vm_flags & VM_GROWSUP)
+		gap =3D stack_guard_gap;
+	else if (vma->vm_flags & VM_SHSTK)
+		gap =3D ARCH_SHADOW_STACK_GUARD_GAP;
=20
-	if (vma->vm_flags & VM_GROWSUP) {
-		vm_end +=3D stack_guard_gap;
+	if (gap !=3D 0) {
+		vm_end +=3D gap;
 		if (vm_end < vma->vm_end)
 			vm_end =3D -PAGE_SIZE;
 	}
--=20
2.21.0
