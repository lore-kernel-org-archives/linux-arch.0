From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Date: Thu, 13 Jun 2019 08:48:41 +0000
Message-ID: <6e9b964b08d84c99980b1707e5fe3d1d@AcuMS.aculab.com>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
 <20190529161157.GA27659@redhat.com> <20190604134117.GA29963@redhat.com>
 <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
 <87ef45axa4.fsf_-_@xmission.com> <20190610162244.GB8127@redhat.com>
 <87lfy96sta.fsf@xmission.com>
 <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
 <20190612134558.GB3276@redhat.com>
 <6f748b26bef748208e2a74174c0c0bfc@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <6f748b26bef748208e2a74174c0c0bfc@AcuMS.aculab.com>
Content-Language: en-US
Sender: owner-linux-aio@kvack.org
To: 'Oleg Nesterov' <oleg@redhat.com>
Cc: "'Eric W. Biederman'" <ebiederm@xmission.com>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Deepa Dinamani' <deepa.kernel@gmail.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'arnd@arndb.de'" <arnd@arndb.de>, "'dbueso@suse.de'" <dbueso@suse.de>, "'axboe@kernel.dk'" <axboe@kernel.dk>, "'dave@stgolabs.net'" <dave@stgolabs.net>, "'e@80x24.org'" <e@80x24.org>, "'jbaron@akamai.com'" <jbaron@akamai.com>, "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>, "'linux-aio@kvack.org'" <linux-aio@kvack.org>, "'omar.kilani@gmail.com'" <omar.kilani@gmail.com>, "'tglx@linutronix.de'" <tglx@linutronix.de>, 'Al Viro' <viro@ZenIV.linux.org.uk>, 'Linus Torvalds' <torvalds@linux-foundation.org>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

From: David Laight
> Sent: 12 June 2019 15:18
> From: Oleg Nesterov
> > Sent: 12 June 2019 14:46
> > On 06/11, David Laight wrote:
> > >
> > > If I have an application that has a loop with a pselect call that
> > > enables SIGINT (without a handler) and, for whatever reason,
> > > one of the fd is always 'ready' then I'd expect a SIGINT
> > > (from ^C) to terminate the program.
> >
> > This was never true.
> >
> > Before Eric's patches SIGINT can kill a process or not, depending on ti=
ming.
> > In particular, if SIGINT was already pending before pselect() and it fi=
nds
> > an already ready fd, the program won't terminate.
>=20
> Which matches what I see on a very old Linux system.
>=20
> > After the Eric's patches SIGINT will only kill the program if pselect()=
 does
> > not find a ready fd.
> >
> > And this is much more consistent. Now we can simply say that the signal=
 will
> > be delivered only if pselect() fails and returns -EINTR. If it doesn't =
have
> > a handler the process will be killed, otherwise the handler will be cal=
led.
>=20
> But is it what the standards mandate?
> Can anyone check how Solaris and any of the BSDs behave?
> I don't have access to any solaris systems (I doubt I'll get the disk to
> spin on the one in my garage).
> I can check NetBSD when I get home.

I tested NetBSD last night.
pselect() always calls the signal handlers even when an fd is ready.
I'm beginning to suspect that this is the 'standards conforming' behaviour.
I don't remember when pselect() was added to the ToG specs, it didn't
go through XNET while I  was going to the meetings.

=09David

>=20
> The ToG page for pselect() http://pubs.opengroup.org/onlinepubs/969991979=
9/functions/pselect.html
> says:
>     "If sigmask is not a null pointer, then the pselect() function shall =
replace
>     the signal mask of the caller by the set of signals pointed to by sig=
mask
>     before examining the descriptors, and shall restore the signal mask o=
f the
>     calling thread before returning."
> Note that it says 'before examining the descriptors' not 'before blocking=
'.
> Under the general description about signals it also says that the signal =
handler
> will be called (or other action happen) when a pending signal is unblocke=
d.
> So unblocking SIGINT (set to SIG_DFL) prior to examining the descriptors
> should be enough to cause the process to exit.
> The fact that signal handlers are not called until 'return to user'
> is really an implementation choice - but (IMHO) it should appear as if th=
ey
> were called at the time they became unmasked.
>=20
> If nothing else the man pages need a note about the standards and portabi=
lity.
>=20
> =09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
