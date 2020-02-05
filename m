Return-Path: <linux-doc-owner@vger.kernel.org>
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v9 26/27] mm/mmap: Add Shadow Stack pages to memory
 accounting
Date: Wed,  5 Feb 2020 10:19:34 -0800
Message-ID: <20200205181935.3712-27-yu-cheng.yu@intel.com>
In-Reply-To: <20200205181935.3712-1-yu-cheng.yu@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Sender: linux-doc-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200205181934.yE4MSkjBLd8e1lHhUPYw-s1vDXVtmQe7VN_1-I8bpGk@z>

Add Shadow Stack pages to memory accounting.

v8:
- Change Shadow Stake pages from data_vm to stack_vm.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 mm/mmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 71e4ffc83bcd..acfa04e2a5dd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1687,6 +1687,9 @@ static inline int accountable_mapping(struct file *=
file, vm_flags_t vm_flags)
 	if (file && is_file_hugepages(file))
 		return 0;

+	if (arch_copy_pte_mapping(vm_flags))
+		return 1;
+
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) =3D=3D VM_WRI=
TE;
 }

@@ -3302,6 +3305,8 @@ void vm_stat_account(struct mm_struct *mm, vm_flags=
_t flags, long npages)
 		mm->stack_vm +=3D npages;
 	else if (is_data_mapping(flags))
 		mm->data_vm +=3D npages;
+	else if (arch_copy_pte_mapping(flags))
+		mm->stack_vm +=3D npages;
 }

 static vm_fault_t special_mapping_fault(struct vm_fault *vmf);
--=20
2.21.0
