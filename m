From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH 0/2] microblaze: Unify the system call scripts
Date: Thu, 3 Jan 2019 13:29:58 +0100
Message-ID: <86b91768-2a3d-eb58-c9a5-641be473f301@monstr.eu>
References: <1546441924-20262-1-git-send-email-firoz.khan@linaro.org>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8n8VULyadcUqxx3MDfw2fsoYW4RGNnHgo"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546441924-20262-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8n8VULyadcUqxx3MDfw2fsoYW4RGNnHgo
Content-Type: multipart/mixed; boundary="hSIc05f9hS763wqpGzHgxqU4y0Zd3R2dY";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Firoz Khan <firoz.khan@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
 marcin.juszkiewicz@linaro.org
Message-ID: <86b91768-2a3d-eb58-c9a5-641be473f301@monstr.eu>
Subject: Re: [PATCH 0/2] microblaze: Unify the system call scripts
References: <1546441924-20262-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1546441924-20262-1-git-send-email-firoz.khan@linaro.org>

--hSIc05f9hS763wqpGzHgxqU4y0Zd3R2dY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02. 01. 19 16:12, Firoz Khan wrote:
> System call table generation support is provided for
> alpha, ia64, m68k, microblaze, mips, parisc, powerpc,
> sh, sparc and xtensa architectures. The implementat-
> ions are almost similar across all the above archte-
> ctures. In order to reduce the source code across all
> the above architectures, create common ".sh" files and
> keep it in the common directory, script/. This will=20
> be a generic scripts which can use for all the above
> architectures.
>=20
> This patch depends on;
>  https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.k=
han@linaro.org/
>=20
> Firoz Khan (2):
>   microblaze: remove nargs from __SYSCALL
>   microblaze: generate uapi header and system call table files
>=20
>  arch/microblaze/kernel/syscall_table.S        |  2 +-
>  arch/microblaze/kernel/syscalls/Makefile      | 11 ++++++--
>  arch/microblaze/kernel/syscalls/syscallhdr.sh | 36 -------------------=
--------
>  arch/microblaze/kernel/syscalls/syscalltbl.sh | 32 -------------------=
-----
>  4 files changed, 10 insertions(+), 71 deletions(-)
>  delete mode 100644 arch/microblaze/kernel/syscalls/syscallhdr.sh
>  delete mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh
>=20

Looks good. Will keep this in my queue till depending patch is applied.

M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--hSIc05f9hS763wqpGzHgxqU4y0Zd3R2dY--

--8n8VULyadcUqxx3MDfw2fsoYW4RGNnHgo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlwuAEYACgkQykllyylKDCGkpQCeJuPtXudWSjQ5SC3PovSg16fv
u6oAoJD6DVXLGJD6NwsObKbBpiyhbxKs
=tV6x
-----END PGP SIGNATURE-----

--8n8VULyadcUqxx3MDfw2fsoYW4RGNnHgo--
