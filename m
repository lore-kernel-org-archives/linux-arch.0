Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 29 Jun 2005 11:00:58 +0300
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: Remaining arch problems in cpu_idle
Message-ID: <20050629080058.GA2694@linux-sh.org>
References: <42C24874.8030702@yahoo.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <42C24874.8030702@yahoo.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 29, 2005 at 05:06:28PM +1000, Nick Piggin wrote:
> h8300, ia64, and sh64 still have possible outstanding issues,
> which I've put at the end of the Documentation/ file. It
> would be nice to get these looked at.
>=20
Looking at this, sh64 is pretty much in the same category as h8300. sh
is as well, but we seem to be missing the local_irq_disable/enable around
the need_resched check there completely, which is even more bogus.

> +4. The only time interrupts need to be disabled when checking
> +   need_resched is if we are about to sleep the processor until
> +   the next interrupt (this doesn't provide any protection of
> +   need_resched, it prevents losing an interrupt).
> +
> +	4a. Common problem with this type of sleep appears to be:
> +	        local_irq_disable();
> +	        if (!need_resched()) {
> +	                local_irq_enable();
> +	                *** resched interrupt arrives here ***
> +	                __asm__("sleep until next interrupt");
> +	        }
> +
> +Possible arch/ problems
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Possible arch problems I found (and either tried to fix or didn't):
> +
> +h8300 - Is such sleeping racy vs interrupts? (See #4a).
> +        The H8/300 manual I found indicates yes, however disabling IRQs
> +        over the sleep mean only NMIs can wake it up, so can't fix easily
> +        without doing spin waiting.
> +
We have the same problem for sh/sh64 (which isn't surprising, considering
they all share ancestry).

There are several different states that can be entered, with different
method for exiting, although at least the sleep and deep sleep states
both require an interrupt, NMI, or a reset request.

I can update sh and sh64 to follow the h8300 change, but that still
doesn't address the race. What sort of spin waiting do you have in mind?

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCwlU51K+teJFxZ9wRAiLBAJ9bh5+9PX8IefWM6mF6ja+Hut1qVwCeLyU6
wzO/YsXuxcVhrEm+SK4Mnsg=
=CxhO
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
