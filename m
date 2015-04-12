From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Remove execution domain support
Date: Sun, 12 Apr 2015 10:06:10 +1000
Message-ID: <20150412100610.3fa76da6@canb.auug.org.au>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
	<CA+55aFyXWGUYg7W5xZzh-3BT+NuCib-s5t_Ho3YTh3+QK26jSA@mail.gmail.com>
	<20150412093001.0b6f8539@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GXEbuokEq.wDNDn9+M+wQU0"; protocol="application/pgp-signature"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:44317 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753290AbbDLAGY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 11 Apr 2015 20:06:24 -0400
In-Reply-To: <20150412093001.0b6f8539@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, hskinnemoen@gmail.com, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Miao Steven <realmz6@gmail.com>, Mark Salter <msalter@redhat.com>, "JACQUIOT-XID, Aurelien" <a-jacquiot@ti.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, David Howells <dhowells@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux>

--Sig_/GXEbuokEq.wDNDn9+M+wQU0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Sun, 12 Apr 2015 09:30:01 +1000 Stephen Rothwell
<sfr@canb.auug.org.au> wrote:
>
> How about we put it in linux-next for a day or two before it gets
> pulled into your tree just to shake out any obvious compile/conflict
> problems?

For example, this new warning in the arm multi_v7_defconfig build (I
did a test merge on top of the latest linux-next and some simple
builds):

arch/arm/kernel/traps.c: In function 'bad_syscall':
arch/arm/kernel/traps.c:508:22: warning: unused variable 'thread' [-Wunused=
-variable]
  struct thread_info *thread =3D current_thread_info();
                      ^

The merge produced no conflicts needing manual resolution.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/GXEbuokEq.wDNDn9+M+wQU0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVKbb8AAoJEMDTa8Ir7ZwV7g0QAIDWvdmacnPTWXxSbN1L3qvO
gHBXOzf6QdxyihCWf9DvAE+nvfDPvggeufknE36kZXu2w8dIBvIDlZBZfEf/A+hY
G5TvIZwXf1x4lZ8Ls/Xfw7QjBAn0zgMpR3hkmJPMXedVkkcsO5MGkrvo/0NkcO/B
G0K6pQx0tscWftI9w79MuAsnaXj1g7Gbly21EzKUDzk/GR6B5AV0oVVEOVZAnc9x
fRlPuJYTHWwnbffF7gCD94w+LYY18g/pZPhDP+rd7O9R67XIvE059SwoSLQpax0X
TDZI5FqqhbwPOIcwdsWyp1mFSojYxPmmFkqXeqiVvQV2PzLoj+rsSMWrskxGGdt/
9oRiE2DCs4rgAxqqD0VjN5GmDRUhJycS1e7QbADtsB/G4znCY53sytFKrnS1NSh+
KuJx/IQ4brsllWjg3Hd/cZmXmzMxLfkVy26eV9HL2xI7ut0WLrRveEb5Zs/jvzrH
R1P8VwgYWl6KXM6uXmiEZLG/FECHsLiyOBeAq9CzTOG8Llv6Ichq4OcE4ZGLPcCL
K7DVkhMxHde3AqtNZIYU1AZjqlJWCssq0gsPIZnzmFxiDI7SzimjsfLQrOfCil1e
7Z/mTX2UH3lZkTqSVstdxaIta5cbNs8fAeuYKNsDs3L4Dp2Za6bE79GCvKxDrgCY
1jBFNCuTQTOirtJz9iDN
=NiC3
-----END PGP SIGNATURE-----

--Sig_/GXEbuokEq.wDNDn9+M+wQU0--
