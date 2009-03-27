From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 5/13] score - New architecure port to SunplusCT S+CORE processor
Date: Fri, 27 Mar 2009 21:26:14 +0100
Message-ID: <20090327202614.GA22054@uranus.ravnborg.org>
References: <OFE9A5E3A2.37B73BA8-ON48257586.0008CFAC-48257586.00091B05@sunplusct.com> <20090327184013.GB21149@uranus.ravnborg.org> <200903272019.53689.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:59598 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555AbZC0UYO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2009 16:24:14 -0400
Content-Disposition: inline
In-Reply-To: <200903272019.53689.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: liqin.chen@sunplusct.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org

On Fri, Mar 27, 2009 at 08:19:53PM +0100, Arnd Bergmann wrote:
> On Friday 27 March 2009, Sam Ravnborg wrote:
> > > +struct shmid64_ds {
> > > + =A0 =A0 =A0 struct ipc64_perm =A0 =A0 =A0 shm_perm; =A0 =A0 =A0=
 /* operation perms */
> > > + =A0 =A0 =A0 size_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0shm_segsz=
; =A0 =A0 =A0/* size of segment (bytes)=20
> > > */
> > > + =A0 =A0 =A0 __kernel_time_t =A0 =A0 =A0 =A0 shm_atime; =A0 =A0 =
=A0/* last attach time */
> > > + =A0 =A0 =A0 __kernel_time_t =A0 =A0 =A0 =A0 shm_dtime; =A0 =A0 =
=A0/* last detach time */
> > > + =A0 =A0 =A0 __kernel_time_t =A0 =A0 =A0 =A0 shm_ctime; =A0 =A0 =
=A0/* last change time */
> > > + =A0 =A0 =A0 __kernel_pid_t =A0 =A0 =A0 =A0 =A0shm_cpid; =A0 =A0=
 =A0 /* pid of creator */
> > > + =A0 =A0 =A0 __kernel_pid_t =A0 =A0 =A0 =A0 =A0shm_lpid; =A0 =A0=
 =A0 /* pid of last operator */
> > > + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 shm_nattch; =A0 =A0=
 /* no. of current attaches=20
> > > */
> > > + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 __unused1;
> > > + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 __unused2;
> > > +};
> >=20
> > This is an exported header and you mix wide specific and generic ty=
pes.
> > The recommended way is to stick to the __[u]{32,64}int versions + t=
he kernel
> > specific types as __kernel_pid_t.
> > In other words avoid use of int, long etc in your exported headers.
> >=20
>=20
> This is correct in general, but in this particular case (SysV IPC) it=
 is
> exactly what most of the other architectures do. It's basically impos=
sible
> to get this right, so simply doing the same as x86 is the best option
> I found (unlike most of the other headers).

Thats strange indeed.
This structure will then change layout depending on the target bit-size
of the compiler.

=46rom x86:
#ifdef __i386__
        unsigned long           __unused1;
#endif
        __kernel_time_t         shm_dtime;      /* last detach time */
#ifdef __i386__
        unsigned long           __unused2;
#endif

long is 64 bit in one case and 32 bit in another case.
I'm confused..

I would expect it to be safer to be bit-size neutral in our
exported headers.
But the score people know there userlend best so let them decide.

Still they should audit all their exported headers.
They cannot assume it was right because they copied them from
somewhere.

	Sam
