Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389293AbfFJQXK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Jun 2019 12:23:10 -0400
Date: Mon, 10 Jun 2019 18:22:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Message-ID: <20190610162244.GB8127@redhat.com>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
 <20190529161157.GA27659@redhat.com>
 <20190604134117.GA29963@redhat.com>
 <20190606140814.GA13440@redhat.com>
 <87k1dxaxcl.fsf_-_@xmission.com>
 <87ef45axa4.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ef45axa4.fsf_-_@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, linux-kernel@vger.kernel.org, arnd@arndb.de, dbueso@suse.de, axboe@kernel.dk, dave@stgolabs.net, e@80x24.org, jbaron@akamai.com, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, omar.kilani@gmail.com, tglx@linutronix.de, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, David Laight <David.Laight@ACULAB.COM>, linux-arch@vger.kernel.org
Message-ID: <20190610162245.v7VXuZwPGyL3wGKZRZHKrJIyq93KrNk0XrVy1ryc_QE@z>

On 06/07, Eric W. Biederman wrote:
>
> +static int set_sigmask(sigset_t *kmask)
> +{
> +	set_restore_sigmask();
> +	current->saved_sigmask = current->blocked;
> +	set_current_blocked(kmask);
> +
> +	return 0;
> +}

I was going to do the same change except my version returns void ;)

So ACK.


As for 2-5, sorry I can't read them today, will do tomorrow.

But at first glance... yes, we can remove TIF_RESTORE_SIGMASK.

As for "remove saved_sigmask" I have some concerns... At least this
means a user-visible change iiuc. Say, pselect unblocks a fatal signal.
Say, SIGINT without a handler. Suppose SIGINT comes after set_sigmask().

Before this change the process will be killed.

After this change it will be killed or not. It won't be killed if
do_select() finds an already ready fd without blocking, or it finds a
ready fd right after SIGINT interrupts poll_schedule_timeout().

And _to me_ the new behaviour makes more sense. But when it comes to
user-visible changes you can never know if it breaks something or not.

Oleg.
