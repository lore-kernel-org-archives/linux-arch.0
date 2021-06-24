Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829B4C49EAF
	for <linux-arch@archiver.kernel.org>; Thu, 24 Jun 2021 19:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72342613C3
	for <linux-arch@archiver.kernel.org>; Thu, 24 Jun 2021 19:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhFXTGV (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:06:21 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:56512 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhFXTGU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Jun 2021 15:06:20 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwUdr-00GQMb-MZ; Thu, 24 Jun 2021 13:03:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47234 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwUdq-003SFv-2Z; Thu, 24 Jun 2021 13:03:59 -0600
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
Date:   Thu, 24 Jun 2021 14:03:50 -0500
In-Reply-To: <875yy3850g.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Thu, 24 Jun 2021 13:57:35 -0500")
Message-ID: <87k0mj5bl5.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lwUdq-003SFv-2Z;;;mid=<87k0mj5bl5.fsf_-_@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/3wyY4A5bofMhmT8OEDykV2ogWm09ejcw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 9/9] signal: Move PTRACE_EVENT_EXIT into get_signal
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


This ensures that we always have all full set of registers available when
PTRACE_EVENT_EXIT is called.  Something that is not guaranteed for callers
of do_exit.

Additionally this guarantees PTRACE_EVENT_EXIT will not cause havoc
with abnormal exits.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/exit.c   | 2 --
 kernel/signal.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 51e0c82b3f7d..309f1d71e340 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -763,8 +763,6 @@ void __noreturn do_exit(long code)
 	profile_task_exit(tsk);
 	kcov_task_exit(tsk);
 
-	ptrace_event(PTRACE_EVENT_EXIT, code);
-
 	validate_creds_for_do_exit(tsk);
 
 	/*
diff --git a/kernel/signal.c b/kernel/signal.c
index 63fda9b6bbf9..7214331836bc 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2890,6 +2890,8 @@ bool get_signal(struct ksignal *ksig)
 		if (exit_code & 0x7f)
 			current->flags |= PF_SIGNALED;
 
+		ptrace_event(PTRACE_EVENT_EXIT, exit_code);
+
 		/*
 		 * PF_IO_WORKER threads will catch and exit on fatal signals
 		 * themselves. They have cleanup that must be performed, so
-- 
2.20.1

