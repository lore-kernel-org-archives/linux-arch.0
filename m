Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:38333 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390317AbfFJVVA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jun 2019 17:21:00 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>
        <20190604134117.GA29963@redhat.com>
        <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
        <87ef45axa4.fsf_-_@xmission.com> <20190610162244.GB8127@redhat.com>
Date: Mon, 10 Jun 2019 16:20:33 -0500
In-Reply-To: <20190610162244.GB8127@redhat.com> (Oleg Nesterov's message of
        "Mon, 10 Jun 2019 18:22:45 +0200")
Message-ID: <87lfy96sta.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, linux-kernel@vger.kernel.org, arnd@arndb.de, dbueso@suse.de, axboe@kernel.dk, dave@stgolabs.net, e@80x24.org, jbaron@akamai.com, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, omar.kilani@gmail.com, tglx@linutronix.de, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, David Laight <David.Laight@ACULAB.COM>, linux-arch@vger.kernel.org
Message-ID: <20190610212033.JwGyBKo3IiofxZnQJVzg2cZrHroyy4G3MgVsWoQOW2w@z>

Oleg Nesterov <oleg@redhat.com> writes:

> On 06/07, Eric W. Biederman wrote:
>>
>> +static int set_sigmask(sigset_t *kmask)
>> +{
>> +	set_restore_sigmask();
>> +	current->saved_sigmask = current->blocked;
>> +	set_current_blocked(kmask);
>> +
>> +	return 0;
>> +}
>
> I was going to do the same change except my version returns void ;)
>
> So ACK.
>
>
> As for 2-5, sorry I can't read them today, will do tomorrow.
>
> But at first glance... yes, we can remove TIF_RESTORE_SIGMASK.
>
> As for "remove saved_sigmask" I have some concerns... At least this
> means a user-visible change iiuc. Say, pselect unblocks a fatal signal.
> Say, SIGINT without a handler. Suppose SIGINT comes after set_sigmask().
>
> Before this change the process will be killed.
>
> After this change it will be killed or not. It won't be killed if
> do_select() finds an already ready fd without blocking, or it finds a
> ready fd right after SIGINT interrupts poll_schedule_timeout().

Yes.  Because having the signal set in real_blocked disables the
immediate kill optimization, and the signal has to be delivered before
we decide to kill the process.  Which matters because as you say if
nothing checks signal_pending() when the signals are unblocked we might
not attempt to deliver the signal.

So it is a matter of timing.

If we have both a signal and a file descriptor become ready
at the same time I would call that a race.  Either could
wake up the process and depending on the exact time we could
return either one.

So it is possible that today if the signal came just after the file
descriptor ,the code might have made it to restore_saved_sigmask_unless,
before __send_signal runs.

I see the concern.  I think in a matter like this we try it.  Make
the patches clean so people can bisect the problem.  Then if someone
runs into this problem we revert the offending patches.

If it looks like bisection won't cleanly reveal the potential problem
please let me know.

Personally I don't think anyone sane would intentionally depend on this
and I don't think there is a sufficiently reliable way to depend on this
by accident that people would actually be depending on it.

> And _to me_ the new behaviour makes more sense. But when it comes to
> user-visible changes you can never know if it breaks something or not.

True.

The set of applications is larger than any developer can reasonably test.

Eric
