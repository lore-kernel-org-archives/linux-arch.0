Return-Path: <SRS0=W8sI=6N=kvack.org=owner-linux-mm@kernel.org>
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v10 17/26] mm/mmap: Add shadow stack pages to memory accounting
Date: Wed, 29 Apr 2020 15:07:23 -0700
Message-ID: <20200429220732.31602-18-yu-cheng.yu@intel.com>
In-Reply-To: <20200429220732.31602-1-yu-cheng.yu@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200429220723.5EnvWAsPPsSaaTnKNO0impPhwpMP4ZJc1UlMDK7125w@z>

Account shadow stack pages to stack memory.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
v10:
- Use arch_shadow_stack_mapping() to make meaning clear.

v8:
- Change shadow stake pages from data_vm to stack_vm.

 arch/x86/mm/pgtable.c         |  7 +++++++
 include/asm-generic/pgtable.h | 11 +++++++++++
 mm/mmap.c                     |  5 +++++
 3 files changed, 23 insertions(+)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index aa4d396ff98d..f384e0314ba7 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -890,3 +890,10 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr=
)
=20
 #endif /* CONFIG_X86_64 */
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
+
+#ifdef CONFIG_ARCH_HAS_SHADOW_STACK
+bool arch_shadow_stack_mapping(vm_flags_t vm_flags)
+{
+	return (vm_flags & VM_SHSTK);
+}
+#endif
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.=
h
index 2c3875724809..dbd415ab7dd8 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1215,6 +1215,17 @@ static inline pmd_t arch_maybe_pmd_mkwrite(pmd_t p=
md, struct vm_area_struct *vma
 #endif /* CONFIG_ARCH_MAYBE_MKWRITE */
 #endif /* CONFIG_MMU */
=20
+#ifdef CONFIG_MMU
+#ifdef CONFIG_ARCH_HAS_SHADOW_STACK
+bool arch_shadow_stack_mapping(vm_flags_t vm_flags);
+#else
+static inline bool arch_shadow_stack_mapping(vm_flags_t vm_flags)
+{
+	return false;
+}
+#endif /* CONFIG_ARCH_HAS_SHADOW_STACK */
+#endif /* CONFIG_MMU */
+
 /*
  * Architecture PAGE_KERNEL_* fallbacks
  *
diff --git a/mm/mmap.c b/mm/mmap.c
index f609e9ec4a25..70d240b3559c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1681,6 +1681,9 @@ static inline int accountable_mapping(struct file *=
file, vm_flags_t vm_flags)
 	if (file && is_file_hugepages(file))
 		return 0;
=20
+	if (arch_shadow_stack_mapping(vm_flags))
+		return 1;
+
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) =3D=3D VM_WRI=
TE;
 }
=20
@@ -3318,6 +3321,8 @@ void vm_stat_account(struct mm_struct *mm, vm_flags=
_t flags, long npages)
 		mm->stack_vm +=3D npages;
 	else if (is_data_mapping(flags))
 		mm->data_vm +=3D npages;
+	else if (arch_shadow_stack_mapping(flags))
+		mm->stack_vm +=3D npages;
 }
=20
 static vm_fault_t special_mapping_fault(struct vm_fault *vmf);
--=20
2.21.0
