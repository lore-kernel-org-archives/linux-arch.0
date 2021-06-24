Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701E9C49EA5
	for <linux-arch@archiver.kernel.org>; Thu, 24 Jun 2021 19:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D6F613DC
	for <linux-arch@archiver.kernel.org>; Thu, 24 Jun 2021 19:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhFXTCx (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:02:53 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59072 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXTCw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Jun 2021 15:02:52 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:47220)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwUaW-008eEM-5B; Thu, 24 Jun 2021 13:00:32 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47074 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwUaU-003RZx-84; Thu, 24 Jun 2021 13:00:31 -0600
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
Date:   Thu, 24 Jun 2021 14:00:22 -0500
In-Reply-To: <875yy3850g.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Thu, 24 Jun 2021 13:57:35 -0500")
Message-ID: <87lf6z6qbd.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lwUaU-003RZx-84;;;mid=<87lf6z6qbd.fsf_-_@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19jB/askomOw8mCNdMyrXPaKVH+zkQz15E=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 3/9] signal/seccomp: Dump core when there is only one live thread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Replace get_nr_threads with atomic_read(&current->signal->live) as
that is a more accurate number that is decremented sooner.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/seccomp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 3e06d4628d98..5301eca670a0 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1241,7 +1241,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 		seccomp_log(this_syscall, SIGSYS, action, true);
 		/* Dump core only if this is the last remaining thread. */
 		if (action != SECCOMP_RET_KILL_THREAD ||
-		    get_nr_threads(current) == 1) {
+		    (atomic_read(&current->signal->live) == 1)) {
 			/* Show the original registers in the dump. */
 			syscall_rollback(current, current_pt_regs());
 			/* Trigger a coredump with SIGSYS */
-- 
2.20.1

