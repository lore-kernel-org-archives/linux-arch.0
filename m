Return-Path: <SRS0=Iq1u=CE=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB58C433E1
	for <linux-arch@archiver.kernel.org>; Wed, 26 Aug 2020 13:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F05B22B40
	for <linux-arch@archiver.kernel.org>; Wed, 26 Aug 2020 13:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598449721;
	bh=K022LNieqmFoaEkoxubh1mnXwoga67eG8/53LmWxWK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u2WoHdiWrO3PdnIVtypSq5SJ4e6lBisfR2C7ye1+fRLDWZCxCkgBxX3dNAAk02nFx
	 jYKZsN+JYL58BdVaiU/h2n2WhpbxrgR5eLSltdS53yqT2q3z36/abfH5GZ7C18bero
	 COho/WKnzeBL6dYqvY4q1dBfhXv+Pv5BFKnELZo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgHZNsh (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:48:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730321AbgHZNrv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Aug 2020 09:47:51 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E862420707;
        Wed, 26 Aug 2020 13:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598449668;
        bh=K022LNieqmFoaEkoxubh1mnXwoga67eG8/53LmWxWK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4ZWqKMU01HUL8xbErD0x5/jrxFdVFE+x6lg5Hyv+6QGgSyxl0tLfE1vXIK2VE8VH
         CebXeOYBdpjoDWZ35uxSZUwoLBaFheEbLTYLRC23ovWeXrIZ+mR8/jXasGwf4IyfJ/
         A4b3ZZV7SG8jEpZsoTcWMT1E1VVF95IFzIyagv1Y=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy Wu <Eddy_Wu@trendmicro.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH 09/14] parisc: kprobes: Use generic kretprobe trampoline handler
Date:   Wed, 26 Aug 2020 22:47:43 +0900
Message-Id: <159844966365.510284.6017763871976900229.stgit@devnote2>
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
 arch/parisc/kernel/kprobes.c |   78 +++---------------------------------------
 1 file changed, 6 insertions(+), 72 deletions(-)

diff --git a/arch/parisc/kernel/kprobes.c b/arch/parisc/kernel/kprobes.c
index 77ec51818916..2f9389ae91a3 100644
--- a/arch/parisc/kernel/kprobes.c
+++ b/arch/parisc/kernel/kprobes.c
@@ -191,80 +191,13 @@ static struct kprobe trampoline_p = {
 static int __kprobes trampoline_probe_handler(struct kprobe *p,
 					      struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address = 0;
-	unsigned long trampoline_address = (unsigned long)trampoline_p.addr;
-	kprobe_opcode_t *correct_ret_addr = NULL;
-
-	INIT_HLIST_HEAD(&empty_rp);
-	kretprobe_hash_lock(current, &head, &flags);
-
-	/*
-	 * It is possible to have multiple instances associated with a given
-	 * task either because multiple functions in the call path have
-	 * a return probe installed on them, and/or more than one return
-	 * probe was registered for a target function.
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
+	unsigned long orig_ret_address;
 
-	kretprobe_hash_unlock(current, &flags);
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
+	orig_ret_address = __kretprobe_trampoline_handler(regs,
+			(unsigned long)trampoline_p.addr,
+			NULL);
 	instruction_pointer_set(regs, orig_ret_address);
+
 	return 1;
 }
 
@@ -272,6 +205,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *)regs->gr[2];
+	ri->fp = NULL;
 
 	/* Replace the return addr with trampoline addr. */
 	regs->gr[2] = (unsigned long)trampoline_p.addr;

