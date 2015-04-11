From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Remove execution domain support
Date: Sun, 12 Apr 2015 09:30:01 +1000
Message-ID: <20150412093001.0b6f8539@canb.auug.org.au>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
	<CA+55aFyXWGUYg7W5xZzh-3BT+NuCib-s5t_Ho3YTh3+QK26jSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nAgvCPoMT4i/VKwuQ22ds2d"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFyXWGUYg7W5xZzh-3BT+NuCib-s5t_Ho3YTh3+QK26jSA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Richard Weinberger <richard@nod.at>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, hskinnemoen@gmail.com, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Miao Steven <realmz6@gmail.com>, Mark Salter <msalter@redhat.com>, "JACQUIOT-XID, Aurelien" <a-jacquiot@ti.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, David Howells <dhowells@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-arch.vger.kernel.org

--Sig_/nAgvCPoMT4i/VKwuQ22ds2d
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Sat, 11 Apr 2015 13:52:21 -0700 Linus Torvalds <torvalds@linux-foundatio=
n.org> wrote:
>
> On Sat, Apr 11, 2015 at 1:47 PM, Richard Weinberger <richard@nod.at> wrot=
e:
> >
> > The removal will make architecutre specific signal handling easier
> > and there is no need to keep execuction domains as this feature is
> > obviously incomplete and abandoned
>=20
> Ack. The whole exec domain made some code code pretty inscrutable.
>=20
> So I'd certainly be willing to pull this during the 4.1 merge window
> if nobody complains.
>=20
> Anybody?

How about we put it in linux-next for a day or two before it gets
pulled into your tree just to shake out any obvious compile/conflict
problems?

/me volunteers for more late nights :-(
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/nAgvCPoMT4i/VKwuQ22ds2d
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVKa5/AAoJEMDTa8Ir7ZwVix0P/Rhaodrt3jtDjAB1VTGrYwg7
EDyrP6l+n5R95wV1qn0gTeNlsRfPssm/a2jzDrbHY0BumLG/yei8RujYJ9/zxsec
dXe9tWDpTPq9ol6GKGIf2PU3hmh4cjV46axYz34LHctdMl1964t9awAe+yrcI/k6
hmQGs3g4jysixoTSwa253zKfyToOoEkdmRhFo8R1VElh4ZXSjw6ArbUtOiWqZ6jv
DEPtpicvbBcylC7gWXtnMKk0Qpz+Hv3clQx3Ew7OIvNO53JsCx8DKSJO3jPU2wwu
htpV7IFadt02WInMp1/iKBPJF5E+pKyYbcBElDG6+gY2dxcLk42fl3ByAM3XBMQK
TjT0dlFw0qSE2zuwtc+LfU/OZLaA1TbA2x5dIY0AURTcWiJgGDoxxyF4jEj0e9w7
2u7dF+JJeaFaq/CkUIjBFlspTKaBLlF6jATfkfZ591PAnzqwOcKQ+1KPDiknQglX
Om4ElK1FupdX/tUA3erbPdVouDR6ho8c8DI+89rAMRUEcOsRAQoEphxwuormcUtX
X1xOKAS2f2ZQSIV+M6Y55xIkEdoo3caS5yQZaiyKDiv69q/tCDk2zWm9JnWKp9FU
GMASgmeCldMTy1lzLBbMrQ1qZ3f30ufSNhEy++GZ7X5dBotsXcVCL6gQ0afBMVJ4
RWlV0rD5RqY8vXPAcdto
=eFfM
-----END PGP SIGNATURE-----

--Sig_/nAgvCPoMT4i/VKwuQ22ds2d--
