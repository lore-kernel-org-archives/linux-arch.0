Return-Path: <SRS0=gEkT=CG=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE4CC433E2
	for <linux-arch@archiver.kernel.org>; Fri, 28 Aug 2020 12:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4C120872
	for <linux-arch@archiver.kernel.org>; Fri, 28 Aug 2020 12:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598617668;
	bh=GT7QIE1OL2IEp8IqUl23H8/1NDehpfu08ti38E+0+vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DUvs1bBjPfNsKztMnKJ2Sb0ZtVOJISYTM4twLFqwI1jz5X84mBLFLOUqng5t/sfhh
	 OggYhScyeqPDNxJponYDCBsUpppxOGovd16ZXMdjXBnG2XsKFRCrlJr35lSxFtwUwO
	 LnGH0m6ARXZa/arusxAezJIGaMM5FmgMdTOcoaqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgH1M1q (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:27:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729318AbgH1M1j (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 08:27:39 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5661F20848;
        Fri, 28 Aug 2020 12:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598617658;
        bh=GT7QIE1OL2IEp8IqUl23H8/1NDehpfu08ti38E+0+vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BTBRnimp4uucoP/uXWXz8bJzzgj3I8j8+333ejemdjx4hv/1WSZra/BMFDmxEmGUl
         Am4iXdqbm+E6oo2S7w6EUnpJyFL8MpsINUm/F+CJYZmmJDuk78hDXxsJ6/ZftDwiGd
         KQ8gOiYXa5HqG4X6XHulWqgiHNI2YbOsTINlGP54=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, mhiramat@kernel.org
Subject: [PATCH v4 05/23] arc: kprobes: Use generic kretprobe trampoline handler
Date:   Fri, 28 Aug 2020 21:27:33 +0900
Message-Id: <159861765296.992023.2764312742056468660.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159861759775.992023.12553306821235086809.stgit@devnote2>
References: <159861759775.992023.12553306821235086809.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arc/kernel/kprobes.c |   54 ++-------------------------------------------
 1 file changed, 2 insertions(+), 52 deletions(-)

diff --git a/arch/arc/kernel/kprobes.c b/arch/arc/kernel/kprobes.c
index 7d3efe83cba7..cabef45f11df 100644
--- a/arch/arc/kernel/kprobes.c
+++ b/arch/arc/kernel/kprobes.c
@@ -388,6 +388,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 {
 
 	ri->ret_addr = (kprobe_opcode_t *) regs->blink;
+	ri->fp = NULL;
 
 	/* Replace the return addr with trampoline addr */
 	regs->blink = (unsigned long)&kretprobe_trampoline;
@@ -396,58 +397,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 static int __kprobes trampoline_probe_handler(struct kprobe *p,
 					      struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address = 0;
-	unsigned long trampoline_address = (unsigned long)&kretprobe_trampoline;
-
-	INIT_HLIST_HEAD(&empty_rp);
-	kretprobe_hash_lock(current, &head, &flags);
-
-	/*
-	 * It is possible to have multiple instances associated with a given
-	 * task either because an multiple functions in the call path
-	 * have a return probe installed on them, and/or more than one return
-	 * return probe was registered for a target function.
-	 *
-	 * We can handle this because:
-	 *     - instances are always inserted at the head of the list
-	 *     - when multiple return probes are registered for the same
-	 *       function, the first instance's ret_addr will point to the
-	 *       real return address, and all the rest will point to
-	 *       kretprobe_trampoline
-	 */
-	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
-		if (ri->task != current)
-			/* another task is sharing our hash bucket */
-			continue;
-
-		if (ri->rp && ri->rp->handler)
-			ri->rp->handler(ri, regs);
-
-		orig_ret_address = (unsigned long)ri->ret_addr;
-		recycle_rp_inst(ri, &empty_rp);
-
-		if (orig_ret_address != trampoline_address) {
-			/*
-			 * This is the real return address. Any other
-			 * instances associated with this task are for
-			 * other calls deeper on the call stack
-			 */
-			break;
-		}
-	}
-
-	kretprobe_assert(ri, orig_ret_address, trampoline_address);
-	regs->ret = orig_ret_address;
-
-	kretprobe_hash_unlock(current, &flags);
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
+	regs->ret = __kretprobe_trampoline_handler(regs, &kretprobe_trampoline, NULL);
 
 	/* By returning a non zero value, we are telling the kprobe handler
 	 * that we don't want the post_handler to run

