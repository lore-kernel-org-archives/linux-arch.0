Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43393 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE1MI7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 May 2019 08:08:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id c6so11355652pfa.10
        for <linux-arch@vger.kernel.org>; Tue, 28 May 2019 05:08:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/4] mm/large system hash: avoid vmap for non-NUMA machines when hashdist
Date: Tue, 28 May 2019 22:04:51 +1000
Message-Id: <20190528120453.27374-2-npiggin@gmail.com>
In-Reply-To: <20190528120453.27374-1-npiggin@gmail.com>
References: <20190528120453.27374-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>

hashdist currently always uses vmalloc when hashdist is true. When
there is only 1 online node and size <= MAX_ORDER, vmalloc can be
avoided.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dd419a074141..15478dba1144 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8029,7 +8029,8 @@ void *__init alloc_large_system_hash(const char *tablename,
 			else
 				table = memblock_alloc_raw(size,
 							   SMP_CACHE_BYTES);
-		} else if (get_order(size) >= MAX_ORDER || hashdist) {
+		} else if (get_order(size) >= MAX_ORDER ||
+				(hashdist && num_online_nodes() > 1)) {
 			table = __vmalloc(size, gfp_flags, PAGE_KERNEL);
 		} else {
 			/*
-- 
2.20.1
