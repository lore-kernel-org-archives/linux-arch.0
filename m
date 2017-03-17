Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17488 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751218AbdCQRaf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Mar 2017 13:30:35 -0400
Date: Fri, 17 Mar 2017 20:27:57 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 7/7] x86/mm: Switch to generic get_user_page_fast()
 implementation
Message-ID: <20170317172757.dcfdq7ydqd2yenfg@black.fi.intel.com>
References: <20170316152655.37789-8-kirill.shutemov@linux.intel.com>
 <20170316213906.89528-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170316213906.89528-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Steve Capper <steve.capper@linaro.org>, Dann Frazier <dann.frazier@canonical.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170317172757.ZD6zQFyYcg6ti_6A74PmLdLjkh1EkFokn90G69217T4@z>

On Fri, Mar 17, 2017 at 12:39:06AM +0300, Kirill A. Shutemov wrote:
> The patch provides all required hooks to match generic
> get_user_pages_fast() behaviour to x86 and switch x86 over.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  v2:
>     - Fix build on non-PAE 32-bit x86;

Fixup for allmodconfig on x86-64:

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e55fe9475979..e1a0a1fb5971 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -230,13 +230,13 @@ static inline int pud_devmap(pud_t pud)
 {
 	return 0;
 }
+#endif
 
 static inline int pgd_devmap(pgd_t pgd)
 {
 	return 0;
 }
 #endif
-#endif
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline pte_t pte_set_flags(pte_t pte, pteval_t set)
-- 
 Kirill A. Shutemov
