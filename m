Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCB8C4338F
	for <linux-arch@archiver.kernel.org>; Mon, 26 Jul 2021 19:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EF206054F
	for <linux-arch@archiver.kernel.org>; Mon, 26 Jul 2021 19:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhGZS4X (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 26 Jul 2021 14:56:23 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39582 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhGZS4X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jul 2021 14:56:23 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:37180)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m86PB-00C1hw-W6; Mon, 26 Jul 2021 13:36:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:41932 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m86PA-003pQK-Ik; Mon, 26 Jul 2021 13:36:49 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Brad Boyer <flar@allandria.com>,
        Andreas Schwab <schwab@linux-m68k.org>, geert@linux-m68k.org,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        torvalds@linux-foundation.org
References: <e9009e13-cfec-c494-0b3b-f334f75cd1e4@gmail.com>
        <af434994-5c61-0e3a-c7bc-3ed966ccb44f@gmail.com>
        <87h7gopvz2.fsf@disp2133>
        <328e59fb-3e8c-e4cd-06b4-1975ce98614a@gmail.com>
        <877dhio13t.fsf@disp2133>
        <12992a3c-0740-f90e-aa4e-1ec1d8ea38f6@gmail.com>
        <87tukkk6h3.fsf@disp2133>
        <df6618bf-d1bc-4759-2d14-934c22d54a83@gmail.com>
        <87eebn7w7y.fsf@igel.home>
        <db43bef1-7938-4fc1-853d-c20d66521329@gmail.com>
        <20210725101253.GA6096@allandria.com>
        <be3ddf9a-745e-4798-17a7-a9d0ddd7eef7@gmail.com>
Date:   Mon, 26 Jul 2021 14:36:42 -0500
In-Reply-To: <be3ddf9a-745e-4798-17a7-a9d0ddd7eef7@gmail.com> (Michael
        Schmitz's message of "Mon, 26 Jul 2021 14:00:01 +1200")
Message-ID: <87a6m8kgtx.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m86PA-003pQK-Ik;;;mid=<87a6m8kgtx.fsf_-_@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18N0N9bnXIRvhcVoadJMHU7sFIvwUtGVxc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [RFC][PATCH] signal/m68k: Use force_sigsegv(SIGSEGV) in fpsp040_die
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


In the fpsp040 code when copyin or copyout fails call
force_sigsegv(SIGSEGV) instead of do_exit(SIGSEGV).

This solves a couple of problems.  Because do_exit embeds the ptrace
stop PTRACE_EVENT_EXIT a complete stack frame needs to be present for
that to work correctly.  There is always the information needed for a
ptrace stop where get_signal is called.  So exiting with a signal
solves the ptrace issue.

Further exiting with a signal ensures that all of the threads in a
process are killed not just the thread that malfunctioned.  Which
avoids confusing userspace.

To make force_sigsegv(SIGSEGV) work in fpsp040_die modify the code to
save all of the registers and jump to ret_from_exception (which
ultimately calls get_signal) after fpsp040_die returns.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

Can someone please check my m68k assembly changes?

I think I have them correct, and the code assembles but I don't
understand the fine points of when the different branch instructions
should be used.

 arch/m68k/fpsp040/skeleton.S | 3 ++-
 arch/m68k/kernel/traps.c     | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
index a8f41615d94a..ec767523c012 100644
--- a/arch/m68k/fpsp040/skeleton.S
+++ b/arch/m68k/fpsp040/skeleton.S
@@ -502,7 +502,8 @@ in_ea:
 	.section .fixup,#alloc,#execinstr
 	.even
 1:
-	jbra	fpsp040_die
+	bsrl	fpsp040_die
+	jmp	.Lnotkern
 
 	.section __ex_table,#alloc
 	.align	4
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index 9e1261462bcc..5b19fcdcd69e 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -1150,7 +1150,7 @@ asmlinkage void set_esp0(unsigned long ssp)
  */
 asmlinkage void fpsp040_die(void)
 {
-	do_exit(SIGSEGV);
+	force_sigsegv(SIGSEGV);
 }
 
 #ifdef CONFIG_M68KFPU_EMU
-- 
2.20.1

