From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Date: Tue, 11 Jun 2019 15:46:11 +0000
Message-ID: <05ffd0f434c64262aa767db81ad75ac1@AcuMS.aculab.com>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
	<20190529161157.GA27659@redhat.com>	<20190604134117.GA29963@redhat.com>
	<20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
	<87ef45axa4.fsf_-_@xmission.com> <20190610162244.GB8127@redhat.com>
 <87lfy96sta.fsf@xmission.com>
 <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
Content-Language: en-US
Sender: owner-linux-aio@kvack.org
To: "'Eric W. Biederman'" <ebiederm@xmission.com>, 'Oleg Nesterov' <oleg@redhat.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>, 'Deepa Dinamani' <deepa.kernel@gmail.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'arnd@arndb.de'" <arnd@arndb.de>, "'dbueso@suse.de'" <dbueso@suse.de>, "'axboe@kernel.dk'" <axboe@kernel.dk>, "'dave@stgolabs.net'" <dave@stgolabs.net>, "'e@80x24.org'" <e@80x24.org>, "'jbaron@akamai.com'" <jbaron@akamai.com>, "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>, "'linux-aio@kvack.org'" <linux-aio@kvack.org>, "'omar.kilani@gmail.com'" <omar.kilani@gmail.com>, "'tglx@linutronix.de'" <tglx@linutronix.de>, 'Al Viro' <viro@ZenIV.linux.org.uk>, 'Linus Torvalds' <torvalds@linux-foundation.org>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

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

=09struct itimerval itimerval =3D {{1, 0}, {1, 0}};
=09setitimer(ITIMER_REAL, &itimerval, NULL);
=09sigset(SIGALRM, SIG_IGN);

=09poll(0, 0, big_timeout);

I see (with strace) poll() repeatedly returning ERESTART_RESTARTBLOCK
and being restarted.
Replacing poll() with pselect() returns ERESTARTNOHAND.
(In both cases the timeout must be updated since the application
does see the timeout.)

I'm sure other unix kernels completely ignore signals set to SIG_IGN.
So this restart dance just isn't needed.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
