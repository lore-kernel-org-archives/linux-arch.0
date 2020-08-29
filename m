Return-Path: <SRS0=t1zw=CH=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D57C433E2
	for <linux-arch@archiver.kernel.org>; Sat, 29 Aug 2020 13:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA8C820CC7
	for <linux-arch@archiver.kernel.org>; Sat, 29 Aug 2020 13:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598706105;
	bh=PddMsZfi66noEb05sSeRW/PrF1jKd2532FhhOsMWHs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cg6R7hkwmKxiPMORg/aRM9tM0vbmlseAOXfvNfoCWV/ZHMVMeU+pRWSqfoSR91rmy
	 /MCefGO84n7nv15A+4XupdE+l/r1S0F78pPpezwxynCZg5ZJghrqeW/8ieyQn2tL5q
	 Wtw05rqAIVLdEEdu5NkSVrtsB25hY96KrJ0WP31k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgH2NBh (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 29 Aug 2020 09:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbgH2NA7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Aug 2020 09:00:59 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3C36208A9;
        Sat, 29 Aug 2020 13:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598706041;
        bh=PddMsZfi66noEb05sSeRW/PrF1jKd2532FhhOsMWHs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DFx6igSPT5cqOyf5k4IeATQ23Vi5lRgBOruxC/UGPuJ13CCAokSOmFhCI+orgOCY/
         FIxqtti53A+3gTMBB7ZOaAKyFkNU1x+AnQ9leyR+J0oi2+6A8H0DX6so7hGmEY6/rD
         8c6MEbvCDii1PY8YSoF1O7wwunLdO51wr3PfFNuQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, mhiramat@kernel.org
Subject: [PATCH v5 04/21] arm64: kprobes: Use generic kretprobe trampoline handler
Date:   Sat, 29 Aug 2020 22:00:35 +0900
Message-Id: <159870603544.1229682.10309733593594205725.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159870598914.1229682.15230803449082078353.stgit@devnote2>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use the generic kretprobe trampoline handler, and use the
kernel_stack_pointer(regs) for framepointer verification.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm64/kernel/probes/kprobes.c |   78 +-----------------------------------
 1 file changed, 3 insertions(+), 75 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 5290f17a4d80..deba738142ed 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -464,87 +464,15 @@ int __init arch_populate_kprobe_blacklist(void)
 
 void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address = 0;
-	unsigned long trampoline_address =
-		(unsigned long)&kretprobe_trampoline;
-	kprobe_opcode_t *correct_ret_addr = NULL;
-
-	INIT_HLIST_HEAD(&empty_rp);
-	kretprobe_hash_lock(current, &head, &flags);
-
-	/*
-	 * It is possible to have multiple instances associated with a given
-	 * task either because multiple functions in the call path have
-	 * return probes installed on them, and/or more than one
-	 * return probe was registered for a target function.
-	 *
-	 * We can handle this because:
-	 *     - instances are always pushed into the head of the list
-	 *     - when multiple return probes are registered for the same
-	 *	 function, the (chronologically) first instance's ret_addr
-	 *	 will be the real return address, and all the rest will
-	 *	 point to kretprobe_trampoline.
-	 */
-	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
-		if (ri->task != current)
-			/* another task is sharing our hash bucket */
-			continue;
-
-		orig_ret_address = (unsigned long)ri->ret_addr;
-
-		if (orig_ret_address != trampoline_address)
-			/*
-			 * This is the real return address. Any other
-			 * instances associated with this task are for
-			 * other calls deeper on the call stack
-			 */
-			break;
-	}
-
-	kretprobe_assert(ri, orig_ret_address, trampoline_address);
-
-	correct_ret_addr = ri->ret_addr;
-	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
-		if (ri->task != current)
-			/* another task is sharing our hash bucket */
-			continue;
-
-		orig_ret_address = (unsigned long)ri->ret_addr;
-		if (ri->rp && ri->rp->handler) {
-			__this_cpu_write(current_kprobe, &ri->rp->kp);
-			get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
-			ri->ret_addr = correct_ret_addr;
-			ri->rp->handler(ri, regs);
-			__this_cpu_write(current_kprobe, NULL);
-		}
-
-		recycle_rp_inst(ri, &empty_rp);
-
-		if (orig_ret_address != trampoline_address)
-			/*
-			 * This is the real return address. Any other
-			 * instances associated with this task are for
-			 * other calls deeper on the call stack
-			 */
-			break;
-	}
-
-	kretprobe_hash_unlock(current, &flags);
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
-	return (void *)orig_ret_address;
+	return (void *)kretprobe_trampoline_handler(regs, &kretprobe_trampoline,
+					(void *)kernel_stack_pointer(regs));
 }
 
 void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *)regs->regs[30];
+	ri->fp = (void *)kernel_stack_pointer(regs);
 
 	/* replace return addr (x30) with trampoline */
 	regs->regs[30] = (long)&kretprobe_trampoline;

