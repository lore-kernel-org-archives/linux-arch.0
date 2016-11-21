From: Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: Bug#844530: [1/2] kbuild: provide include/asm/asm-prototypes.h for ARM
Date: Mon, 21 Nov 2016 19:46:44 +0100
Message-ID: <20161121184640.gtzvu4pfwy2p5rcb@perseus.defre.kleine-koenig.org>
References: <14534456.e6dv16VA3R@wuerfel>
Reply-To: Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 844530@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lti2qvupxj3yw5xx"
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.844530.B844530.147975401129667@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <14534456.e6dv16VA3R@wuerfel>
List-URL: <https://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nicholas Piggin <npiggin@gmail.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 844530@bugs.debian.org
List-Id: linux-arch.vger.kernel.org


--lti2qvupxj3yw5xx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Oct 24, 2016 at 05:05:26PM +0200, Arnd Bergmann wrote:
> This adds an asm/asm-prototypes.h header for ARM to fix the
> broken symbol versioning for symbols exported from assembler
> files.
>=20
> In addition to the header, we have to do these other small
> changes:
>=20
> - move the exports from bitops.h to {change,clear,set,...}bit.S
> - move the exports from csumpartialgeneric.S into the files
>   including it
>=20
> I couldn't find the correct prototypes for the compiler builtins,
> so I went with the fake 'void f(void)' prototypes that we had
> before.
>=20
> This leaves the mmioset/mmiocpy function for now, as it's not
> obvious how to best handle them.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

In my test builds of 4.9-rc5 plus

	4efca4ed05cb ("kbuild: modversions for EXPORT_SYMBOL() for asm")
	cc6acc11cad1 ("kbuild: be more careful about matching preprocessed asm ___=
EXPORT_SYMBOL")

(which are in -rc6) I got many warnings =E0 la:

	WARNING: "memset" [drivers/media/usb/airspy/airspy.ko] has no CRC!

and booting the resulting kernel failed with messages of the type:

	[    3.024126] usbcore: no symbol version for __memzero
	[    3.029107] usbcore: Unknown symbol __memzero (err -22)

so hardly any module could be loaded. modprobe -f works however, but
that's not what my initramfs does.

With this patch and https://patchwork.kernel.org/patch/9392291/ ("ARM:
move mmiocpy/mmioset exports to io.c") I could compile a kernel without
CRC warnings and it boots fine. So it would be great to get these two
patches into 4.9.

Thanks
Uwe

--lti2qvupxj3yw5xx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCgAGBQJYM0ENAAoJEMH8FHityuwJguMH/jNONORjAiyzMn2M5Zkkva9l
A3VfV4SruLIv1i9lxjtlxYY6iPu2gEQLjaUAX7gCXxIPYaYCukbzCxyhpfVEaVbV
cSs02jMGs/aeZ0sjaranOu98t14V2G5jlejL8i4L1SohqAAgM1dXttOeNqasZHUG
yoNTDfHW20RONuOW3Yc3u+EjnmhRqT79QN9pzLK7G5f0U/IuwFESudXCKRcwxf9q
w+Hjo3Spae0hYhzvr30iQg8VaZV8aYEVgOHZQ8n8CXQ05hHACGzkIP757TyCmCTK
kcNTPbRhs4pQNt9abeoyJBvbHlw23sa0+hreyOloFIYP8jkOGwX2khe/XEyxGok=
=yUkK
-----END PGP SIGNATURE-----

--lti2qvupxj3yw5xx--
