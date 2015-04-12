From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Remove execution domain support v2
Date: Mon, 13 Apr 2015 07:13:12 +1000
Message-ID: <20150413071312.5279b56e@canb.auug.org.au>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
	<552ADC1D.5050206@nod.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/T7kjRjGfK26nwK9QUKrHhpd"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <552ADC1D.5050206@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, yasutake.koichi@jp.panasonic.com, lftan@altera.com, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, liqin.linux@gmail.com, lennox.wu@gmail.com, davem@davemloft.net, cmetcalf@ezchip.com, jdike@addtoit.com, akpm@linux-foundation.or
List-Id: linux-arch.vger.kernel.org

--Sig_/T7kjRjGfK26nwK9QUKrHhpd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Sun, 12 Apr 2015 22:57:01 +0200 Richard Weinberger <richard@nod.at> wrot=
e:
>
> Stephen, can you please add the tree to -next?

Added from today.  I'll remove it after Linus merges it, OK?

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/T7kjRjGfK26nwK9QUKrHhpd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVKt/tAAoJEMDTa8Ir7ZwVt+wP/0nd8oyiMX8lHvnOzQcALP7C
d0x5+PTrqRfiPku1noc2BBuhCYoxl4+vDCqAXKODMW/VfG/EvWRgELdBeTo3RcJ+
LPU+bE37VeEnSdH1BUrszFjQHr3GJ2hA1BR3sM3tqqxNQL/MyWw7CuyQxQPi1ve3
1lzU95bV9AJvx+YK4SmcnacK6xlQBZyEXsApgHDUXmVgqf4jlA7z6AKlrqu32CzR
aKSwKa2KKBdQ1dWQLztyFA5K8b5v/hLJSkl5gyW5JI7z71MIBNgubrWi0VChNaV+
7J6KnDQl0YzuOYqt21zlFwor6REhoDSmDou2aVyNVva5ocF1LTOic5vCsrBGorNF
UV2u3TlMscmGtqBqGE3LcZ0OQjjD4bdlyHburAgUDFdcgx987bvTzFDsuTPXb2Iy
ETalfwWaXqbydeRo1HyfMHjQG74garB23eN5HSfzFvB4lwSutmLLI1CYy33r6e8g
TximGQUz6giNF79LneXF9Ox8GVAcsvojSOrsJlXNHCictmdaYttw0Npi76CefoMQ
8nSME660l3+C7HTlX9ugZK/Dc/RC0aLmS2Q6ieY3q7er9JgRRINu046dre0dnr4t
SWceHLNNtkgKvxpHcoS5ElvNiUHPWKMe7iPm9m4/PAykuGbFSgMWRlwojNnHq/nN
Tq247tyQEoMJOb6ub3Rp
=gjwZ
-----END PGP SIGNATURE-----

--Sig_/T7kjRjGfK26nwK9QUKrHhpd--
