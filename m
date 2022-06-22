Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C9EC43334
	for <linux-arch@archiver.kernel.org>; Wed, 22 Jun 2022 10:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243780AbiFVKQO (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 22 Jun 2022 06:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347800AbiFVKQG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 06:16:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A27D3B28F;
        Wed, 22 Jun 2022 03:15:58 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LSfNs3YmMzhXcb;
        Wed, 22 Jun 2022 18:13:49 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 18:15:56 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 18:15:56 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>, <jpoimboe@kernel.org>,
        <peterz@infradead.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <arnd@arndb.de>
Subject: [PATCH v2 4/5] objtool: Specify host-arch for making LIBSUBCMD
Date:   Wed, 22 Jun 2022 18:13:43 +0800
Message-ID: <20220622101344.38002-5-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220622101344.38002-1-chenzhongjin@huawei.com>
References: <20220622101344.38002-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When singly cross-compiling objtool, LIBSUBCMD MAKE uses target-arch and
failed to LD with other object files.

Explicitly specify host-arch for LIBSUBCMD so it can be correctly
cross-compiled.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 tools/objtool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index e66d717c245d..2b97720ab608 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -58,7 +58,7 @@ $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
 
 
 $(LIBSUBCMD): fixdep FORCE
-	$(Q)$(MAKE) -C $(SUBCMD_SRCDIR) OUTPUT=$(LIBSUBCMD_OUTPUT)
+	$(Q)$(MAKE) -C $(SUBCMD_SRCDIR) OUTPUT=$(LIBSUBCMD_OUTPUT) AR=$(AR) CC=$(CC) LD=$(LD)
 
 clean:
 	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
-- 
2.17.1

