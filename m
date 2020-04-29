Return-Path: <SRS0=W8sI=6N=kvack.org=owner-linux-mm@kernel.org>
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v10 10/26] x86/mm: Update pte_modify for _PAGE_COW
Date: Wed, 29 Apr 2020 15:07:16 -0700
Message-ID: <20200429220732.31602-11-yu-cheng.yu@intel.com>
In-Reply-To: <20200429220732.31602-1-yu-cheng.yu@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200429220716.7-rilXvAmsfXh30jDsqTtPmbMDFALBPxaS78gFZ6Jgg@z>

Pte_modify() changes a PTE to 'newprot'.  It doesn't use the pte_*()
helpers that a previous patch fixed up, so we need a new site.

Introduce fixup_dirty_pte() to set the dirty bits based on _PAGE_RW, and
apply the same changes to pmd_modify().

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
v10:
- Change static_cpu_has() to cpu_feature_enabled().
- Replace _PAGE_CHG_MASK approach with fixup functions.

 arch/x86/include/asm/pgtable.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtabl=
e.h
index 5f89035d1e60..f4870cd040de 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -726,6 +726,21 @@ static inline pmd_t pmd_mknotpresent(pmd_t pmd)
=20
 static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
=20
+static inline pteval_t fixup_dirty_pte(pteval_t pteval)
+{
+	pte_t pte =3D __pte(pteval);
+
+	if (pte_dirty(pte)) {
+		pte =3D pte_mkclean(pte);
+
+		if (pte_flags(pte) & _PAGE_RW)
+			pte =3D pte_set_flags(pte, _PAGE_DIRTY_HW);
+		else
+			pte =3D pte_set_flags(pte, _PAGE_COW);
+	}
+	return pte_val(pte);
+}
+
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pteval_t val =3D pte_val(pte), oldval =3D val;
@@ -736,16 +751,34 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t =
newprot)
 	 */
 	val &=3D _PAGE_CHG_MASK;
 	val |=3D check_pgprot(newprot) & ~_PAGE_CHG_MASK;
+	val =3D fixup_dirty_pte(val);
 	val =3D flip_protnone_guard(oldval, val, PTE_PFN_MASK);
 	return __pte(val);
 }
=20
+static inline int pmd_write(pmd_t pmd);
+static inline pmdval_t fixup_dirty_pmd(pmdval_t pmdval)
+{
+	pmd_t pmd =3D __pmd(pmdval);
+
+	if (pmd_dirty(pmd)) {
+		pmd =3D pmd_mkclean(pmd);
+
+		if (pmd_flags(pmd) & _PAGE_RW)
+			pmd =3D pmd_set_flags(pmd, _PAGE_DIRTY_HW);
+		else
+			pmd =3D pmd_set_flags(pmd, _PAGE_COW);
+	}
+	return pmd_val(pmd);
+}
+
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
 	pmdval_t val =3D pmd_val(pmd), oldval =3D val;
=20
 	val &=3D _HPAGE_CHG_MASK;
 	val |=3D check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
+	val =3D fixup_dirty_pmd(val);
 	val =3D flip_protnone_guard(oldval, val, PHYSICAL_PMD_PAGE_MASK);
 	return __pmd(val);
 }
--=20
2.21.0
