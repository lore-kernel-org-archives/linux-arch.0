From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Question] New mmap64 syscall?
Date: Thu, 12 Jan 2017 22:51:28 +0100
Message-ID: <20170112215128.GA14063@amd>
References: <20161206185440.GA4654@yury-N73SV>
 <f544bcc3-8aae-1bd0-b744-9964fc038a51@redhat.com>
 <20161207154811.GA15248@yury-N73SV>
 <14981df2-b120-17c3-a5a8-5cbbd2008c4f@redhat.com>
 <20170103205437.GA22548@amd>
 <59af3a6f-f30c-46a5-2d0b-6a7e36668e6b@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <59af3a6f-f30c-46a5-2d0b-6a7e36668e6b@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Weimer <fweimer@redhat.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>, libc-alpha@sourceware.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, arnd@arndb.de, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, linux-arm-kernel@lists.infradead.org, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2017-01-12 17:13:25, Florian Weimer wrote:
> On 01/03/2017 09:54 PM, Pavel Machek wrote:
> >...actually, with strace and batched interface, it will be impossible
> >to see what is going on because of races. So I'm not sure if I like
> >the batched interface at all...
>=20
> I'm not sure if I understand this problem.
>=20
> ioctl, fcntl, most socket system calls, even open all have this problem as
> well, right?

Yes, ioctl() and similar are problematic. Still it is possible to
implement secure sandbox using ptrace. Dealing with indirect mmap()
would difficult AFAICT.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlh3+mAACgkQMOfwapXb+vIszACcDtFQSncK+zwKbpRpvasbFveQ
WzsAnRvgUbvC3W+fWhGptatInEx+Effa
=E+7f
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
