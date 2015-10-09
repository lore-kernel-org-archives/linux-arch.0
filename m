From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 08/12] mm: move some code around
Date: Fri, 9 Oct 2015 10:01:13 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075D781BDFF@IN01WEMBXB.internal.synopsys.com>
References: <1442918096-17454-1-git-send-email-vgupta@synopsys.com>
 <1442918096-17454-9-git-send-email-vgupta@synopsys.com>
 <20151009094858.GB7873@node>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
Content-Language: en-US
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Mel Gorman <mgorman@suse.de>, Matthew
 Wilcox <matthew.r.wilcox@intel.com>, Minchan Kim <minchan@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
List-Id: linux-arch.vger.kernel.org

On Friday 09 October 2015 03:19 PM, Kirill A. Shutemov wrote:=0A=
> On Tue, Sep 22, 2015 at 04:04:52PM +0530, Vineet Gupta wrote:=0A=
>> This reduces/simplifies the diff for the next patch which moves THP=0A=
>> specific code.=0A=
>>=0A=
>> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>=0A=
> Okay, so you group pte-related helpers together, right?=0A=
> It would be nice to mention it in commit message.=0A=
>=0A=
> Acked-by: Kirill A. Shutemov kirill.shutemov@linux.intel.com=0A=
=0A=
------------->=0A=
From 3817cec40baf8d9bf783203bf42e15dc404d9cdd Mon Sep 17 00:00:00 2001=0A=
From: Vineet Gupta <vgupta@synopsys.com>=0A=
Date: Thu, 9 Jul 2015 17:19:30 +0530=0A=
Subject: [PATCH v3] mm: group pte related helpers together=0A=
=0A=
This reduces/simplifies the diff for the next patch which moves THP=0A=
specific code.=0A=
=0A=
No semantical changes !=0A=
=0A=
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>=0A=
---=0A=
 mm/pgtable-generic.c | 50 +++++++++++++++++++++++++-----------------------=
--=0A=
 1 file changed, 25 insertions(+), 25 deletions(-)=0A=
=0A=
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c=0A=
index 6b674e00153c..48851894e699 100644=0A=
--- a/mm/pgtable-generic.c=0A=
+++ b/mm/pgtable-generic.c=0A=
@@ -57,6 +57,31 @@ int ptep_set_access_flags(struct vm_area_struct *vma,=0A=
 }=0A=
 #endif=0A=
 =0A=
+#ifndef __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH=0A=
+int ptep_clear_flush_young(struct vm_area_struct *vma,=0A=
+               unsigned long address, pte_t *ptep)=0A=
+{=0A=
+    int young;=0A=
+    young =3D ptep_test_and_clear_young(vma, address, ptep);=0A=
+    if (young)=0A=
+        flush_tlb_page(vma, address);=0A=
+    return young;=0A=
+}=0A=
+#endif=0A=
+=0A=
+#ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH=0A=
+pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long address,=
=0A=
+               pte_t *ptep)=0A=
+{=0A=
+    struct mm_struct *mm =3D (vma)->vm_mm;=0A=
+    pte_t pte;=0A=
+    pte =3D ptep_get_and_clear(mm, address, ptep);=0A=
+    if (pte_accessible(mm, pte))=0A=
+        flush_tlb_page(vma, address);=0A=
+    return pte;=0A=
+}=0A=
+#endif=0A=
+=0A=
 #ifndef __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS=0A=
 int pmdp_set_access_flags(struct vm_area_struct *vma,=0A=
               unsigned long address, pmd_t *pmdp,=0A=
@@ -77,18 +102,6 @@ int pmdp_set_access_flags(struct vm_area_struct *vma,=
=0A=
 }=0A=
 #endif=0A=
 =0A=
-#ifndef __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH=0A=
-int ptep_clear_flush_young(struct vm_area_struct *vma,=0A=
-               unsigned long address, pte_t *ptep)=0A=
-{=0A=
-    int young;=0A=
-    young =3D ptep_test_and_clear_young(vma, address, ptep);=0A=
-    if (young)=0A=
-        flush_tlb_page(vma, address);=0A=
-    return young;=0A=
-}=0A=
-#endif=0A=
-=0A=
 #ifndef __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH=0A=
 int pmdp_clear_flush_young(struct vm_area_struct *vma,=0A=
                unsigned long address, pmd_t *pmdp)=0A=
@@ -106,19 +119,6 @@ int pmdp_clear_flush_young(struct vm_area_struct *vma,=
=0A=
 }=0A=
 #endif=0A=
 =0A=
-#ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH=0A=
-pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long address,=
=0A=
-               pte_t *ptep)=0A=
-{=0A=
-    struct mm_struct *mm =3D (vma)->vm_mm;=0A=
-    pte_t pte;=0A=
-    pte =3D ptep_get_and_clear(mm, address, ptep);=0A=
-    if (pte_accessible(mm, pte))=0A=
-        flush_tlb_page(vma, address);=0A=
-    return pte;=0A=
-}=0A=
-#endif=0A=
-=0A=
 #ifndef __HAVE_ARCH_PMDP_HUGE_CLEAR_FLUSH=0A=
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE=0A=
 pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma, unsigned long addr=
ess,=0A=
-- =0A=
1.9.1=0A=
=0A=

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
