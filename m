Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0692EC2B9F4
	for <linux-arch@archiver.kernel.org>; Tue, 22 Jun 2021 16:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5EC06128E
	for <linux-arch@archiver.kernel.org>; Tue, 22 Jun 2021 16:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhFVQmw (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 22 Jun 2021 12:42:52 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:41800 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhFVQmw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jun 2021 12:42:52 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lvjRn-003aSW-4M; Tue, 22 Jun 2021 10:40:23 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lvjRl-00Cjxd-Up; Tue, 22 Jun 2021 10:40:22 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
References: <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
        <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
        <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
        <87eed4v2dc.fsf@disp2133>
        <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
        <87fsxjorgs.fsf@disp2133>
        <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
        <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
        <YNCfNWC1UMvuE5d5@zeniv-ca.linux.org.uk> <87czsfi2kv.fsf@disp2133>
        <YNEbM+B8Su7GDCSo@zeniv-ca.linux.org.uk>
Date:   Tue, 22 Jun 2021 11:39:40 -0500
In-Reply-To: <YNEbM+B8Su7GDCSo@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Mon, 21 Jun 2021 23:05:23 +0000")
Message-ID: <87pmwddfar.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lvjRl-00Cjxd-Up;;;mid=<87pmwddfar.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/X41R2QSJA4Bsomag6udFxEERDHThxYq8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Mon, Jun 21, 2021 at 11:50:56AM -0500, Eric W. Biederman wrote:
>> Al Viro <viro@zeniv.linux.org.uk> writes:
>> 
>> > On Mon, Jun 21, 2021 at 01:54:56PM +0000, Al Viro wrote:
>> >> On Tue, Jun 15, 2021 at 02:58:12PM -0700, Linus Torvalds wrote:
>> >> 
>> >> > And I think our horrible "kernel threads return to user space when
>> >> > done" is absolutely horrifically nasty. Maybe of the clever sort, but
>> >> > mostly of the historical horror sort.
>> >> 
>> >> How would you prefer to handle that, then?  Separate magical path from
>> >> kernel_execve() to switch to userland?  We used to have something of
>> >> that sort, and that had been a real horror...
>> >> 
>> >> As it is, it's "kernel thread is spawned at the point similar to
>> >> ret_from_fork(), runs the payload (which almost never returns) and
>> >> then proceeds out to userland, same way fork(2) would've done."
>> >> That way kernel_execve() doesn't have to do anything magical.
>> >> 
>> >> Al, digging through the old notes and current call graph...
>> >
>> > 	FWIW, the major assumption back then had been that get_signal(),
>> > signal_delivered() and all associated machinery (including coredumps)
>> > runs *only* from SIGPENDING/NOTIFY_SIGNAL handling.
>> >
>> > 	And "has complete registers on stack" is only a part of that;
>> > there was other fun stuff in the area ;-/  Do we want coredumps for
>> > those, and if we do, will the de_thread stuff work there?
>> 
>> Do we want coredumps from processes that use io_uring? yes
>> Exactly what we want from io_uring threads is less clear.  We can't
>> really give much that is meaningful beyond the thread ids of the
>> io_uring threads.
>> 
>> What problems do are you seeing beyond the missing registers on the
>> stack for kernel threads?
>> 
>> I don't immediately see the connection between coredumps and de_thread.
>> 
>> The function de_thread arranges for the fatal_signal_pending to be true,
>> and that should work just fine for io_uring threads.  The io_uring
>> threads process the fatal_signal with get_signal and then proceed to
>> exit eventually calling do_exit.
>
> I would like to see the testing in cases when the io-uring thread is
> the one getting hit by initial signal and when it's the normal one
> with associated io-uring ones.  The thread-collecting logics at least
> used to depend upon fairly subtle assumptions, and "kernel threads
> obviously can't show up as candidates" used to narrow the analysis
> down...
>
> In any case, WTF would we allow reads or writes to *any* registers of
> such threads?  It's not as simple as "just return zeroes", BTW - the
> values allowed in special registers might have non-trivial constraints
> on them.  The same goes for coredump - we don't _have_ registers to
> dump for those, period.
>
> Looks like the first things to do would be
> 	* prohibit ptrace accessing any regsets of worker threads
> 	* make coredump skip all register notes for those

Skipping register notes is fine.  Prohibiting ptrace access to any
regsets of worker threads is interesting.  I think that was tried and
shown to confuse gdb.  So the conclusion was just to provide a fake set
of registers.

Which has appears to work up to the point of dealing with architectures
that have their magic caller-saved optimization (like alpha and m68k),
and no check that all of the registers were saved when accessed.  Adding
a dummy switch stack frame for the kernel threads on those architectures
looks like a good/cheap solution at first glance.

> Note, BTW, that kernel_thread() and kernel_execve() do *NOT* step into
> ptrace_notify() - explicit CLONE_UNTRACED for the former and zero
> current->ptrace in the caller of the latter.  So fork and exec side
> has ptrace_event() crap limited to real syscalls.

That is where I thought we were.  Thanks for confirming that.

> It's seccomp[1] and exit-related stuff that are messy...
>
> [1] "never trust somebody who introduces himself as Honest Joe and keeps
> carping on that all the time"; c.f. __secure_computing(), CONFIG_INTEGRITY,
> etc.
