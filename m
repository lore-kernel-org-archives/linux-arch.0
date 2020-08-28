Return-Path: <SRS0=gEkT=CG=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D238CC433E6
	for <linux-arch@archiver.kernel.org>; Fri, 28 Aug 2020 12:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AADFF2087D
	for <linux-arch@archiver.kernel.org>; Fri, 28 Aug 2020 12:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598617762;
	bh=OnDsOkdDc4BFhJtuovyYT6NNWTOHQ4rJ+pxhZH/+kVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mk7OvD2whXiVhH21Wv7ude6jSeuhhwIiDB0rwiXvQotI4fJFE+o8v7NYwh6M1Jygi
	 hfzt6bbHHzpvGylPFb9MABdmUNF5whDMBhv6mlndms69xUzoXrnXq2f0rZvVNKMx/B
	 FdXiDweSdnVJKCHuI9Fzecun0kUWyQvF3Gr6tfns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgH1M3P (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729382AbgH1M24 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 08:28:56 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E8DA20848;
        Fri, 28 Aug 2020 12:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598617735;
        bh=OnDsOkdDc4BFhJtuovyYT6NNWTOHQ4rJ+pxhZH/+kVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oOIqs0+soDaRNn0FCaiUT6g64Qj3OWgv3plZouO/ZBLYTGtcjZmUiDl4DA1FKFfND
         EJ8gKsXJTORZtVWfobvJbmXLVuFrRDYmi6QOJi8V4hM4aBWuZ6iI8jSh4rUUmYSX5+
         MF0+sLs2TCTlzJycybMf9zs+vMk1FMc8bVOq0k84=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, mhiramat@kernel.org
Subject: [PATCH v4 12/23] sh: kprobes: Use generic kretprobe trampoline handler
Date:   Fri, 28 Aug 2020 21:28:49 +0900
Message-Id: <159861772935.992023.11473891483961325961.stgit@devnote2>
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
 arch/sh/kernel/kprobes.c |   58 ++--------------------------------------------
 1 file changed, 3 insertions(+), 55 deletions(-)

diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index 318296f48f1a..756100b01e84 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -204,6 +204,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *) regs->pr;
+	ri->fp = NULL;
 
 	/* Replace the return addr with trampoline addr */
 	regs->pr = (unsigned long)kretprobe_trampoline;
@@ -302,62 +303,9 @@ static void __used kretprobe_trampoline_holder(void)
  */
 int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address = 0;
-	unsigned long trampoline_address = (unsigned long)&kretprobe_trampoline;
+	regs->pc = __kretprobe_trampoline_handler(regs, &kretprobe_trampoline, NULL);
 
-	INIT_HLIST_HEAD(&empty_rp);
-	kretprobe_hash_lock(current, &head, &flags);
-
-	/*
-	 * It is possible to have multiple instances associated with a given
-	 * task either because an multiple functions in the call path
-	 * have a return probe installed on them, and/or more then one return
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
-		if (ri->rp && ri->rp->handler) {
-			__this_cpu_write(current_kprobe, &ri->rp->kp);
-			ri->rp->handler(ri, regs);
-			__this_cpu_write(current_kprobe, NULL);
-		}
-
-		orig_ret_address = (unsigned long)ri->ret_addr;
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
-	kretprobe_assert(ri, orig_ret_address, trampoline_address);
-
-	regs->pc = orig_ret_address;
-	kretprobe_hash_unlock(current, &flags);
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
-
-	return orig_ret_address;
+	return 1;
 }
 
 static int __kprobes post_kprobe_handler(struct pt_regs *regs)

