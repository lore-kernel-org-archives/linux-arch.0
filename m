Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:41908 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbfFLNJh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jun 2019 09:09:37 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>
        <20190604134117.GA29963@redhat.com>
        <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
        <87ef45axa4.fsf_-_@xmission.com> <20190610162244.GB8127@redhat.com>
        <87lfy96sta.fsf@xmission.com> <20190611185548.GA31214@redhat.com>
        <fd2aab3d26754becbb0efe4ae65c32ac@AcuMS.aculab.com>
Date: Wed, 12 Jun 2019 08:09:17 -0500
In-Reply-To: <fd2aab3d26754becbb0efe4ae65c32ac@AcuMS.aculab.com> (David
        Laight's message of "Wed, 12 Jun 2019 08:39:53 +0000")
Message-ID: <874l4v0x36.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Oleg Nesterov' <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "dbueso@suse.de" <dbueso@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>, "dave@stgolabs.net" <dave@stgolabs.net>, "e@80x24.org" <e@80x24.org>, "jbaron@akamai.com" <jbaron@akamai.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, "omar.kilani@gmail.com" <omar.kilani@gmail.com>, "tglx@linutronix.de" <tglx@linutronix.de>, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190612130917.NvpMSZ55CcZ1jKgGNbt2QegdNz1RmEjU4FJBVjbv4CU@z>

David Laight <David.Laight@ACULAB.COM> writes:

> From: Oleg Nesterov [mailto:oleg@redhat.com]
>> Sent: 11 June 2019 19:56
>> On 06/10, Eric W. Biederman wrote:
>> >
>> > Personally I don't think anyone sane would intentionally depend on this
>> > and I don't think there is a sufficiently reliable way to depend on this
>> > by accident that people would actually be depending on it.
>> 
>> Agreed.
>> 
>> As I said I like these changes and I see nothing wrong. To me they fix the
>> current behaviour, or at least make it more consistent.
>> 
>> But perhaps this should be documented in the changelog? To make it clear
>> that this change was intentional.
>
> What happens if you run the test program I posted yesterday after the changes?
>
> It looks like pselect() and epoll_pwait() operated completely differently.
> pselect() would always calls the signal handlers.
> epoll_pwait() only calls them when EINTR is returned.
> So changing epoll_pwait() and pselect() to work the same way
> is bound to break some applications.

That is not the change we are discussing.  We are looking at making
pselect and epoll_pwait act a little more like sigtimedwait.

In particular we are discussiong signals whose handler is SIG_DFL and
whose default disposition is to kill the process, such as SIGINT.

When those signals are delivered and they are not blocked, we take
an optimized path in complete_signal and start the process tear down.

That early start of process tear down does not happen if the signal is
blocked or it happens to be in real_blocked (from sigtimedwait).

This matters is the small time window where the signal is received while
the process has temporarily unblocked the signal, and the signal is not
detected by the code and blocked and oridinarily would not be delivered
until next time because of restore_sigmask_unless.

If the tear down has started early.  Even if we would not have returned
the process normally the signal can kill the process.  AKA epoll_pwait
can today result in it's caller being killed without -EINTR being
returned.

My change fixes that behavior and disables the early process tear down
for those signals, by having real_blocked match the set of signals
that are normally blocked by the process.  The result should be
the signal will have to wait for the next call that temporarily
unblocked the process.

The real benefit is that that the code becomes more comprehensible.

It is my patch that titled: "signal: Always keep real_blocked in sync
with blocked" that causes that to happen.

Eric
