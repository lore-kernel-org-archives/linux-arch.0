Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:62398 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966987Ab3E2PJ0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2013 11:09:26 -0400
From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH, v2 5/5] mm/unicore32: fix stale comment about VALID_PAGE()
Date: Wed, 29 May 2013 23:08:56 +0800
Message-ID: <1369840136-1491-6-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1369840136-1491-1-git-send-email-jiang.liu@huawei.com>
References: <1369840136-1491-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <James.Bottomley@HansenPartnership.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130529150856.y0d05AaiwXfCENdieQoTGD0mzdfKWU2SgCly_roqbtw@z>

VALID_PAGE() has been removed from kernel long time ago,
so fix the comment.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Acked-by: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: linux-kernel@vger.kernel.org
---
 arch/unicore32/include/asm/memory.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/unicore32/include/asm/memory.h b/arch/unicore32/include/asm/memory.h
index 5eddb99..debafc4 100644
--- a/arch/unicore32/include/asm/memory.h
+++ b/arch/unicore32/include/asm/memory.h
@@ -98,12 +98,6 @@
 /*
  * Conversion between a struct page and a physical address.
  *
- * Note: when converting an unknown physical address to a
- * struct page, the resulting pointer must be validated
- * using VALID_PAGE().  It must return an invalid struct page
- * for any physical address not corresponding to a system
- * RAM address.
- *
  *  page_to_pfn(page)	convert a struct page * to a PFN number
  *  pfn_to_page(pfn)	convert a _valid_ PFN number to struct page *
  *
-- 
1.8.1.2

