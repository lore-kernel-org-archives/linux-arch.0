From: James Hogan <jhogan@kernel.org>
Subject: Re: Introducing a nanoMIPS port for Linux
Date: Fri, 4 May 2018 14:24:33 +0100
Message-ID: <20180504132432.GA30458@jamesdev>
References: <20180502215107.GA9884@saruman>
 <CAK8P3a2y2EA1g099DXOHkfevQb=6zuWmVOq9C_wVTQ8zrAMx8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a2y2EA1g099DXOHkfevQb=6zuWmVOq9C_wVTQ8zrAMx8w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ralf Baechle <ralf@linux-mips.org>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>, Matt Redfearn <matt.redfearn@mips.com>, Marcin Nowakowski <marcin.nowakowski@mips.com>, Matthew Fortune <Matthew.Fortune@mips.com>
List-Id: linux-arch.vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 06:40:07PM -0400, Arnd Bergmann wrote:
> On Wed, May 2, 2018 at 5:51 PM, James Hogan <jhogan@kernel.org> wrote:
>=20
> > Due to the binary incompatibility between previous MIPS architecture
> > generations and nanoMIPS, and the significantly revamped compiler ABI,
> > where for the first time, a single Linux kernel would not be expected to
> > handle both old and new ABIs, we have decided to also take the
> > opportunity to modernise the Linux user ABI for nanoMIPS, making as much
> > use of generic interfaces as possible and modernising the true
> > architecture specific parts.
> >
> > This is similar to what a whole new kernel architecture would be
> > expected to adopt, but has been done within the existing MIPS
> > architecture port to allow reuse of the existing MIPS code, most of
> > which does not depend on these ABI specifics. Details of the proposed
> > Linux user ABI changes for nanoMIPS can be found here:
>=20
> While I haven't looked at the individual changes, I wonder whether
> it would be useful to make this new ABI use 64-bit time_t from
> the start, using the new system calls that Deepa and I have been
> posting recently.

Personally I'm all for squeezing as much API cleanup in as possible
before its merged, though obviously there'll be a point when the ABI may
need to be frozen, at which point we'll mostly have to accept what we
have within reason.

> There are still a few things to be worked out:
> only the first of four sets of syscall patches is merged so far,
> and we have a couple of areas that will require further ABI changes
> (sound, sockets, media and maybe a couple of smaller drivers),
> so it depends on the overall timing. If you would otherwise merge
> the patches quickly, then it may be better to just follow the existing
> 32-bit architectures and add the 64-bit entry points when we do it
> for everyone.

I think it'll likely be a couple of cycles before it gets merged anyway.
There's still work to do, and limited resources.

Cheers
James

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWuxfDgAKCRA1zuSGKxAj
8gFKAQDBKIiLApOFjRYGPadIj0pTPL6FcfLozP0XuoIjjwlKdAEAguVMty7TjYS0
+MKImps2UKe+xTw3YLPtnZlk+cVTpQ0=
=7SKV
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
