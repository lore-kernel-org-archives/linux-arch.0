From: David Miller <davem@davemloft.net>
Subject: [PATCH] Fix generic hugetlb pte check return type.
Date: Wed, 02 Oct 2013 14:25:09 -0400 (EDT)
Message-ID: <20131002.142509.1450460988268165850.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
Sender: sparclinux-owner@vger.kernel.org
To: sparclinux@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


The include/asm-generic/hugetlb.h stubs that just vector huge_pte_*()
calls to the pte_*() implementations won't work in certain situations.

x86 and sparc, for example, return "unsigned long" from the bit
checks, and just go "return pte_val(pte) & PTE_BIT_FOO;"

But since huge_pte_*() returns 'int', if any high bits on 64-bit are
relevant, they get chopped off.

The net effect is that we can loop forever trying to COW a huge page,
because the huge_pte_write() check signals false all the time.

Reported-by: Gurudas Pai <gurudas.pai@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---

Anyone mind if I push this through the sparc tree?

diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index d06079c..99b490b 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -6,12 +6,12 @@ static inline pte_t mk_huge_pte(struct page *page, pgprot_t pgprot)
 	return mk_pte(page, pgprot);
 }
 
-static inline int huge_pte_write(pte_t pte)
+static inline unsigned long huge_pte_write(pte_t pte)
 {
 	return pte_write(pte);
 }
 
-static inline int huge_pte_dirty(pte_t pte)
+static inline unsigned long huge_pte_dirty(pte_t pte)
 {
 	return pte_dirty(pte);
 }
