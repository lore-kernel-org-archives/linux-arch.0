Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731989AbfFMMoJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Jun 2019 08:44:09 -0400
Date: Thu, 13 Jun 2019 14:43:48 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Message-ID: <20190613124347.GB12506@redhat.com>
References: <87k1dxaxcl.fsf_-_@xmission.com>
 <87ef45axa4.fsf_-_@xmission.com>
 <20190610162244.GB8127@redhat.com>
 <87lfy96sta.fsf@xmission.com>
 <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
 <20190612134558.GB3276@redhat.com>
 <6f748b26bef748208e2a74174c0c0bfc@AcuMS.aculab.com>
 <6e9b964b08d84c99980b1707e5fe3d1d@AcuMS.aculab.com>
 <20190613094324.GA12506@redhat.com>
 <66311ce9762849f7988c16bc752ea5a9@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66311ce9762849f7988c16bc752ea5a9@AcuMS.aculab.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "'Eric W. Biederman'" <ebiederm@xmission.com>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Deepa Dinamani' <deepa.kernel@gmail.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'arnd@arndb.de'" <arnd@arndb.de>, "'dbueso@suse.de'" <dbueso@suse.de>, "'axboe@kernel.dk'" <axboe@kernel.dk>, "'dave@stgolabs.net'" <dave@stgolabs.net>, "'e@80x24.org'" <e@80x24.org>, "'jbaron@akamai.com'" <jbaron@akamai.com>, "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>, "'linux-aio@kvack.org'" <linux-aio@kvack.org>, "'omar.kilani@gmail.com'" <omar.kilani@gmail.com>, "'tglx@linutronix.de'" <tglx@linutronix.de>, 'Al Viro' <viro@ZenIV.linux.org.uk>, 'Linus Torvalds' <torvalds@linux-foundation.org>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>
Message-ID: <20190613124348.gAaGNsh6Hy-WrZjQ3rIZiQOFnp_m4u0fbVoWopMU77Q@z>

On 06/13, David Laight wrote:
>
> > And you interpret this as if a pending signal should be delivered in any case,
> > even if pselect succeeds. Again, perhaps you are right, but to me this is simply
> > undocumented.
>
> This text (from http://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html) is moderately clear:
>     ... if all threads within the process block delivery of the signal, the signal shall
>     remain pending on the process until a thread calls a sigwait() function selecting that
>     signal, a thread unblocks delivery of the signal, or the action associated with the signal
>     is set to ignore the signal.
>
> So when pselect() 'replaces the signal mask' any pending signals should be delivered.

I fail to understand this logic.


> > However, linux never did this. Until the commit 854a6ed56839 ("signal: Add
> > restore_user_sigmask()"). This commit caused regression. We had to revert it.
>
> That change wasn't expected to change the behaviour...

Yes.

And the changed behaviour matched your understanding of standard. We had to
change it back.

So what do you want from me? ;)

Oleg.
