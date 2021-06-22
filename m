Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35B0C48BDF
	for <linux-arch@archiver.kernel.org>; Tue, 22 Jun 2021 21:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8BAB60FF4
	for <linux-arch@archiver.kernel.org>; Tue, 22 Jun 2021 21:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhFVVFP (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 22 Jun 2021 17:05:15 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:46740 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFVVFO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jun 2021 17:05:14 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lvnXs-0044vo-6k; Tue, 22 Jun 2021 15:02:56 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lvnXq-00Gefl-Rt; Tue, 22 Jun 2021 15:02:55 -0600
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
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
        <87eed4v2dc.fsf@disp2133>
        <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
        <87fsxjorgs.fsf@disp2133>
        <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
        <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
        <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
        <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
        <YNDsYk6kbisbNy3I@zeniv-ca.linux.org.uk>
        <CAHk-=wh82uJ5Poqby3brn-D7xWbCMnGv-JnwfO0tuRfCvsVgXA@mail.gmail.com>
        <YNEfXhi80e/VXgc9@zeniv-ca.linux.org.uk>
        <CAHk-=wjtagi3g5thA-T8ooM8AXcy3brdHzugCPU0itdbpDYH_A@mail.gmail.com>
Date:   Tue, 22 Jun 2021 16:02:46 -0500
In-Reply-To: <CAHk-=wjtagi3g5thA-T8ooM8AXcy3brdHzugCPU0itdbpDYH_A@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 21 Jun 2021 16:36:33 -0700")
Message-ID: <87h7hpbojt.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lvnXq-00Gefl-Rt;;;mid=<87h7hpbojt.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19uEzD4RxF7EsGUMi05fkwCV4KqKwu700c=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Jun 21, 2021 at 4:23 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>>         How would it help e.g. oopsen on the way out of timer interrupts?
>> IMO we simply shouldn't allow ptrace access if the tracee is in that kind
>> of state, on any architecture...
>
> Yeah no, we can't do the "wait for ptrace" when the exit is due to an
> oops. Although honestly, we have other cases like that where do_exit()
> isn't 100% robust if you kill something in an interrupt. Like all the
> locks it leaves locked etc.
>
> So do_exit() from a timer interrupt is going to cause problems
> regardless. I agree it's probably a good idea to try to avoid causing
> even more with the odd ptrace thing, but I don't think ptrace_event is
> some really "fundamental" problem at that point - it's just one detail
> among many many.
>
> So I was more thinking of the debug patch for m68k to catch all the
> _regular_ cases, and all the other random cases of ptrace_event() or
> ptrace_notify().
>
> Although maybe we've really caught them all. The exit case was clearly
> missing, and the thread fork case was scrogged. There are patches for
> the known problems. The patches I really don't like are the
> verification ones to find any unknown ones..

We still have nios2 which copied the m68k logic at some point.  I think
that is a processor that is still ``shipping'' and that people might
still be using in new designs.

I haven't looked closely enough to see what the other architectures with
caller saved registers are doing.

The challenging ones are /proc/pid/syscall and seccomp which want to see
all of the system call arguments.  I think every architecture always
saves the system call arguments unconditionally, so those cases are
probably not as interesting.  But they certain look like they could be
trouble.

Eric

