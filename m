From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH/RFC] asm-generic/mutex-dec.h: add SMP support
Date: Mon, 06 Jun 2011 23:32:58 +0200
Message-ID: <1307395978.2642.33.camel@edumazet-laptop>
References: <1306725568-10922-1-git-send-email-vapier@gentoo.org>
	 <20110606142301.c0a570da.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43774 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500Ab1FFVdD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2011 17:33:03 -0400
In-Reply-To: <20110606142301.c0a570da.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Frysinger <vapier@gentoo.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Nick Piggin <npiggin@kernel.dk>

Le lundi 06 juin 2011 =C3=A0 14:23 -0700, Andrew Morton a =C3=A9crit :
> On Sun, 29 May 2011 23:19:28 -0400
> Mike Frysinger <vapier@gentoo.org> wrote:
>=20
> > To make these guys work on SMP systems, we just need to sprinkle a =
few
> > barriers around.
> >=20
> > Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> > ---
> > note: this is what the Blackfin SMP port is using, but it doesn't s=
eem
> > like other SMP ports are ... so I wonder if we're just trying too h=
ard
> > and these barriers aren't actually necessary ?
> >=20
> >  include/asm-generic/mutex-dec.h |    8 +++++++-
> >  1 files changed, 7 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/include/asm-generic/mutex-dec.h b/include/asm-generic/=
mutex-dec.h
> > index f104af7..e746c3c 100644
> > --- a/include/asm-generic/mutex-dec.h
> > +++ b/include/asm-generic/mutex-dec.h
> > @@ -22,6 +22,8 @@ __mutex_fastpath_lock(atomic_t *count, void (*fai=
l_fn)(atomic_t *))
> >  {
> >  	if (unlikely(atomic_dec_return(count) < 0))
> >  		fail_fn(count);

Check Documentation/memory-barriers.txt, around line 1688

atomic_dec_return() implies a full memory barrier on each side of the
operation.

smp_mb() is therefore not needed here


> > +	else
> > +		smp_mb();
> >  }
> > =20
> >  /**
> > @@ -39,6 +41,7 @@ __mutex_fastpath_lock_retval(atomic_t *count, int=
 (*fail_fn)(atomic_t *))
> >  {
> >  	if (unlikely(atomic_dec_return(count) < 0))
> >  		return fail_fn(count);
> > +	smp_mb();

atomic_dec_return() implies a full memory barrier.
	smp_mb() is therefore not needed here

> >  	return 0;
> >  }
> > =20
> > @@ -58,6 +61,7 @@ __mutex_fastpath_lock_retval(atomic_t *count, int=
 (*fail_fn)(atomic_t *))
> >  static inline void
> >  __mutex_fastpath_unlock(atomic_t *count, void (*fail_fn)(atomic_t =
*))
> >  {
> > +	smp_mb();

atomic_inc_return() implies a full memory barrier.
	smp_mb() is therefore not needed here


> >  	if (unlikely(atomic_inc_return(count) <=3D 0))
> >  		fail_fn(count);
> >  }
> > @@ -82,8 +86,10 @@ __mutex_fastpath_unlock(atomic_t *count, void (*=
fail_fn)(atomic_t *))
> >  static inline int
> >  __mutex_fastpath_trylock(atomic_t *count, int (*fail_fn)(atomic_t =
*))
> >  {
> > -	if (likely(atomic_cmpxchg(count, 1, 0) =3D=3D 1))
> > +	if (likely(atomic_cmpxchg(count, 1, 0) =3D=3D 1)) {
> > +		smp_mb();

atomic_cmpxchg() implies a full memory barrier.
	smp_mb() is therefore not needed here


> >  		return 1;
> > +	}
> >  	return 0;
> >  }
>=20
> This patch basically reverts Nick's a8ddac7e53e89cb ("mutex: speed up
> generic mutex implementations").  What's up with that?
>=20
> I could try to review this patch but I'm pathetic with barriers.  Hel=
p.

Well, I really dont understand this patch, it makes no sense.
