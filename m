From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 03/37] sparc64: use get/put_endian helpers
Date: Thu, 29 May 2008 13:17:58 -0700
Message-ID: <1212092278.28403.105.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:43327 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbYE2USA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:18:00 -0400
Received: by yx-out-2324.google.com with SMTP id 31so392252yxl.1
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:18:00 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, linux-arch <linux-arch@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 arch/sparc64/kernel/unaligned.c |    8 ++++----
 arch/sparc64/lib/PeeCeeI.c      |   14 +++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/sparc64/kernel/unaligned.c b/arch/sparc64/kernel/unaligned.c
index afa7fc4..0066ff0 100644
--- a/arch/sparc64/kernel/unaligned.c
+++ b/arch/sparc64/kernel/unaligned.c
@@ -535,11 +535,11 @@ int handle_ldf_stq(u32 insn, struct pt_regs *regs)
 			u64 tmp;
 
 			switch (size) {
-			case 1: data[0] = le32_to_cpup(data + 0); break;
-			default:*(u64 *)(data + 0) = le64_to_cpup((u64 *)(data + 0));
+			case 1: data[0] = get_le32(data + 0); break;
+			default:*(u64 *)(data + 0) = get_le64((__le64 *)(data + 0));
 				break;
-			case 4: tmp = le64_to_cpup((u64 *)(data + 0));
-				*(u64 *)(data + 0) = le64_to_cpup((u64 *)(data + 2));
+			case 4: tmp = get_le64((__le64 *)(data + 0));
+				*(u64 *)(data + 0) = get_le64((__le64 *)(data + 2));
 				*(u64 *)(data + 2) = tmp;
 				break;
 			}
diff --git a/arch/sparc64/lib/PeeCeeI.c b/arch/sparc64/lib/PeeCeeI.c
index 8b313f1..acef744 100644
--- a/arch/sparc64/lib/PeeCeeI.c
+++ b/arch/sparc64/lib/PeeCeeI.c
@@ -21,27 +21,27 @@ void outsw(unsigned long __addr, const void *src, unsigned long count)
 	void __iomem *addr = (void __iomem *) __addr;
 
 	if (count) {
-		u16 *ps = (u16 *)src;
-		u32 *pi;
+		__le16 *ps = (__le16 *)src;
+		__le32 *pi;
 
 		if (((u64)src) & 0x2) {
-			u16 val = le16_to_cpup(ps);
+			u16 val = get_le16(ps);
 			outw(val, addr);
 			ps++;
 			count--;
 		}
-		pi = (u32 *)ps;
+		pi = (__le32 *)ps;
 		while (count >= 2) {
-			u32 w = le32_to_cpup(pi);
+			u32 w = get_le32(pi);
 
 			pi++;
 			outw(w >> 0, addr);
 			outw(w >> 16, addr);
 			count -= 2;
 		}
-		ps = (u16 *)pi;
+		ps = (__le16 *)pi;
 		if (count) {
-			u16 val = le16_to_cpup(ps);
+			u16 val = get_le16(ps);
 			outw(val, addr);
 		}
 	}
-- 
1.5.6.rc0.277.g804cf
