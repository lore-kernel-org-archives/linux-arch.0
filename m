Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43407 "EHLO mga09.intel.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1727870AbgBESX3
 (ORCPT <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 13:23:29 -0500
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v9 7/7] x86/cet/ibt: Introduce
 arch_prctl(ARCH_X86_CET_MARK_LEGACY_CODE)
Date: Wed,  5 Feb 2020 10:23:08 -0800
Message-ID: <20200205182308.4028-8-yu-cheng.yu@intel.com>
In-Reply-To: <20200205182308.4028-1-yu-cheng.yu@intel.com>
References: <20200205182308.4028-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Message-ID: <20200205182308.GwxPXIc2CspxJA85STTg6kPWdSNSInq9kllndvkhRjM@z>

When Indirect Branch Tracking (IBT) is active, non-IBT-compatible legacy
code can be executed if its address range is specified in the legacy code
bitmap.  Each bit in the bitmap indicates a 4-KB legacy code page.

The bitmap is allocated when the first time an application calls
arch_prctl(ARCH_X86_MARK_LEGACY_CODE).  It is setup as a special mapping.
The application can read the bitmap but not write to; it manages the bitm=
ap
with the arch_prctl() being introduced:

arch_prctl(ARCH_X86_CET_MARK_LEGACY_CODE, unsigned long *buf)
    Mark an address range as IBT legacy code.

    *buf: starting linear address
    *(buf + 1): size of the legacy code
    *(buf + 2): set (1); clear (0)

v9:
- Split out special mapping zero page handling to the previous patch.
- Change the bitmap from a pre-defined address to get_unmapped_area().

v8:
- Change legacy bitmap to a special mapping.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/cet.h        |   2 +
 arch/x86/include/uapi/asm/prctl.h |   3 +
 arch/x86/kernel/Makefile          |   2 +-
 arch/x86/kernel/cet_bitmap.c      | 226 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cet_prctl.c       |  15 ++
 5 files changed, 247 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/cet_bitmap.c

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index d3f0d50d51ec..a9677bcdeb5c 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -4,6 +4,7 @@

 #ifndef __ASSEMBLY__
 #include <linux/types.h>
+#include <asm/processor.h>

 struct task_struct;
 struct sc_ext;
@@ -30,6 +31,7 @@ void cet_disable_free_shstk(struct task_struct *p);
 int cet_restore_signal(bool ia32, struct sc_ext *sc);
 int cet_setup_signal(bool ia32, unsigned long rstor, struct sc_ext *sc);
 int cet_setup_ibt(void);
+int cet_mark_legacy_code(unsigned long addr, unsigned long size, unsigne=
d long set);
 void cet_disable_ibt(void);
 #else
 static inline int prctl_cet(int option, unsigned long arg2) { return -EI=
NVAL; }
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/as=
m/prctl.h
index d962f0ec9ccf..da39d4bde4e1 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -18,5 +18,8 @@
 #define ARCH_X86_CET_DISABLE		0x3002
 #define ARCH_X86_CET_LOCK		0x3003
 #define ARCH_X86_CET_ALLOC_SHSTK	0x3004
+#define ARCH_X86_CET_GET_LEGACY_BITMAP	0x3005 /* deprecated */
+#define ARCH_X86_CET_SET_LEGACY_BITMAP	0x3006 /* deprecated */
+#define ARCH_X86_CET_MARK_LEGACY_CODE	0x3007

 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 69a19957e200..0261ea015e45 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -142,7 +142,7 @@ obj-$(CONFIG_UNWINDER_ORC)		+=3D unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+=3D unwind_frame.o
 obj-$(CONFIG_UNWINDER_GUESS)		+=3D unwind_guess.o

-obj-$(CONFIG_X86_INTEL_CET)		+=3D cet.o cet_prctl.o
+obj-$(CONFIG_X86_INTEL_CET)		+=3D cet.o cet_prctl.o cet_bitmap.o

 ###
 # 64 bit specific files
diff --git a/arch/x86/kernel/cet_bitmap.c b/arch/x86/kernel/cet_bitmap.c
new file mode 100644
index 000000000000..2c9e76f9b3f6
--- /dev/null
+++ b/arch/x86/kernel/cet_bitmap.c
@@ -0,0 +1,226 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/bits.h>
+#include <linux/err.h>
+#include <linux/memcontrol.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/oom.h>
+#include <linux/pagemap.h>
+#include <linux/rmap.h>
+#include <linux/swap.h>
+#include <asm/cet.h>
+#include <asm/fpu/internal.h>
+
+#define MMAP_MAX	(unsigned long)(test_thread_flag(TIF_ADDR32) ? \
+				TASK_SIZE : TASK_SIZE_MAX)
+#define IBT_BITMAP_SIZE	(round_up(MMAP_MAX, PAGE_SIZE * BITS_PER_BYTE) /=
 \
+				(PAGE_SIZE * BITS_PER_BYTE))
+
+/*
+ * For read fault, provide the zero page.  For write fault coming from
+ * get_user_pages(), clear the page already allocated.
+ */
+static vm_fault_t bitmap_fault(const struct vm_special_mapping *sm,
+			       struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	if (!(vmf->flags & FAULT_FLAG_WRITE)) {
+		vmf->page =3D ZERO_PAGE(vmf->address);
+		return 0;
+	} else {
+		vm_fault_t r;
+
+		if (!vmf->cow_page)
+			return VM_FAULT_ERROR;
+
+		clear_user_highpage(vmf->cow_page, vmf->address);
+		__SetPageUptodate(vmf->cow_page);
+		r =3D finish_fault(vmf);
+		return r ? r : VM_FAULT_DONE_COW;
+	}
+}
+
+static int bitmap_mremap(const struct vm_special_mapping *sm,
+			 struct vm_area_struct *vma)
+{
+	return -EINVAL;
+}
+
+static const struct vm_special_mapping bitmap_mapping =3D {
+	.name	=3D "[ibt_bitmap]",
+	.fault	=3D bitmap_fault,
+	.mremap	=3D bitmap_mremap,
+};
+
+static int alloc_bitmap(void)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma;
+	unsigned long addr;
+	u64 msr_val;
+	int r =3D 0;
+
+	if (down_write_killable(&mm->mmap_sem))
+		return -EINTR;
+
+	addr =3D get_unmapped_area(NULL, 0, IBT_BITMAP_SIZE, 0, 0);
+	if (IS_ERR_VALUE(addr)) {
+		up_write(&mm->mmap_sem);
+		return PTR_ERR((void *)addr);
+	}
+
+	vma =3D _install_special_mapping(mm, addr, IBT_BITMAP_SIZE,
+				       VM_READ | VM_MAYREAD | VM_MAYWRITE,
+				       &bitmap_mapping);
+
+	if (IS_ERR(vma))
+		r =3D PTR_ERR(vma);
+
+	up_write(&mm->mmap_sem);
+
+	if (r)
+		return r;
+
+	fpregs_lock();
+	if (test_thread_flag(TIF_NEED_FPU_LOAD))
+		__fpregs_load_activate();
+
+	rdmsrl(MSR_IA32_U_CET, msr_val);
+	msr_val |=3D (addr | MSR_IA32_CET_LEG_IW_EN);
+	wrmsrl(MSR_IA32_U_CET, msr_val);
+	fpregs_unlock();
+	current->thread.cet.ibt_bitmap_used =3D 1;
+	current->thread.cet.ibt_bitmap_base =3D addr;
+	return 0;
+}
+
+/*
+ * Set bits in the IBT legacy code bitmap, which is read-only user memor=
y.
+ */
+static int set_bits(unsigned long start_bit, unsigned long end_bit,
+		    unsigned long set)
+{
+	unsigned long start_ul, end_ul, nr_ul;
+	unsigned long start_ul_addr, tmp_addr, len;
+	int i, j;
+
+	start_ul =3D start_bit / BITS_PER_LONG;
+	end_ul =3D end_bit / BITS_PER_LONG;
+	i =3D start_bit % BITS_PER_LONG;
+	j =3D end_bit % BITS_PER_LONG;
+
+	tmp_addr =3D current->thread.cet.ibt_bitmap_base;
+	start_ul_addr =3D tmp_addr + start_ul * sizeof(0UL);
+	nr_ul =3D end_ul - start_ul + 1;
+
+	tmp_addr =3D start_ul_addr;
+	len =3D nr_ul * sizeof(0UL);
+
+	down_read(&current->mm->mmap_sem);
+	while (len) {
+		unsigned long *first, *last, mask, bytes;
+		int ret, offset;
+		void *kern_page_addr;
+		struct page *page =3D NULL;
+
+		ret =3D get_user_pages(tmp_addr, 1, FOLL_WRITE | FOLL_FORCE,
+				     &page, NULL);
+
+		if (ret <=3D 0) {
+			up_read(&current->mm->mmap_sem);
+			return ret;
+		}
+
+		kern_page_addr =3D kmap(page);
+
+		bytes =3D len;
+		offset =3D tmp_addr & (PAGE_SIZE - 1);
+
+		/* Is end_ul in this page? */
+		if (bytes > (PAGE_SIZE - offset)) {
+			bytes =3D PAGE_SIZE - offset;
+			last =3D NULL;
+		} else {
+			last =3D (unsigned long *)(kern_page_addr + offset + bytes) - 1;
+		}
+
+		/* Is start_ul in this page? */
+		if (tmp_addr =3D=3D start_ul_addr)
+			first =3D (unsigned long *)(kern_page_addr + offset);
+		else
+			first =3D NULL;
+
+		if (nr_ul =3D=3D 1) {
+			mask =3D GENMASK(j, i);
+
+			if (set)
+				*first |=3D mask;
+			else
+				*first &=3D ~mask;
+		} else {
+			if (first) {
+				mask =3D GENMASK(BITS_PER_LONG - 1, i);
+
+				if (set)
+					*first |=3D mask;
+				else
+					*first &=3D ~mask;
+			}
+
+			if (last) {
+				mask =3D GENMASK(j, 0);
+
+				if (set)
+					*last |=3D mask;
+				else
+					*last &=3D ~mask;
+			}
+
+			if (nr_ul > 2) {
+				void *p =3D kern_page_addr + offset;
+				int cnt =3D bytes;
+
+				if (first) {
+					p +=3D sizeof(*first);
+					cnt -=3D sizeof(*first);
+				}
+
+				if (last)
+					cnt -=3D sizeof(*last);
+
+				if (set)
+					memset(p, 0xff, cnt);
+				else
+					memset(p, 0, cnt);
+			}
+		}
+
+		set_page_dirty_lock(page);
+		kunmap(page);
+		put_page(page);
+
+		len -=3D bytes;
+		tmp_addr +=3D bytes;
+	}
+	up_read(&current->mm->mmap_sem);
+	return 0;
+}
+
+int cet_mark_legacy_code(unsigned long addr, unsigned long size, unsigne=
d long set)
+{
+	int r;
+
+	if (!current->thread.cet.ibt_enabled)
+		return -EINVAL;
+
+	if ((addr >=3D MMAP_MAX) || (addr + size > MMAP_MAX))
+		return -EINVAL;
+
+	if (!current->thread.cet.ibt_bitmap_used) {
+		r =3D alloc_bitmap();
+		if (r)
+			return r;
+	}
+
+	return set_bits(addr / PAGE_SIZE, (addr + size - 1) / PAGE_SIZE, set);
+}
diff --git a/arch/x86/kernel/cet_prctl.c b/arch/x86/kernel/cet_prctl.c
index 2a3170786a3b..3fa5ce8d4938 100644
--- a/arch/x86/kernel/cet_prctl.c
+++ b/arch/x86/kernel/cet_prctl.c
@@ -54,6 +54,18 @@ static int handle_alloc_shstk(unsigned long arg2)
 	return 0;
 }

+static int handle_mark_legacy_code(unsigned long arg2)
+{
+	unsigned long addr, size, set;
+
+	if (get_user(addr, (unsigned long __user *)arg2) ||
+	    get_user(size, (unsigned long __user *)arg2 + 1) ||
+	    get_user(set, (unsigned long __user *)arg2 + 2))
+		return -EFAULT;
+
+	return cet_mark_legacy_code(addr, size, set);
+}
+
 int prctl_cet(int option, unsigned long arg2)
 {
 	struct cet_status *cet =3D &current->thread.cet;
@@ -82,6 +94,9 @@ int prctl_cet(int option, unsigned long arg2)
 	case ARCH_X86_CET_ALLOC_SHSTK:
 		return handle_alloc_shstk(arg2);

+	case ARCH_X86_CET_MARK_LEGACY_CODE:
+		return handle_mark_legacy_code(arg2);
+
 	default:
 		return -EINVAL;
 	}
--=20
2.21.0
