From: Chen Gang <chengang@emindsoft.com.cn>
Subject: [PATCH] include/asm-generic/pgtable.h: Check once and return for
 pgprot_modify
Date: Sun, 13 Dec 2015 17:12:02 +0800
Message-ID: <566D3662.6080804@emindsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chen Gang <gang.chen.5i5j@gmail.com>, chenwei@emindsoft.com.cn
List-Id: linux-arch.vger.kernel.org


pgprot_val() likes an empty operation, and all three checking statements
are related with oldprot, so only check once is enough, the reason is:

 - if both "oldprot == pgprot_noncached(oldprot)" and "oldprot ==
   pgprot_writecombine(oldprot)" are satisfied.

 - So "pgprot_noncached(oldprot) == pgprot_writecombine(oldprot)", too.

 - So as the result, it is still equal to check once (for pgprot_device
   can get the same result).

Then can return directly.

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 include/asm-generic/pgtable.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 069536a..cd9e7c4 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -306,11 +306,11 @@ static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
 static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
 {
 	if (pgprot_val(oldprot) == pgprot_val(pgprot_noncached(oldprot)))
-		newprot = pgprot_noncached(newprot);
+		return pgprot_noncached(newprot);
 	if (pgprot_val(oldprot) == pgprot_val(pgprot_writecombine(oldprot)))
-		newprot = pgprot_writecombine(newprot);
+		return pgprot_writecombine(newprot);
 	if (pgprot_val(oldprot) == pgprot_val(pgprot_device(oldprot)))
-		newprot = pgprot_device(newprot);
+		return pgprot_device(newprot);
 	return newprot;
 }
 #endif
-- 
1.9.3
