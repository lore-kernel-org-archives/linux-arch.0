Return-Path: <SRS0=b863=CF=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFC6C433E3
	for <linux-arch@archiver.kernel.org>; Thu, 27 Aug 2020 15:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC77E2078A
	for <linux-arch@archiver.kernel.org>; Thu, 27 Aug 2020 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598541353;
	bh=PP0bI7sUDln6gk+DlxUV7f5eKbxC3kbdiD3361ooqy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OycrRMh1jsANtnW4uAJAVvIpXI9HRAxwhmnAAJvx/9+Z5KeewybaUsiYVjiNi7hbP
	 cKWQzB0TQBk29sKxyALyyUtBSPa/qVAS5GOMpQWB0ivL9NFdsOaAVi3nopTwx4hpZ6
	 wJo11BJ3EnvmIpgn9vUBjWbeE8j/STc7mo0q1c7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgH0PPw (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728129AbgH0LhN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 07:37:13 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FF0322CB3;
        Thu, 27 Aug 2020 11:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598528232;
        bh=PP0bI7sUDln6gk+DlxUV7f5eKbxC3kbdiD3361ooqy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tHlD1hc9p+6M5UQV6MKA3W8Lkaa62bL+qOtZ/qzKr+8p8FBL4YxCRClk8CLx8ryZJ
         nBnMWFni06h0Zfle4CGAOaqgoJtfHDaann41JC17cMb+lmkcgErfcFrvx299OVHJDo
         Q32a37c+SAu5Bn5e6M80Um+TRAMh/9ki4ORxyXmw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy Wu <Eddy_Wu@trendmicro.com>, x86@kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 11/15] s390: kprobes: Use generic kretprobe trampoline handler
Date:   Thu, 27 Aug 2020 20:37:08 +0900
Message-Id: <159852822822.707944.2885054218880962378.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159852811819.707944.12798182250041968537.stgit@devnote2>
References: <159852811819.707944.12798182250041968537.stgit@devnote2>
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
 arch/s390/kernel/kprobes.c |   81 ++------------------------------------------
 1 file changed, 4 insertions(+), 77 deletions(-)

diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index d2a71d872638..6009f08836f4 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -228,6 +228,7 @@ NOKPROBE_SYMBOL(pop_kprobe);
 void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *) regs->gprs[14];
+	ri->fp = NULL;
 
 	/* Replace the return addr with trampoline addr */
 	regs->gprs[14] = (unsigned long) &kretprobe_trampoline;
@@ -331,83 +332,9 @@ static void __used kretprobe_trampoline_holder(void)
  */
 static int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address;
-	unsigned long trampoline_address;
-	kprobe_opcode_t *correct_ret_addr;
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
-	 *	 function, the first instance's ret_addr will point to the
-	 *	 real return address, and all the rest will point to
-	 *	 kretprobe_trampoline
-	 */
-	ri = NULL;
-	orig_ret_address = 0;
-	correct_ret_addr = NULL;
-	trampoline_address = (unsigned long) &kretprobe_trampoline;
-	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
-		if (ri->task != current)
-			/* another task is sharing our hash bucket */
-			continue;
-
-		orig_ret_address = (unsigned long) ri->ret_addr;
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
-		orig_ret_address = (unsigned long) ri->ret_addr;
-
-		if (ri->rp && ri->rp->handler) {
-			ri->ret_addr = correct_ret_addr;
-			ri->rp->handler(ri, regs);
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
-	regs->psw.addr = orig_ret_address;
-
-	kretprobe_hash_unlock(current, &flags);
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
+	regs->psw.addr = __kretprobe_trampoline_handler(regs,
+			(unsigned long) &kretprobe_trampoline,
+			NULL);
 	/*
 	 * By returning a non-zero value, we are telling
 	 * kprobe_handler() that we don't want the post_handler

