Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09C3ECAAD2
	for <linux-arch@archiver.kernel.org>; Fri,  2 Sep 2022 02:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiIBCaA (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 1 Sep 2022 22:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiIBC36 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Sep 2022 22:29:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C53A10FC2;
        Thu,  1 Sep 2022 19:29:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E17D961E34;
        Fri,  2 Sep 2022 02:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD502C433D6;
        Fri,  2 Sep 2022 02:29:49 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Adjust arch_do_signal_or_restart() to adapt generic entry
Date:   Fri,  2 Sep 2022 10:29:18 +0800
Message-Id: <20220902022918.169173-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit 8ba62d37949e248c69 ("task_work: Call tracehook_notify_signal from
get_signal on all architectures") adjust arch_do_signal_or_restart() for
all architectures. LoongArch hasn't been upstream yet at that time and
can be still built successfully without adjustment because this function
has a weak version with the correct prototype. It is obviously that we
should convert LoongArch to use new API, otherwise some signal handlings
will be lost.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signal.c
index 7f4889df4a17..8f5b7986374b 100644
--- a/arch/loongarch/kernel/signal.c
+++ b/arch/loongarch/kernel/signal.c
@@ -529,11 +529,11 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	signal_setup_done(ret, ksig, 0);
 }
 
-void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
+void arch_do_signal_or_restart(struct pt_regs *regs)
 {
 	struct ksignal ksig;
 
-	if (has_signal && get_signal(&ksig)) {
+	if (get_signal(&ksig)) {
 		/* Whee!  Actually deliver the signal.	*/
 		handle_signal(&ksig, regs);
 		return;
-- 
2.31.1

