From: Stafford Horne <shorne@gmail.com>
Subject: [PATCH] io: Fix return type of _inb and _inl
Date: Sun, 26 Jul 2020 12:11:54 +0900
Message-ID: <20200726031154.1012044-1-shorne@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgGZDMC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jul 2020 23:12:02 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Stafford Horne <shorne@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Wei Xu <xuwei5@hisilicon.com>, John Garry <john.garry@huawei.com>, linux-arch@vger.kernel.org

The return type of functions _inb, _inw and _inl are all u16 which looks
wrong.  This patch makes them u8, u16 and u32 respectively.

The original commit text for these does not indicate that these should
be all forced to u16.

Fixes: f009c89df79a ("io: Provide _inX() and _outX()")
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 include/asm-generic/io.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 8b1e020e9a03..30a3aab312e6 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -456,7 +456,7 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
 
 #if !defined(inb) && !defined(_inb)
 #define _inb _inb
-static inline u16 _inb(unsigned long addr)
+static inline u8 _inb(unsigned long addr)
 {
 	u8 val;
 
@@ -482,7 +482,7 @@ static inline u16 _inw(unsigned long addr)
 
 #if !defined(inl) && !defined(_inl)
 #define _inl _inl
-static inline u16 _inl(unsigned long addr)
+static inline u32 _inl(unsigned long addr)
 {
 	u32 val;
 
-- 
2.26.2
