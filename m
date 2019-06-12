Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:60350 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfFLMk0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jun 2019 08:40:26 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>
        <20190604134117.GA29963@redhat.com>
        <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
        <87ef45axa4.fsf_-_@xmission.com> <20190610162244.GB8127@redhat.com>
        <87lfy96sta.fsf@xmission.com>
        <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
        <05ffd0f434c64262aa767db81ad75ac1@AcuMS.aculab.com>
Date: Wed, 12 Jun 2019 07:40:03 -0500
In-Reply-To: <05ffd0f434c64262aa767db81ad75ac1@AcuMS.aculab.com> (David
        Laight's message of "Tue, 11 Jun 2019 15:46:11 +0000")
Message-ID: <8736kf3rks.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Oleg Nesterov' <oleg@redhat.com>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Deepa Dinamani' <deepa.kernel@gmail.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'arnd@arndb.de'" <arnd@arndb.de>, "'dbueso@suse.de'" <dbueso@suse.de>, "'axboe@kernel.dk'" <axboe@kernel.dk>, "'dave@stgolabs.net'" <dave@stgolabs.net>, "'e@80x24.org'" <e@80x24.org>, "'jbaron@akamai.com'" <jbaron@akamai.com>, "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>, "'linux-aio@kvack.org'" <linux-aio@kvack.org>, "'omar.kilani@gmail.com'" <omar.kilani@gmail.com>, "'tglx@linutronix.de'" <tglx@linutronix.de>, 'Al Viro' <viro@ZenIV.linux.org.uk>, 'Linus Torvalds' <torvalds@linux-foundation.org>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>
Message-ID: <20190612124003.MNNJLPCUL0UjRoxY0ew9V2y--4RS5GT7FEqtSZaNzAs@z>

David Laight <David.Laight@ACULAB.COM> writes:

> From: David Laight
>> Sent: 11 June 2019 10:52
> ...
>> FWIW is ERESTARTNOHAND actually sane here?
>> If I've used setitimer() to get SIGALARM generated every second I'd
>> expect select() to return EINTR every second even if I don't
>> have a SIGALARM handler?
>
> Actually no - after sigset(SIGALRM, SIG_IGN) I'd expect absolutely
> nothing to happen when kill(pid, SIGALRM) is called.
>
> However if I run:
>
> 	struct itimerval itimerval = {{1, 0}, {1, 0}};
> 	setitimer(ITIMER_REAL, &itimerval, NULL);
> 	sigset(SIGALRM, SIG_IGN);
>
> 	poll(0, 0, big_timeout);
>
> I see (with strace) poll() repeatedly returning ERESTART_RESTARTBLOCK
> and being restarted.
> Replacing poll() with pselect() returns ERESTARTNOHAND.
> (In both cases the timeout must be updated since the application
> does see the timeout.)
>
> I'm sure other unix kernels completely ignore signals set to SIG_IGN.
> So this restart dance just isn't needed.

We also ignore such signals except when the signal is blocked when it is
received.

We don't currently but it would be perfectly legitimate for
set_current_blocked to dequeue and drop signals that have become
unblocked whose handler is SIG_IGN.

The dance would still be needed for the rare case where TIF_SIGPENDING
gets set for a non-signal.

Dropping the signal while it is blocked if it's handler is SIG_IGN looks
like a bad idea.

Eric
