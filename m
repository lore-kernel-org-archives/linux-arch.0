Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:29734 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405359AbfFKPqP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Jun 2019 11:46:15 -0400
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Date: Tue, 11 Jun 2019 15:46:11 +0000
Message-ID: <05ffd0f434c64262aa767db81ad75ac1@AcuMS.aculab.com>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>     <20190604134117.GA29963@redhat.com>
        <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
        <87ef45axa4.fsf_-_@xmission.com> <20190610162244.GB8127@redhat.com>
 <87lfy96sta.fsf@xmission.com>
 <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
In-Reply-To: <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "'Eric W. Biederman'" <ebiederm@xmission.com>, 'Oleg Nesterov' <oleg@redhat.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>, 'Deepa Dinamani' <deepa.kernel@gmail.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'arnd@arndb.de'" <arnd@arndb.de>, "'dbueso@suse.de'" <dbueso@suse.de>, "'axboe@kernel.dk'" <axboe@kernel.dk>, "'dave@stgolabs.net'" <dave@stgolabs.net>, "'e@80x24.org'" <e@80x24.org>, "'jbaron@akamai.com'" <jbaron@akamai.com>, "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>, "'linux-aio@kvack.org'" <linux-aio@kvack.org>, "'omar.kilani@gmail.com'" <omar.kilani@gmail.com>, "'tglx@linutronix.de'" <tglx@linutronix.de>, 'Al Viro' <viro@ZenIV.linux.org.uk>, 'Linus Torvalds' <torvalds@linux-foundation.org>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>
Message-ID: <20190611154611.yBA_3lU59LTLtiJS7U8NpDGwpVjyQDwUqhbt6WouQ3k@z>

From: David Laight
> Sent: 11 June 2019 10:52
...
> FWIW is ERESTARTNOHAND actually sane here?
> If I've used setitimer() to get SIGALARM generated every second I'd
> expect select() to return EINTR every second even if I don't
> have a SIGALARM handler?

Actually no - after sigset(SIGALRM, SIG_IGN) I'd expect absolutely
nothing to happen when kill(pid, SIGALRM) is called.

However if I run:

	struct itimerval itimerval = {{1, 0}, {1, 0}};
	setitimer(ITIMER_REAL, &itimerval, NULL);
	sigset(SIGALRM, SIG_IGN);

	poll(0, 0, big_timeout);

I see (with strace) poll() repeatedly returning ERESTART_RESTARTBLOCK
and being restarted.
Replacing poll() with pselect() returns ERESTARTNOHAND.
(In both cases the timeout must be updated since the application
does see the timeout.)

I'm sure other unix kernels completely ignore signals set to SIG_IGN.
So this restart dance just isn't needed.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
