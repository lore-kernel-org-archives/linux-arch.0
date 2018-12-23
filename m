From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v5 0/7] mips: system call table generation support
Date: Sun, 23 Dec 2018 16:15:54 +0000
Message-ID: <MWHPR2201MB1277088F42DB7C2850037098C1BA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <1544692059-9728-1-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544692059-9728-1-git-send-email-firoz.khan@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Cc: "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <pburton@wavecomp.com>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, "y2038@lists.linaro.org" <y2038@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>, "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>, "firoz.khan@linaro.org" <firoz.khan@linaro.org>"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hello,

Firoz Khan wrote:
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
> itecture will be possible by adding new entry in
> the syscall.tbl file.
>=20
> Adding a new table entry consisting of:
> - System call number.
> - ABI.
> - System call name.
> - Entry point name.
> - Compat entry name, if required.
>=20
> ARM, s390 and x86 architecuture does exist the sim-
> ilar support. I leverage their implementation to
> come up with a generic solution.
>=20
> I have done the same support for work for alpha,
> ia64, m68k, microblaze, parisc, powerpc, sh, sparc,
> and xtensa. Below mentioned git repository contains
> more details about the workflow.
>=20
> https://github.com/frzkhn/system_call_table_generator/
>=20
> Finally, this is the ground work to solve the Y2038
> issue. We need to add two dozen of system calls to
> solve Y2038 issue. So this patch series will help to
> add new system calls easily by adding new entry in
> the syscall.tbl.
>=20
> Changes since v4:
> - _MIPS_SIM_ABIN64 (suppose to be _MIPS_SIM_NABI64)
> macro rename back to _MIPS_SIM_ABI64 to avoid
> toolchain issue.
>=20
> Changes since v3:
> - rearranged the patches for '64' to 'n64' conver-
> sion.
> - moved the unistd_nr_*.h files to asm/unistd.h
> - modified the *.sh files.
>=20
> Changes since v2:
> - fixed __NR_syscalls assign issue.
>=20
> Changes since v1:
> - optimized/updated the syscall table generation
> scripts.
> - fixed all mixed indentation issues in syscall.tbl.
> - added "comments" in syscall_*.tbl.
> - changed from generic-y to generated-y in Kbuild.
>=20
> Firoz Khan (7):
> mips: add __NR_syscalls along with __NR_Linux_syscalls
> mips: remove unused macros
> mips: rename macros and files from '64' to 'n64'
> mips: add +1 to __NR_syscalls in uapi header
> mips: remove syscall table entries
> mips: add system call table generation support
> mips: generate uapi header and system call table files
>=20
> arch/mips/Makefile                        |    3 +
> arch/mips/include/asm/Kbuild              |    4 +
> arch/mips/include/asm/unistd.h            |   11 +-
> arch/mips/include/uapi/asm/Kbuild         |    6 +
> arch/mips/include/uapi/asm/unistd.h       | 1074 +-----------------------=
-----
> arch/mips/kernel/Makefile                 |    2 +-
> arch/mips/kernel/ftrace.c                 |    8 +-
> arch/mips/kernel/scall32-o32.S            |  391 +----------
> arch/mips/kernel/scall64-64.S             |  444 ------------
> arch/mips/kernel/scall64-n32.S            |  341 +--------
> arch/mips/kernel/scall64-n64.S            |  117 ++++
> arch/mips/kernel/scall64-o32.S            |  379 +---------
> arch/mips/kernel/syscalls/Makefile        |   96 +++
> arch/mips/kernel/syscalls/syscall_n32.tbl |  343 +++++++++
> arch/mips/kernel/syscalls/syscall_n64.tbl |  339 +++++++++
> arch/mips/kernel/syscalls/syscall_o32.tbl |  382 ++++++++++
> arch/mips/kernel/syscalls/syscallhdr.sh   |   37 +
> arch/mips/kernel/syscalls/syscallnr.sh    |   28 +
> arch/mips/kernel/syscalls/syscalltbl.sh   |   36 +
> 19 files changed, 1427 insertions(+), 2614 deletions(-)
> delete mode 100644 arch/mips/kernel/scall64-64.S
> create mode 100644 arch/mips/kernel/scall64-n64.S
> create mode 100644 arch/mips/kernel/syscalls/Makefile
> create mode 100644 arch/mips/kernel/syscalls/syscall_n32.tbl
> create mode 100644 arch/mips/kernel/syscalls/syscall_n64.tbl
> create mode 100644 arch/mips/kernel/syscalls/syscall_o32.tbl
> create mode 100644 arch/mips/kernel/syscalls/syscallhdr.sh
> create mode 100644 arch/mips/kernel/syscalls/syscallnr.sh
> create mode 100644 arch/mips/kernel/syscalls/syscalltbl.sh

Series applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
