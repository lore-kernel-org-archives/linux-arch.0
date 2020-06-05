Return-Path: <SRS0=jayZ=7S=kvack.org=owner-linux-mm@kernel.org>
From: Bibo Mao <maobibo@loongson.cn>
Subject: [PATCH 2/2] MIPS: Add writable-applies-readable policy with pgrot
Date: Fri,  5 Jun 2020 17:11:06 +0800
Message-ID: <1591348266-28392-2-git-send-email-maobibo@loongson.cn>
In-Reply-To: <1591348266-28392-1-git-send-email-maobibo@loongson.cn>
References: <1591348266-28392-1-git-send-email-maobibo@loongson.cn>
Sender: owner-linux-mm@kvack.org
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Andrew Morton <akpm@linux-foundation.org>, Paul Burton <paulburton@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200605091106.2IDd4yT6qO3jjCWRHb-_bOrdTohZgziUiiP9wQooS4U@z>

On Linux system, writable applies readable privilege in most
architectures, this patch adds this policy on MIPS platform
where hardware rixi is supported.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/mips/mm/cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index f814e43..dae0617 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -160,7 +160,7 @@ static inline void setup_protection_map(void)
 	if (cpu_has_rixi) {
 		protection_map[0]  = __pgprot(__PC | __PP | __NX | __NR);
 		protection_map[1]  = __pgprot(__PC | __PP | __NX | ___R);
-		protection_map[2]  = __pgprot(__PC | __PP | __NX | __NR);
+		protection_map[2]  = __pgprot(__PC | __PP | __NX | ___R);
 		protection_map[3]  = __pgprot(__PC | __PP | __NX | ___R);
 		protection_map[4]  = __pgprot(__PC | __PP | ___R);
 		protection_map[5]  = __pgprot(__PC | __PP | ___R);
@@ -169,7 +169,7 @@ static inline void setup_protection_map(void)
 
 		protection_map[8]  = __pgprot(__PC | __PP | __NX | __NR);
 		protection_map[9]  = __pgprot(__PC | __PP | __NX | ___R);
-		protection_map[10] = __pgprot(__PC | __PP | __NX | ___W | __NR);
+		protection_map[10] = __pgprot(__PC | __PP | __NX | ___W | ___R);
 		protection_map[11] = __pgprot(__PC | __PP | __NX | ___W | ___R);
 		protection_map[12] = __pgprot(__PC | __PP | ___R);
 		protection_map[13] = __pgprot(__PC | __PP | ___R);
-- 
1.8.3.1
