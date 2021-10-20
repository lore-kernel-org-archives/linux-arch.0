Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885B5C433F5
	for <linux-arch@archiver.kernel.org>; Wed, 20 Oct 2021 21:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5C3611ED
	for <linux-arch@archiver.kernel.org>; Wed, 20 Oct 2021 21:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhJTV2w (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 20 Oct 2021 17:28:52 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:46566 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhJTV2v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 17:28:51 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:60824)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdJ6Z-00FfLB-Mm; Wed, 20 Oct 2021 15:26:35 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:58166 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdJ6X-002MC1-L9; Wed, 20 Oct 2021 15:26:35 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-13-ebiederm@xmission.com>
        <CAHk-=whe-ixeDp_OgSOsC4H+dWTLDSuNDU2a0sE3p8DapNeCuQ@mail.gmail.com>
Date:   Wed, 20 Oct 2021 16:25:46 -0500
In-Reply-To: <CAHk-=whe-ixeDp_OgSOsC4H+dWTLDSuNDU2a0sE3p8DapNeCuQ@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 20 Oct 2021 10:05:21 -1000")
Message-ID: <87ee8fjsmd.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mdJ6X-002MC1-L9;;;mid=<87ee8fjsmd.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/oJDrU/gVCaEKr9KS4ffLmwCs3xVr7FP4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 13/20] signal: Implement force_fatal_sig
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Oct 20, 2021 at 7:45 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Add a simple helper force_fatal_sig that causes a signal to be
>> delivered to a process as if the signal handler was set to SIG_DFL.
>>
>> Reimplement force_sigsegv based upon this new helper.
>
> Can you just make the old force_sigsegv() go away? The odd special
> casing of SIGSEGV was odd to begin with, I think everybody really just
> wanted this new "force_fatal_sig()" and allow any signal - not making
> SIGSEGV special.

There remains the original case that is signal_set up_done
deals with generically.  When sending a signal fails the code
attempts send SIGSEGV and if sending SIGSEGV fails the signal
delivery code terminates the process with SIGSEGV.

To keep dependencies to a minimum and to allow for the possibility of
backports I used "force_sigsegv(SIGSEGV)" instead of
"force_fatal_sig(SIGSEGV)".  I will be happy to add an additional
patch that converts all of those case to force_fatal_sig.

> Also, I think it should set SIGKILL in p->pending.signal or something
> like that - because we want this to trigger fatal_signal_pending(),
> don't we?
>
> Right now fatal_signal_pending() is only true for SIGKILL, I think.

In general when a fatal signal is delivered the function complete_signal
individually delivers SIGKILL to the threads, making
fatal_signal_pending true.

For signals like SIGSYS that generate a coredump that is not currently
true, but in the cases I looked at signal_pending() was enough to
get the code to get_signal(), which dequeues the signals and starts
processing them.

I have a branch queued up for the next merge window that implements per
signal_struct coredumps.  Assuming that does not trigger any user space
regressions I can remove the coredump special case in complete_signal.
That will in turn mean that force_siginfo_to_task does not need to
change sa_handler, blocked or clear SIGNAL_UNKILLABLE, as all of the
cases where that matters today will just wind up with complete_signal
setting a per_thread SIGKILL.



I keep playing with the idea of having fatal_signal_pending depend on a
different flag than the per thread bit for SIGKILL in the per thread
signal set.  That might make it clearer that complete_signal has started
killing the process and it is a start of the killing the process that
triggers fatal_signal_pending.

So far the way fatal_signal_pending works hasn't really been a problem
so I keep putting away ideas of cleaner implementations.

Eric


