From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v3 0/3] microblaze: system call table generation support
Date: Mon, 5 Nov 2018 09:18:50 +0100
Message-ID: <7af87565-19cc-df96-fe57-b0a8fe81d9cd@monstr.eu>
References: <1540530552-3652-1-git-send-email-firoz.khan@linaro.org>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="TExgSfnQJEzmZukQQiCAHptMStTVOKVWI"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540530552-3652-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TExgSfnQJEzmZukQQiCAHptMStTVOKVWI
Content-Type: multipart/mixed; boundary="FlZnou0W2AEzHYm6OH75kAsiEjeopixzY";
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
Message-ID: <7af87565-19cc-df96-fe57-b0a8fe81d9cd@monstr.eu>
Subject: Re: [PATCH v3 0/3] microblaze: system call table generation support
References: <1540530552-3652-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1540530552-3652-1-git-send-email-firoz.khan@linaro.org>

--FlZnou0W2AEzHYm6OH75kAsiEjeopixzY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 26. 10. 18 7:09, Firoz Khan wrote:
> The purpose of this patch series is, we can easily add/modify/delete
> system call table support by changing entry in syscall.tbl file=20
> instead of manually changing many files. The other goal is to unify=20
> the system call table generation support implementation across all=20
> the architectures.=20
>=20
> The system call tables are in different format in all architecture.=20
> It will be difficult to manually add, modify or delete the system=20
> calls in the respective files manually. To make it easy by keeping
> a script and which'll generate uapi header file and syscall table=20
> file.
>=20
> syscall.tbl contains the list of available system calls along with=20
> system call number and corresponding entry point. Add a new system=20
> call in this architecture will be possible by adding new entry in=20
> the syscall.tbl file.
>=20
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
>=20
> ARM, s390 and x86 architecuture does exist the similar support. I=20
> leverage their implementation to come up with a generic solution.
>=20
> I have done the same support for work for alpha, ia64, m68k, mips,=20
> parisc, powerpc, sh, sparc, and xtensa. Below mentioned git repos-
> itory contains more details.
> Git repo:- https://github.com/frzkhn/system_call_table_generator/
>=20
> Finally, this is the ground work to solve the Y2038 issue. We need=20
> to add two dozen of system calls to solve Y2038 issue. So this patch
> series will help to add new system calls easily by adding new entry=20
> in the syscall.tbl.
>=20
> Firoz Khan (3):
>   microblaze: move __NR_syscalls macro from asm/unistd.h
>   microblaze: add system call table generation support
>   microblaze: generate uapi header and system call table files
>=20
>  arch/microblaze/Makefile                      |   3 +
>  arch/microblaze/include/asm/Kbuild            |   1 +
>  arch/microblaze/include/asm/unistd.h          |   2 -
>  arch/microblaze/include/uapi/asm/Kbuild       |   1 +
>  arch/microblaze/include/uapi/asm/unistd.h     | 407 +-----------------=
-------
>  arch/microblaze/kernel/syscall_table.S        | 406 +-----------------=
-------
>  arch/microblaze/kernel/syscalls/Makefile      |  38 +++
>  arch/microblaze/kernel/syscalls/syscall.tbl   | 410 ++++++++++++++++++=
++++++++
>  arch/microblaze/kernel/syscalls/syscallhdr.sh |  36 +++
>  arch/microblaze/kernel/syscalls/syscalltbl.sh |  32 ++
>  10 files changed, 526 insertions(+), 810 deletions(-)
>  create mode 100644 arch/microblaze/kernel/syscalls/Makefile
>  create mode 100644 arch/microblaze/kernel/syscalls/syscall.tbl
>  create mode 100644 arch/microblaze/kernel/syscalls/syscallhdr.sh
>  create mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh
>=20

where is the changelog?

Thanks,
Michal



--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--FlZnou0W2AEzHYm6OH75kAsiEjeopixzY--

--TExgSfnQJEzmZukQQiCAHptMStTVOKVWI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlvf/O4ACgkQykllyylKDCE0YwCfRKsTNOjT3vrYIlR9FC6hikXr
GMMAoJWWZZ/hbLe6fIMo8AlIlotzfpZN
=Ii+7
-----END PGP SIGNATURE-----

--TExgSfnQJEzmZukQQiCAHptMStTVOKVWI--
