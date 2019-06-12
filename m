Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436660AbfFLNqO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Jun 2019 09:46:14 -0400
Date: Wed, 12 Jun 2019 15:45:59 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Message-ID: <20190612134558.GB3276@redhat.com>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
 <20190529161157.GA27659@redhat.com>
 <20190604134117.GA29963@redhat.com>
 <20190606140814.GA13440@redhat.com>
 <87k1dxaxcl.fsf_-_@xmission.com>
 <87ef45axa4.fsf_-_@xmission.com>
 <20190610162244.GB8127@redhat.com>
 <87lfy96sta.fsf@xmission.com>
 <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "'Eric W. Biederman'" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "dbueso@suse.de" <dbueso@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>, "dave@stgolabs.net" <dave@stgolabs.net>, "e@80x24.org" <e@80x24.org>, "jbaron@akamai.com" <jbaron@akamai.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, "omar.kilani@gmail.com" <omar.kilani@gmail.com>, "tglx@linutronix.de" <tglx@linutronix.de>, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190612134559.gCUuNSiKlWygzG2ncrmFbgGxoPcAcojFLYRVzaxGf9Y@z>

On 06/11, David Laight wrote:
>
> If I have an application that has a loop with a pselect call that
> enables SIGINT (without a handler) and, for whatever reason,
> one of the fd is always 'ready' then I'd expect a SIGINT
> (from ^C) to terminate the program.

This was never true.

Before Eric's patches SIGINT can kill a process or not, depending on timing.
In particular, if SIGINT was already pending before pselect() and it finds
an already ready fd, the program won't terminate.

After the Eric's patches SIGINT will only kill the program if pselect() does
not find a ready fd.

And this is much more consistent. Now we can simply say that the signal will
be delivered only if pselect() fails and returns -EINTR. If it doesn't have
a handler the process will be killed, otherwise the handler will be called.

Oleg.
