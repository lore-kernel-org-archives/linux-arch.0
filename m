From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v4 0/3] microblaze: system call table generation support
Date: Fri, 16 Nov 2018 09:31:00 +0100
Message-ID: <632c1d3f-26cf-7e65-4e7a-cc882ef168c4@monstr.eu>
References: <1542089074-20027-1-git-send-email-firoz.khan@linaro.org>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="W0OFtpJrjHn1JGCgnYWWSnZBTKoztM5XW"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542089074-20027-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W0OFtpJrjHn1JGCgnYWWSnZBTKoztM5XW
Content-Type: multipart/mixed; boundary="Pla37rODYW6n9t799SvllDnYNa0LfYfpM";
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
Message-ID: <632c1d3f-26cf-7e65-4e7a-cc882ef168c4@monstr.eu>
Subject: Re: [PATCH v4 0/3] microblaze: system call table generation support
References: <1542089074-20027-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542089074-20027-1-git-send-email-firoz.khan@linaro.org>

--Pla37rODYW6n9t799SvllDnYNa0LfYfpM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13. 11. 18 7:04, Firoz Khan wrote:
> The purpose of this patch series is, we can easily
> add/modify/delete system call table support by cha-
> nging entry in syscall.tbl file instead of manually
> changing many files. The other goal is to unify the
> system call table generation support implementation
> across all the architectures.
>=20
> The system call tables are in different format in
> all architecture. It will be difficult to manually
> add, modify or delete the system calls in the resp-
> ective files manually. To make it easy by keeping a
> script and which'll generate uapi header file and
> syscall table file.
>=20
> syscall.tbl contains the list of available system
> calls along with system call number and correspond-
> ing entry point. Add a new system call in this arch-
> itecture will be possible by adding new entry in the
> syscall.tbl file.
>=20
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
>=20
> ARM, s390 and x86 architecuture does exist the sim-
> ilar support. I leverage their implementation to
> come up with a generic solution.
>=20
> I have done the same support for work for alpha, ia64,
> m68k, mips, parisc, powerpc, sh, sparc and xtensa.
> Below mentioned git repository contains more details
> about the workflow.
>=20
> https://github.com/frzkhn/system_call_table_generator/
>=20
> Finally, this is the ground work to solve the Y2038
> issue. We need to add two dozen of system calls to
> solve Y2038 issue. So this patch series will help to
> add new system calls easily by adding new entry in
> the syscall.tbl.
>=20
> changes since v3:
>  - changed from generic-y to generated-y in Kbuild.
>=20
> changes since v2:
>  - optimized/updated the syscall table generation
>    scripts.
>  - fixed all mixed indentation issues in syscall.tbl.
>  - added "comments" in syscall_*.tbl.
>=20
> changes since v1:
>  - enclosed __NR_sycalls macro with __KERNEL__.
>  - added missing new line.

next time please also keep this changelog in every patch.

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

Looks good now. I have queue it to next. And also asked our team to
retest everything.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--Pla37rODYW6n9t799SvllDnYNa0LfYfpM--

--W0OFtpJrjHn1JGCgnYWWSnZBTKoztM5XW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlvugEkACgkQykllyylKDCGuLACeLdJgfLbAgvM64yYaH5bB+U3u
4xcAnjD3dwMDCj1P1rF3YGv1ipQsJrSO
=0wDO
-----END PGP SIGNATURE-----

--W0OFtpJrjHn1JGCgnYWWSnZBTKoztM5XW--
