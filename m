Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:45860 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404533AbfBMRqh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Feb 2019 12:46:37 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/8] mm: unexport free_reserved_area
Date: Wed, 13 Feb 2019 18:46:14 +0100
Message-ID: <20190213174621.29297-2-hch@lst.de>
In-Reply-To: <20190213174621.29297-1-hch@lst.de>
References: <20190213174621.29297-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190213174614.BavoGds9ZSIE3tNY3P6snOH0u0CcWTsJNqeb1LryOZU@z>

This function is only used by built-in code, which makes perfect
sense given the purpose of it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page_alloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 35fdde041f5c..45f12a42709d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7255,7 +7255,6 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 
 	return pages;
 }
-EXPORT_SYMBOL(free_reserved_area);
 
 #ifdef	CONFIG_HIGHMEM
 void free_highmem_page(struct page *page)
-- 
2.20.1
