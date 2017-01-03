Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59307 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933379AbdACU47 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jan 2017 15:56:59 -0500
Date: Tue, 3 Jan 2017 21:54:37 +0100
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Question] New mmap64 syscall?
Message-ID: <20170103205437.GA22548@amd>
References: <20161206185440.GA4654@yury-N73SV>
 <f544bcc3-8aae-1bd0-b744-9964fc038a51@redhat.com>
 <20161207154811.GA15248@yury-N73SV>
 <14981df2-b120-17c3-a5a8-5cbbd2008c4f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <14981df2-b120-17c3-a5a8-5cbbd2008c4f@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>, libc-alpha@sourceware.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, arnd@arndb.de, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, linux-arm-kernel@lists.infradead.org, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
Message-ID: <20170103205437.8FwwnPRmPV_FIMKaIvkhNIcQAUZvH2NQFyLkfpAo038@z>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



> >Hi Florian,
> >
> >I frankly don't understand what you mean, All syscalls you mentioned
> >doesn't take off_t or other 64-bit arguments. 'VM changes' - virtual
> >memory? If so, I don't see any changes in VM with this approach, just
> >correct handling of big offsets.
>=20
> What I was trying to suggest is a completely different interface which is
> not subject to register size constraints and which has been requested bef=
ore
> (a mechanism for batching mm updates).

While I agree that batching might be good idea, I believe mmap64()
makes sense, too. Yes, I guess libc could do the translation, but
indirection will cost some performance, and will be problematic for
stuff such as strace.

=2E..actually, with strace and batched interface, it will be impossible
to see what is going on because of races. So I'm not sure if I like
the batched interface at all...

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlhsD40ACgkQMOfwapXb+vLeVwCfQSfrDw9+Xpkq8AnOLq/nOT3I
jL0AoJQbhRyvVJnjQ0kArd4KM5zxmlUp
=eVM/
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
