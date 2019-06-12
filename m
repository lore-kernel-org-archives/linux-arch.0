From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Date: Wed, 12 Jun 2019 17:37:57 +0200
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-aio@kvack.org>
Content-Disposition: inline
In-Reply-To: <87v9xayh27.fsf@xmission.com>
Sender: owner-linux-aio@kvack.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: David Laight <David.Laight@ACULAB.COM>, Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "dbueso@suse.de" <dbueso@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>, "dave@stgolabs.net" <dave@stgolabs.net>, "e@80x24.org" <e@80x24.org>, "jbaron@akamai.com" <jbaron@akamai.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, "omar.kilani@gmail.com" <omar.kilani@gmail.com>, "tglx@linutronix.de" <tglx@linutronix.de>, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

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

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
