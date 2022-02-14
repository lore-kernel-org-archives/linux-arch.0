Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CAAC43219
	for <linux-arch@archiver.kernel.org>; Mon, 14 Feb 2022 02:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239379AbiBNCbR (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 13 Feb 2022 21:31:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239366AbiBNCbP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Feb 2022 21:31:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9540355480;
        Sun, 13 Feb 2022 18:31:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 622BE1396;
        Sun, 13 Feb 2022 18:31:08 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.47.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 174EC3F718;
        Sun, 13 Feb 2022 18:31:05 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org
Subject: [PATCH 02/30] mm/mmap: Clarify protection_map[] indices
Date:   Mon, 14 Feb 2022 08:00:25 +0530
Message-Id: <1644805853-21338-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644805853-21338-1-git-send-email-anshuman.khandual@arm.com>
References: <1644805853-21338-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

protection_map[] maps vm_flags access combinations into page protection
value as defined by the platform via __PXXX and __SXXX macros. The array
indices in protection_map[], represents vm_flags access combinations but
it's not very intuitive to derive. This makes it clear and explicit.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/mmap.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1e8fdb0b51ed..670c68f5fbf1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -102,8 +102,22 @@ static void unmap_region(struct mm_struct *mm,
  *								x: (yes) yes
  */
 pgprot_t protection_map[16] __ro_after_init = {
-	__P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
-	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
+	[VM_NONE]					= __P000,
+	[VM_READ]					= __P001,
+	[VM_WRITE]					= __P010,
+	[VM_WRITE | VM_READ]				= __P011,
+	[VM_EXEC]					= __P100,
+	[VM_EXEC | VM_READ]				= __P101,
+	[VM_EXEC | VM_WRITE]				= __P110,
+	[VM_EXEC | VM_WRITE | VM_READ]			= __P111,
+	[VM_SHARED]					= __S000,
+	[VM_SHARED | VM_READ]				= __S001,
+	[VM_SHARED | VM_WRITE]				= __S010,
+	[VM_SHARED | VM_WRITE | VM_READ]		= __S011,
+	[VM_SHARED | VM_EXEC]				= __S100,
+	[VM_SHARED | VM_EXEC | VM_READ]			= __S101,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= __S110,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= __S111
 };
 
 #ifndef CONFIG_ARCH_HAS_FILTER_PGPROT
-- 
2.25.1

