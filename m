From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/8] x86/xen/p2m: Replace ACCESS_ONCE with READ_ONCE
Date: Thu, 15 Jan 2015 09:58:29 +0100
Message-ID: <1421312314-72330-4-git-send-email-borntraeger@de.ibm.com>
References: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, xen-devel@lists.xenproject.org, linux-mm@kvack.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

ACCESS_ONCE does not work reliably on non-scalar types. For
example gcc 4.6 and 4.7 might remove the volatile tag for such
accesses during the SRA (scalar replacement of aggregates) step
(https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145)

Change the p2m code to replace ACCESS_ONCE with READ_ONCE.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/x86/xen/p2m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
index edbc7a6..cb71016 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -554,7 +554,7 @@ static bool alloc_p2m(unsigned long pfn)
 		mid_mfn = NULL;
 	}
 
-	p2m_pfn = pte_pfn(ACCESS_ONCE(*ptep));
+	p2m_pfn = pte_pfn(READ_ONCE(*ptep));
 	if (p2m_pfn == PFN_DOWN(__pa(p2m_identity)) ||
 	    p2m_pfn == PFN_DOWN(__pa(p2m_missing))) {
 		/* p2m leaf page is missing */
-- 
1.9.3

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
