From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [patches] [PATCH 2/9] RISC-V: Atomic and Locking Code
Date: Fri, 7 Jul 2017 15:16:07 +0200
Message-ID: <20170707131607.enpeooybtvzhbugh@latitude>
References: <20170704195102.3974-1-palmer@dabbelt.com>
 <20170704195102.3974-3-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tbnz6udjp3gqbaud"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:57654 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750778AbdGGNRt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 Jul 2017 09:17:49 -0400
Content-Disposition: inline
In-Reply-To: <20170704195102.3974-3-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: patches@groups.riscv.org
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, Palmer Dabbelt <palmer@dabbelt.com>


--tbnz6udjp3gqbaud
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2017 at 12:50:55PM -0700, Palmer Dabbelt wrote:
[...]
> +/* These barries need to enforce ordering on both devices or memory. */

Very minor nit: s/barries/barriers/ (in several places)


Jonathan Neusch=C3=A4fer

--tbnz6udjp3gqbaud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJZX4mPAAoJEAgwRJqO81/be28P/A6LVGxBCA2KP+eGtVqHCmng
ui7i05Z+SQlG8/UmERl3oKCFGBSUFeePwhmr6nvC08Kh6J8LW55jNrZzlUL194bo
++Brb09SwCAu2ejyq8OTaljcHXelOoOPgUhDhBgScIFAR7sKVFQkSgSxdGCQWzWN
p3pdZBbCQOHG0K1IadWD9MbJEUFrRLW98VhnOKL986pWMFMTxueuJqrOGuEO/5e1
OyHP4fHzbB7gN1taRpaGecx3uSuCZo1dbdRmEjJbVvLMGZf8EQ6Mmxhl+fL0rQL7
AL/7hVMrM47M+3XQtxDMAAZMvS6rJUwrMHyzMUyq9RabGXXt0Lqak1WKnNifcvdZ
n3sOmu8I0mzPfezmNrvSY4VuN7HONDoddRDAYfMK+Uyi8/xLsQF0NkuEEekn4cnB
K0WcdgsnJdOybFF3aqU15EoMbKLdj6p/EkECpUD/0MB1p1/uvLgqJY8IfM3fNPFE
qAjguVIjbpJGss4TAe08BXdnrXd1QU7BzFIl5LpKGU3Or5go0et5dVBgpbDGbUrj
crk2AvLFE2xg8K3ZWpPCgZ3/d5LcHERlZ8Vllz3MRUWuPhp9ISECUEFEAy6G+/Hl
yLljrNoyqOt82PVGYg3cFw6+J1krR5kPoq5JvCY4gTKtbnuxFVFQ0yaou7I33xPF
tj59aNS83ZW29pJILpdq
=p3p1
-----END PGP SIGNATURE-----

--tbnz6udjp3gqbaud--
