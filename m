Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:35881 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728576AbfFMK4W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Jun 2019 06:56:22 -0400
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Date: Thu, 13 Jun 2019 10:56:17 +0000
Message-ID: <66311ce9762849f7988c16bc752ea5a9@AcuMS.aculab.com>
References: <20190604134117.GA29963@redhat.com>
 <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
 <87ef45axa4.fsf_-_@xmission.com> <20190610162244.GB8127@redhat.com>
 <87lfy96sta.fsf@xmission.com>
 <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
 <20190612134558.GB3276@redhat.com>
 <6f748b26bef748208e2a74174c0c0bfc@AcuMS.aculab.com>
 <6e9b964b08d84c99980b1707e5fe3d1d@AcuMS.aculab.com>
 <20190613094324.GA12506@redhat.com>
In-Reply-To: <20190613094324.GA12506@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Oleg Nesterov' <oleg@redhat.com>
Cc: "'Eric W. Biederman'" <ebiederm@xmission.com>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Deepa Dinamani' <deepa.kernel@gmail.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'arnd@arndb.de'" <arnd@arndb.de>, "'dbueso@suse.de'" <dbueso@suse.de>, "'axboe@kernel.dk'" <axboe@kernel.dk>, "'dave@stgolabs.net'" <dave@stgolabs.net>, "'e@80x24.org'" <e@80x24.org>, "'jbaron@akamai.com'" <jbaron@akamai.com>, "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>, "'linux-aio@kvack.org'" <linux-aio@kvack.org>, "'omar.kilani@gmail.com'" <omar.kilani@gmail.com>, "'tglx@linutronix.de'" <tglx@linutronix.de>, 'Al Viro' <viro@ZenIV.linux.org.uk>, 'Linus Torvalds' <torvalds@linux-foundation.org>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>
Message-ID: <20190613105617.j8nw9TGK4iUZ8kx0Y6a9QZHhb5DgW0t1GI--p4VGPpQ@z>

From: Oleg Nesterov
> Sent: 13 June 2019 10:43
> On 06/13, David Laight wrote:
> >
> > I tested NetBSD last night.
> > pselect() always calls the signal handlers even when an fd is ready.
> > I'm beginning to suspect that this is the 'standards conforming' behaviour.
> 
> May be. May be not. I have no idea.
> 
> > > The ToG page for pselect() http://pubs.opengroup.org/onlinepubs/9699919799/functions/pselect.html
> > > says:
> > >     "If sigmask is not a null pointer, then the pselect() function shall replace
> > >     the signal mask of the caller by the set of signals pointed to by sigmask
> > >     before examining the descriptors, and shall restore the signal mask of the
> > >     calling thread before returning."
> 
> > > Note that it says 'before examining the descriptors' not 'before blocking'.
> 
> And you interpret this as if a pending signal should be delivered in any case,
> even if pselect succeeds. Again, perhaps you are right, but to me this is simply
> undocumented.

This text (from http://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html) is moderately clear:
    ... if all threads within the process block delivery of the signal, the signal shall
    remain pending on the process until a thread calls a sigwait() function selecting that
    signal, a thread unblocks delivery of the signal, or the action associated with the signal
    is set to ignore the signal.

So when pselect() 'replaces the signal mask' any pending signals should be delivered.
And 'delivery' means 'call the signal handler'.
All Unix systems will defer calling the signal handler until the system call
returns, but this is not mandated by Posix.

> However, linux never did this. Until the commit 854a6ed56839 ("signal: Add
> restore_user_sigmask()"). This commit caused regression. We had to revert it.

That change wasn't expected to change the behaviour...

	David

> > > If nothing else the man pages need a note about the standards and portability.
> 
> Agreed.
> 
> Oleg.

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
