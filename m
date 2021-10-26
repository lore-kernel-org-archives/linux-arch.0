Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E08C433F5
	for <linux-arch@archiver.kernel.org>; Tue, 26 Oct 2021 04:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 414126109D
	for <linux-arch@archiver.kernel.org>; Tue, 26 Oct 2021 04:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhJZEs3 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 26 Oct 2021 00:48:29 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:47510 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbhJZEs2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Oct 2021 00:48:28 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:35452)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mfELc-00ATX9-JC; Mon, 25 Oct 2021 22:46:04 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:34936 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mfELb-004bCG-Is; Mon, 25 Oct 2021 22:46:04 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-13-ebiederm@xmission.com>
        <CAHk-=whe-ixeDp_OgSOsC4H+dWTLDSuNDU2a0sE3p8DapNeCuQ@mail.gmail.com>
        <9416e8d7-5545-4fc4-8ab0-68fddd35520b@kernel.org>
        <CAHk-=whJETM0MHqWQKCVALBkJX-Th5471z5FW3gFJO5c73L6QA@mail.gmail.com>
Date:   Mon, 25 Oct 2021 23:45:23 -0500
In-Reply-To: <CAHk-=whJETM0MHqWQKCVALBkJX-Th5471z5FW3gFJO5c73L6QA@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 25 Oct 2021 16:15:44 -0700")
Message-ID: <87o87ctmvw.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mfELb-004bCG-Is;;;mid=<87o87ctmvw.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18a6D5O+YrTECRKk40/H4Oj2815LtR98b0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 13/20] signal: Implement force_fatal_sig
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Oct 25, 2021 at 3:41 PM Andy Lutomirski <luto@kernel.org> wrote:
>>
>> I'm rather nervous about all this, and I'm also nervous about the
>> existing code.  A quick skim is finding plenty of code paths that assume
>> force_sigsegv (or a do_exit that this series touches) are genuinely
>> unrecoverable.
>
> I was going to say "what are you talking about", because clearly Eric
> kept it all fatal.
>
> But then looked at that patch a bit more before I claimed you were wrong.
>
> And yeah, Eric's force_fatal_sig() is completely broken.
>
> It claims to force a fatal signal, but doesn't actually do that at
> all, and is completely misnamed.
>
> It just uses "force_sig_info_to_task()", which still allows user space
> to catch signals - so it's not "fatal" in the least. It only punches
> through SIG_IGN and blocked signals.
>
> So yeah, that's broken.
>
> I do still think that that could the behavior we possibly want for
> that "can't write updated vm86 state back" situation, but for
> something that is called "fatal", it really needs to be fatal.

Once the code gets as far as force_sig_info_to_task the only
bit that is really missing is to make the signals fatal is:

diff --git a/kernel/signal.c b/kernel/signal.c
index 6a5e1802b9a2..fde043f1e59d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1048,7 +1048,6 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
                /*
                 * This signal will be fatal to the whole group.
                 */
-               if (!sig_kernel_coredump(sig)) {
                        /*
                         * Start a group exit and wake everybody up.
                         * This way we don't have other threads
@@ -1065,7 +1064,6 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
                                signal_wake_up(t, 1);
                        } while_each_thread(p, t);
                        return;
-               }
        }
 
        /*

AKA the only real bit missing is the interaction with the coredump code.

Now we can't just delete sig_kernel_coredump a replacement has to be
written.   And the easiest replacement depends on my other set of
changes that are already in linux-next to make coredumps per
signal_struct instead of per mm.

Which means that in a release or two force_fatal_sig will reliably do
what the name says.




So the question is: Should I name force_fatal_sig to something else in
the meantime?  What should I name it?




I do intend to fix that bit in complete_signal, as well as updating the
code in force_siginfo_to_task so that it doesn't need to change the
blocked state or the signal handler.

These special cases have been annoying me for years and now Andy has
found how they are actually hurting us.  So I do intend to fix that code
as quickly as being careful and code review allows.  Which I think means
one additional development cycle after this one.

Eric

