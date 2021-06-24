Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9B9C49EA5
	for <linux-arch@archiver.kernel.org>; Thu, 24 Jun 2021 18:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB898613CC
	for <linux-arch@archiver.kernel.org>; Thu, 24 Jun 2021 18:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhFXTBh (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:01:37 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:35718 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXTBh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Jun 2021 15:01:37 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwUZI-00096b-Ou; Thu, 24 Jun 2021 12:59:16 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:46990 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwUZE-003RF0-8B; Thu, 24 Jun 2021 12:59:16 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
References: <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
        <87sg1lwhvm.fsf@disp2133>
        <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
        <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
        <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
        <87eed4v2dc.fsf@disp2133>
        <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
        <87fsxjorgs.fsf@disp2133>
        <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
        <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
        <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
        <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
        <87a6njf0ia.fsf@disp2133>
        <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
        <87tulpbp19.fsf@disp2133>
        <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
        <87zgvgabw1.fsf@disp2133> <875yy3850g.fsf_-_@disp2133>
Date:   Thu, 24 Jun 2021 13:59:04 -0500
In-Reply-To: <875yy3850g.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Thu, 24 Jun 2021 13:57:35 -0500")
Message-ID: <87zgvf6qdj.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lwUZE-003RF0-8B;;;mid=<87zgvf6qdj.fsf_-_@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+5j7k08D5eTmmAZgbcD6377xu6DvCzgsU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 1/9] signal/sh: Use force_sig(SIGKILL) instead of do_group_exit(SIGKILL)
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Today the sh code allocates memory the first time a process uses
the fpu.  If that memory allocation fails kill the affected task
with force_sig(SIGKILL) rather than do_group_exit(SIGKILL).

Calling do_group_exit from an exception handler can potentially lead
to locking dead locks as do_group_exit is not designed to be called
from interrupt context.  Instead use force_sig(SIGKILL) to kill
the userspace process.  Sending signals in general and force_sig
in particular has been tested from interrupt context so there
should be no problems.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/sh/kernel/cpu/fpu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/sh/kernel/cpu/fpu.c b/arch/sh/kernel/cpu/fpu.c
index ae354a2931e7..fd6db0ab1928 100644
--- a/arch/sh/kernel/cpu/fpu.c
+++ b/arch/sh/kernel/cpu/fpu.c
@@ -62,18 +62,20 @@ void fpu_state_restore(struct pt_regs *regs)
 	}
 
 	if (!tsk_used_math(tsk)) {
-		local_irq_enable();
+		int ret;
 		/*
 		 * does a slab alloc which can sleep
 		 */
-		if (init_fpu(tsk)) {
+		local_irq_enable();
+		ret = init_fpu(tsk);
+		local_irq_disable();
+		if (ret) {
 			/*
 			 * ran out of memory!
 			 */
-			do_group_exit(SIGKILL);
+			force_sig(SIGKILL);
 			return;
 		}
-		local_irq_disable();
 	}
 
 	grab_fpu(regs);
-- 
2.20.1

