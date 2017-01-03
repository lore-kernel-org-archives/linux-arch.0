From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Question] New mmap64 syscall?
Date: Tue, 3 Jan 2017 21:54:37 +0100
Message-ID: <20170103205437.GA22548@amd>
References: <20161206185440.GA4654@yury-N73SV>
 <f544bcc3-8aae-1bd0-b744-9964fc038a51@redhat.com>
 <20161207154811.GA15248@yury-N73SV>
 <14981df2-b120-17c3-a5a8-5cbbd2008c4f@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6591079239715349181=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <14981df2-b120-17c3-a5a8-5cbbd2008c4f@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Florian Weimer <fweimer@redhat.com>
Cc: szabolcs.nagy@arm.com, Catalin Marinas <catalin.marinas@arm.com>, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, Yury Norov <ynorov@caviumnetworks.com>, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, linux-arch@vger.kernel.org, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, arnd@arndb.de, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, linux-arm-kernel@lists.infradead.org, maxim.kuvyrkov@linaro.org, libc-alpha@sourceware.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org


--===============6591079239715349181==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline


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


--===============6591079239715349181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6591079239715349181==--
