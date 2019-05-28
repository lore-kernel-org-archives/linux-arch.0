Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35306 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE1MIz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 May 2019 08:08:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so9170649pfd.2
        for <linux-arch@vger.kernel.org>; Tue, 28 May 2019 05:08:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/4] mm/large system hash: use vmalloc for size > MAX_ORDER when !hashdist
Date: Tue, 28 May 2019 22:04:50 +1000
Message-Id: <20190528120453.27374-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>

The kernel currently clamps large system hashes to MAX_ORDER when
hashdist is not set, which is rather arbitrary.

vmalloc space is limited on 32-bit machines, but this shouldn't
result in much more used because of small physical memory limiting
system hash sizes.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/page_alloc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d66bc8abe0af..dd419a074141 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8029,7 +8029,7 @@ void *__init alloc_large_system_hash(const char *tablename,
 			else
 				table = memblock_alloc_raw(size,
 							   SMP_CACHE_BYTES);
-		} else if (hashdist) {
+		} else if (get_order(size) >= MAX_ORDER || hashdist) {
 			table = __vmalloc(size, gfp_flags, PAGE_KERNEL);
 		} else {
 			/*
@@ -8037,10 +8037,8 @@ void *__init alloc_large_system_hash(const char *tablename,
 			 * some pages at the end of hash table which
 			 * alloc_pages_exact() automatically does
 			 */
-			if (get_order(size) < MAX_ORDER) {
-				table = alloc_pages_exact(size, gfp_flags);
-				kmemleak_alloc(table, size, 1, gfp_flags);
-			}
+			table = alloc_pages_exact(size, gfp_flags);
+			kmemleak_alloc(table, size, 1, gfp_flags);
 		}
 	} while (!table && size > PAGE_SIZE && --log2qty);
 
-- 
2.20.1
