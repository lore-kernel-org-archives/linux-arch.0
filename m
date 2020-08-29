Return-Path: <SRS0=t1zw=CH=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BD8C433E6
	for <linux-arch@archiver.kernel.org>; Sat, 29 Aug 2020 13:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 262982076D
	for <linux-arch@archiver.kernel.org>; Sat, 29 Aug 2020 13:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598706494;
	bh=bnvZNXRwKaNmMas2vL1Y0x/Ullhxy/ZdP57rONHv3+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QeV30vFbKIQPwng2AlqvedpjrHBqTuDWP44x/TKlASlknbasfINajxDx8k9Za05qp
	 2jQg1vIEmjvO53qYIc8V9wR6WgUqTDwwqmT+r7pBMEcYpsTIEQjm3gCoh0MvXfsTUa
	 irYdGWTLMtlTop3SA764xZhnzsncv6YQKAQwWp/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgH2NIH (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 29 Aug 2020 09:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbgH2NDI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Aug 2020 09:03:08 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B66D42076D;
        Sat, 29 Aug 2020 13:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598706187;
        bh=bnvZNXRwKaNmMas2vL1Y0x/Ullhxy/ZdP57rONHv3+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8vqDA/qHDmeBeEe3AYM39SPbnwobeSI12e9mBQBCuESA7nmcbNGowDQDQOYjFmCT
         9/PlpVG+OmaIfvWkCI+y8UNlz27ph67dKFAib4BU1wZ1HqqYcQpHUqZEDHhE7n21Vo
         KV7jzKiWEBeMHFQHFUKW7I4oQONc7GZ9mVf1cUaQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, mhiramat@kernel.org
Subject: [PATCH v5 16/21] kprobes: Make local used functions static
Date:   Sat, 29 Aug 2020 22:03:02 +0900
Message-Id: <159870618256.1229682.8692046612635810882.stgit@devnote2>
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

Since we unified the kretprobe trampoline handler from arch/* code,
some functions and objects no need to be exported anymore.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v4:
   - Convert kretprobe_assert() into a BUG_ON().
---
 include/linux/kprobes.h |   15 ---------------
 kernel/kprobes.c        |    9 ++++-----
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 663be8debf25..9c880c8a4e80 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -190,7 +190,6 @@ static inline int kprobes_built_in(void)
 	return 1;
 }
 
-extern struct kprobe kprobe_busy;
 void kprobe_busy_begin(void);
 void kprobe_busy_end(void);
 
@@ -235,16 +234,6 @@ static inline int arch_trampoline_kprobe(struct kprobe *p)
 
 extern struct kretprobe_blackpoint kretprobe_blacklist[];
 
-static inline void kretprobe_assert(struct kretprobe_instance *ri,
-	unsigned long orig_ret_address, unsigned long trampoline_address)
-{
-	if (!orig_ret_address || (orig_ret_address == trampoline_address)) {
-		printk("kretprobe BUG!: Processing kretprobe %p @ %p\n",
-				ri->rp, ri->rp->kp.addr);
-		BUG();
-	}
-}
-
 #ifdef CONFIG_KPROBES_SANITY_TEST
 extern int init_test_probes(void);
 #else
@@ -364,10 +353,6 @@ int arch_check_ftrace_location(struct kprobe *p);
 
 /* Get the kprobe at this addr (if any) - called with preemption disabled */
 struct kprobe *get_kprobe(void *addr);
-void kretprobe_hash_lock(struct task_struct *tsk,
-			 struct hlist_head **head, unsigned long *flags);
-void kretprobe_hash_unlock(struct task_struct *tsk, unsigned long *flags);
-struct hlist_head * kretprobe_inst_table_head(struct task_struct *tsk);
 
 /* kprobe_running() will just return the current_kprobe on this CPU */
 static inline struct kprobe *kprobe_running(void)
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 0676868f1ac2..732a70163584 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1239,7 +1239,7 @@ static void recycle_rp_inst(struct kretprobe_instance *ri)
 }
 NOKPROBE_SYMBOL(recycle_rp_inst);
 
-void kretprobe_hash_lock(struct task_struct *tsk,
+static void kretprobe_hash_lock(struct task_struct *tsk,
 			 struct hlist_head **head, unsigned long *flags)
 __acquires(hlist_lock)
 {
@@ -1261,7 +1261,7 @@ __acquires(hlist_lock)
 }
 NOKPROBE_SYMBOL(kretprobe_table_lock);
 
-void kretprobe_hash_unlock(struct task_struct *tsk,
+static void kretprobe_hash_unlock(struct task_struct *tsk,
 			   unsigned long *flags)
 __releases(hlist_lock)
 {
@@ -1282,7 +1282,7 @@ __releases(hlist_lock)
 }
 NOKPROBE_SYMBOL(kretprobe_table_unlock);
 
-struct kprobe kprobe_busy = {
+static struct kprobe kprobe_busy = {
 	.addr = (void *) get_kprobe,
 };
 
@@ -1983,8 +1983,7 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 			break;
 	}
 
-	kretprobe_assert(ri, (unsigned long)correct_ret_addr,
-			     (unsigned long)trampoline_address);
+	BUG_ON(!correct_ret_addr || (correct_ret_addr == trampoline_address));
 	last = ri;
 
 	hlist_for_each_entry_safe(ri, tmp, head, hlist) {

