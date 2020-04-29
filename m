Return-Path: <SRS0=W8sI=6N=kvack.org=owner-linux-mm@kernel.org>
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v10 15/26] mm: Fixup places that call pte_mkwrite() directly
Date: Wed, 29 Apr 2020 15:07:21 -0700
Message-ID: <20200429220732.31602-16-yu-cheng.yu@intel.com>
In-Reply-To: <20200429220732.31602-1-yu-cheng.yu@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200429220721.2XRqk7h3GPgst8O1Ck1QulPgnr59dSqt7qS-r6KKTts@z>

A shadow stack page is made writable by pte_mkwrite_shstk(), which sets
_PAGE_DIRTY_HW.  There are a few places that call pte_mkwrite() directly
and miss the maybe_mkwrite() fixup in the previous patch.  Fix them with
maybe_mkwrite():

- do_anonymous_page() and migrate_vma_insert_page() check VM_WRITE direct=
ly
  and call pte_mkwrite(), which is the same as maybe_mkwrite().  Change
  them to maybe_mkwrite().

- In do_numa_page(), if the numa entry 'was-writable', then pte_mkwrite()
  is called directly.  Fix it by doing maybe_mkwrite().

- In change_pte_range(), pte_mkwrite() is called directly.  Replace it wi=
th
  maybe_mkwrite().

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 mm/memory.c   | 5 ++---
 mm/migrate.c  | 3 +--
 mm/mprotect.c | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index f703fe8c8346..b9002f644806 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3373,8 +3373,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault=
 *vmf)
 	__SetPageUptodate(page);
=20
 	entry =3D mk_pte(page, vma->vm_page_prot);
-	if (vma->vm_flags & VM_WRITE)
-		entry =3D pte_mkwrite(pte_mkdirty(entry));
+	entry =3D maybe_mkwrite(pte_mkdirty(entry), vma);
=20
 	vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
@@ -4033,7 +4032,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf=
)
 	pte =3D pte_modify(old_pte, vma->vm_page_prot);
 	pte =3D pte_mkyoung(pte);
 	if (was_writable)
-		pte =3D pte_mkwrite(pte);
+		pte =3D maybe_mkwrite(pte, vma);
 	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
 	update_mmu_cache(vma, vmf->address, vmf->pte);
=20
diff --git a/mm/migrate.c b/mm/migrate.c
index 7160c1556f79..0fa59b1562c6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2805,8 +2805,7 @@ static void migrate_vma_insert_page(struct migrate_=
vma *migrate,
 		}
 	} else {
 		entry =3D mk_pte(page, vma->vm_page_prot);
-		if (vma->vm_flags & VM_WRITE)
-			entry =3D pte_mkwrite(pte_mkdirty(entry));
+		entry =3D maybe_mkwrite(pte_mkdirty(entry), vma);
 	}
=20
 	ptep =3D pte_offset_map_lock(mm, pmdp, addr, &ptl);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 494192ca954b..02762af1057c 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -135,7 +135,7 @@ static unsigned long change_pte_range(struct vm_area_=
struct *vma, pmd_t *pmd,
 			if (dirty_accountable && pte_dirty(ptent) &&
 					(pte_soft_dirty(ptent) ||
 					 !(vma->vm_flags & VM_SOFTDIRTY))) {
-				ptent =3D pte_mkwrite(ptent);
+				ptent =3D maybe_mkwrite(ptent, vma);
 			}
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
 			pages++;
--=20
2.21.0
