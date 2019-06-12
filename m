Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:58798 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405378AbfFLPLt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jun 2019 11:11:49 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>
        <20190604134117.GA29963@redhat.com>
        <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
        <87ef45axa4.fsf_-_@xmission.com> <20190610162244.GB8127@redhat.com>
        <87lfy96sta.fsf@xmission.com>
        <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
        <20190612134558.GB3276@redhat.com>
        <6f748b26bef748208e2a74174c0c0bfc@AcuMS.aculab.com>
Date: Wed, 12 Jun 2019 10:11:28 -0500
In-Reply-To: <6f748b26bef748208e2a74174c0c0bfc@AcuMS.aculab.com> (David
        Laight's message of "Wed, 12 Jun 2019 14:18:28 +0000")
Message-ID: <87v9xayh27.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Oleg Nesterov' <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "dbueso@suse.de" <dbueso@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>, "dave@stgolabs.net" <dave@stgolabs.net>, "e@80x24.org" <e@80x24.org>, "jbaron@akamai.com" <jbaron@akamai.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, "omar.kilani@gmail.com" <omar.kilani@gmail.com>, "tglx@linutronix.de" <tglx@linutronix.de>, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190612151128.vakogfsRCoGHNOv-vJ7aw7Kxa-BAaOwBtPPnHcXeYBY@z>

David Laight <David.Laight@ACULAB.COM> writes:

> From: Oleg Nesterov
>> Sent: 12 June 2019 14:46
>> On 06/11, David Laight wrote:
>> >
>> > If I have an application that has a loop with a pselect call that
>> > enables SIGINT (without a handler) and, for whatever reason,
>> > one of the fd is always 'ready' then I'd expect a SIGINT
>> > (from ^C) to terminate the program.

I think this gets into a quality of implementation.

I suspect that set_user_sigmask should do:
if (signal_pending())
	return -ERESTARNOSIGHAND; /* -EINTR that restarts if nothing was pending */

Which should be safe as nothing has blocked yet to consume any of the
timeouts, and it should ensure that none of the routines miss a signal.

>> This was never true.
>> 
>> Before Eric's patches SIGINT can kill a process or not, depending on timing.
>> In particular, if SIGINT was already pending before pselect() and it finds
>> an already ready fd, the program won't terminate.
>
> Which matches what I see on a very old Linux system.
>
>> After the Eric's patches SIGINT will only kill the program if pselect() does
>> not find a ready fd.
>> 
>> And this is much more consistent. Now we can simply say that the signal will
>> be delivered only if pselect() fails and returns -EINTR. If it doesn't have
>> a handler the process will be killed, otherwise the handler will be called.
>
> But is it what the standards mandate?
> Can anyone check how Solaris and any of the BSDs behave?
> I don't have access to any solaris systems (I doubt I'll get the disk to
> spin on the one in my garage).
> I can check NetBSD when I get home.
>
> The ToG page for pselect() http://pubs.opengroup.org/onlinepubs/9699919799/functions/pselect.html says:
>     "If sigmask is not a null pointer, then the pselect() function shall replace
>     the signal mask of the caller by the set of signals pointed to by sigmask
>     before examining the descriptors, and shall restore the signal mask of the
>     calling thread before returning."
> Note that it says 'before examining the descriptors' not 'before blocking'.
> Under the general description about signals it also says that the signal handler
> will be called (or other action happen) when a pending signal is unblocked.
> So unblocking SIGINT (set to SIG_DFL) prior to examining the descriptors
> should be enough to cause the process to exit.
> The fact that signal handlers are not called until 'return to user'
> is really an implementation choice - but (IMHO) it should appear as if they
> were called at the time they became unmasked.
>
> If nothing else the man pages need a note about the standards and portability.

I think the entire point is so that signals can be added to an event
loop in a race free way.  *cough* signalfd *cough*.  I think if you are
setting SIGINT to SIG_DFL you would leave SIGINT unblocked so it can
happen anywhere.

I can see more utility in having a SIGINT handler and you block SIGINT
except in your polling loop so you can do something deterministic when
SIGINT comes in.

Which makes it independent of my patches, but still worth fixing.

Eric
