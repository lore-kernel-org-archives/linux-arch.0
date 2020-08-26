Return-Path: <SRS0=Iq1u=CE=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484C6C433E3
	for <linux-arch@archiver.kernel.org>; Wed, 26 Aug 2020 13:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F252224D
	for <linux-arch@archiver.kernel.org>; Wed, 26 Aug 2020 13:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598449712;
	bh=PP0bI7sUDln6gk+DlxUV7f5eKbxC3kbdiD3361ooqy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nTH+a44BMbB5xTYngoKtwet0oMuoYF0/tZjti8FjdwTpltPgR15GnLPaBryJlpCqb
	 mS96wS1q2RJYBjww3OQncdYDGTnpRCbCnhGlMb3Ws3rVuX4athCs81TLY7w060bEsZ
	 TBqrQfg5xGNCfUdZULHKsPMy28FEmj6BR/dKJ3O8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbgHZNsZ (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730425AbgHZNsJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Aug 2020 09:48:09 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0436320707;
        Wed, 26 Aug 2020 13:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598449688;
        bh=PP0bI7sUDln6gk+DlxUV7f5eKbxC3kbdiD3361ooqy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XLAWWfTGCRhmlybXipTvFnjy3kt7SKtASr8ha2hsZ0id8PgAHr2hDWciOU+WLZXTp
         wWbTzX5X+zaS1aqpYhAcBvL+bp+9BqFpKTU6+ZlXoKVBoGzoZK+E+CcM/5P2wI9NDu
         ZZ3nNqXzMsclje7pw1L1CMC+NGyl2/K8ot7KWZCA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy Wu <Eddy_Wu@trendmicro.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH 11/14] s390: kprobes: Use generic kretprobe trampoline handler
Date:   Wed, 26 Aug 2020 22:48:03 +0900
Message-Id: <159844968361.510284.5348976693330647141.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159844957216.510284.17683703701627367133.stgit@devnote2>
References: <159844957216.510284.17683703701627367133.stgit@devnote2>
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

