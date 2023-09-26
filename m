Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965E0E7E62F
	for <linux-arch@archiver.kernel.org>; Tue, 26 Sep 2023 12:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjIZMLA (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 26 Sep 2023 08:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjIZMK7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Sep 2023 08:10:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB29E6;
        Tue, 26 Sep 2023 05:10:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDDAC433C7;
        Tue, 26 Sep 2023 12:10:49 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>, stable@vger.kernel.org,
        Chong Qiao <qiaochong@loongson.cn>
Subject: [PATCH] LoongArch: numa: Fix high_memory calculation
Date:   Tue, 26 Sep 2023 20:10:31 +0800
Message-Id: <20230926121031.1901760-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

high_memory is the virtual address of the 'highest physical address' in
the system. But __va(get_num_physpages() << PAGE_SHIFT) is not what we
want because there may be holes in the physical address space. On the
other hand, max_low_pfn is calculated from memblock_end_of_DRAM(), which
is exactly corresponding to the highest physical address, so use it for
high_memory calculation.

Cc: <stable@vger.kernel.org>
Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index c7d33c489e04..6e65ff12d5c7 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -436,7 +436,7 @@ void __init paging_init(void)
 
 void __init mem_init(void)
 {
-	high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
+	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 	memblock_free_all();
 }
 
-- 
2.39.3

