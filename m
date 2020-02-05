Return-Path: <linux-doc-owner@vger.kernel.org>
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v9 6/7] mm: Update alloc_set_pte() for zero page
Date: Wed,  5 Feb 2020 10:23:07 -0800
Message-ID: <20200205182308.4028-7-yu-cheng.yu@intel.com>
In-Reply-To: <20200205182308.4028-1-yu-cheng.yu@intel.com>
References: <20200205182308.4028-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Sender: linux-doc-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200205182307.C6YGWMOLfIDP_6VYWi1wkCkInjLmMlQ-C36R-IbjPdo@z>

Update alloc_set_pte() for the zero-page case.  A special mapping can als=
o
use a zero page for read.  One use case is the Indirect Branch Tracking
legacy code page (introduced next).

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 mm/memory.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 6daa28614327..58c1e4b60991 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3447,6 +3447,12 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, str=
uct mem_cgroup *memcg,

 	flush_icache_page(vma, page);
 	entry =3D mk_pte(page, vma->vm_page_prot);
+
+	if (is_zero_pfn(pte_pfn(entry))) {
+		entry =3D pte_mkspecial(entry);
+		goto alloc_set_pte_out;
+	}
+
 	if (write)
 		entry =3D maybe_mkwrite(pte_mkdirty(entry), vma);
 	/* copy-on-write page */
@@ -3459,6 +3465,8 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, stru=
ct mem_cgroup *memcg,
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
 		page_add_file_rmap(page, false);
 	}
+
+alloc_set_pte_out:
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);

 	/* no need to invalidate: a not-present page won't be cached */
--=20
2.21.0
