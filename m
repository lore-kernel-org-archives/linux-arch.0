Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59539 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbfFLPiP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Jun 2019 11:38:15 -0400
Date: Wed, 12 Jun 2019 17:37:57 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Message-ID: <20190612153756.GD3276@redhat.com>
References: <20190604134117.GA29963@redhat.com>
 <20190606140814.GA13440@redhat.com>
 <87k1dxaxcl.fsf_-_@xmission.com>
 <87ef45axa4.fsf_-_@xmission.com>
 <20190610162244.GB8127@redhat.com>
 <87lfy96sta.fsf@xmission.com>
 <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
 <20190612134558.GB3276@redhat.com>
 <6f748b26bef748208e2a74174c0c0bfc@AcuMS.aculab.com>
 <87v9xayh27.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9xayh27.fsf@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: David Laight <David.Laight@ACULAB.COM>, Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "dbueso@suse.de" <dbueso@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>, "dave@stgolabs.net" <dave@stgolabs.net>, "e@80x24.org" <e@80x24.org>, "jbaron@akamai.com" <jbaron@akamai.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, "omar.kilani@gmail.com" <omar.kilani@gmail.com>, "tglx@linutronix.de" <tglx@linutronix.de>, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190612153757.069RdC28WQDoB0MWaN45YqZRTcj8Dhna8aMgaoavWqk@z>

On 06/12, Eric W. Biederman wrote:
> David Laight <David.Laight@ACULAB.COM> writes:
>
> > From: Oleg Nesterov
> >> Sent: 12 June 2019 14:46
> >> On 06/11, David Laight wrote:
> >> >
> >> > If I have an application that has a loop with a pselect call that
> >> > enables SIGINT (without a handler) and, for whatever reason,
> >> > one of the fd is always 'ready' then I'd expect a SIGINT
> >> > (from ^C) to terminate the program.
>
> I think this gets into a quality of implementation.
>
> I suspect that set_user_sigmask should do:
> if (signal_pending())
> 	return -ERESTARNOSIGHAND; /* -EINTR that restarts if nothing was pending */
>
> Which should be safe as nothing has blocked yet to consume any of the
> timeouts, and it should ensure that none of the routines miss a signal.

Why? I don't think this makes any sense.

Perhaps we could do this _after_ set_current_blocked() for the case when
the already pending SIGINT was unblocked but a) I am not sure this would
be really better and b) I think it is too late to change this.

Oleg.
