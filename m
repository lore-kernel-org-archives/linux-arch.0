From: Chen Gang <chengang@emindsoft.com.cn>
Subject: [PATCH v2 trivial] include: asm-generic: Notice about 80 columns
 in pgtable-no*.h
Date: Wed, 16 Dec 2015 06:11:03 +0800
Message-ID: <56708FF7.7000303@emindsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail113-249.mail.alibaba.com ([205.204.113.249]:43351 "EHLO
	us-alimail-mta1.hst.scl.en.alidc.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932800AbbLOWI4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Dec 2015 17:08:56 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, trivial@kernel.org
Cc: Joe Perches <joe@perches.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>


It is a trivial patch.

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 include/asm-generic/pgtable-nopmd.h | 3 ++-
 include/asm-generic/pgtable-nopud.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index 725612b..9d42296 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -38,7 +38,8 @@ static inline void pud_clear(pud_t *pud)	{ }
  * (pmds are folded into puds so this doesn't get actually called,
  * but the define is needed for a generic inline function.)
  */
-#define set_pud(pudptr, pudval)			set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
+#define set_pud(pudptr, pudval)			\
+	set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
 
 static inline pmd_t * pmd_offset(pud_t * pud, unsigned long address)
 {
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index 810431d..9c0ffe7 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -33,7 +33,8 @@ static inline void pgd_clear(pgd_t *pgd)	{ }
  * (puds are folded into pgds so this doesn't get actually called,
  * but the define is needed for a generic inline function.)
  */
-#define set_pgd(pgdptr, pgdval)			set_pud((pud_t *)(pgdptr), (pud_t) { pgdval })
+#define set_pgd(pgdptr, pgdval)			\
+	set_pud((pud_t *)(pgdptr), (pud_t) { pgdval })
 
 static inline pud_t * pud_offset(pgd_t * pgd, unsigned long address)
 {
-- 
1.9.3
