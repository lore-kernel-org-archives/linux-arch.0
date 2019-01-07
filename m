Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:33616 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726873AbfAGPvm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jan 2019 10:51:42 -0500
From: Yuri Norov <ynorov@marvell.com>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
Date: Mon, 7 Jan 2019 15:50:36 +0000
Message-ID: <20190107155028.GA25178@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <36151C2011E12D4E9564E8B1F9DBC757@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yuri Norov <ynorov@marvell.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Adam Borowski <kilobyte@angband.pl>, Alexander Graf <agraf@suse.de>, Alexey Klimov <klimov.linux@gmail.com>, Andreas Schwab <schwab@suse.de>, Andrew Pinski <pinskia@gmail.com>, Bamvor Zhangjian <bamv2005@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Christoph Muellner <christoph.muellner@theobroma-systems.com>, Dave Martin <Dave.Martin@arm.com>, "David S . Miller" <davem@davemloft.net>, Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, James Hogan <james.hogan@imgtec.com>, James Morse <james.morse@arm.com>, Joseph Myers <joseph@codesourcery.com>, Lin Yongting <linyongting@huawei.com>, Manuel Montezelo <manuel.montezelo@gmail.com>, Mark Brown <broonie@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Nathan_Lynch <Nathan_Lynch@mentor.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, Ramana Radhakrishnan <ramana.gcc@googlemail.com>, Steve Ellcey <sellcey@caviumnetworks.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "yury.norov@gmail.com" <yury.norov@gmail.com>
Message-ID: <20190107155036.cJXyPWjXI2K9AJVbqQML6b4DNjQVm1RCiaahF8PR3_g@z>

Hi all,

On Wed, May 16, 2018 at 11:18:45AM +0300, Yury Norov wrote:
> This series enables AARCH64 with ILP32 mode.
>=20
> As supporting work, it introduces ARCH_32BIT_OFF_T configuration
> option that is enabled for existing 32-bit architectures but disabled
> for new arches (so 64-bit off_t userspace type is used by new userspace).
> Also it deprecates getrlimit and setrlimit syscalls prior to prlimit64.
>=20
> Based on kernel v4.16. Tested with LTP, glibc testsuite, trinity, lmbench=
,
> CPUSpec.
>=20
> This series on github:=20
> https://github.com/norov/linux/tree/ilp32-4.16
> Linaro toolchain:
> http://snapshots.linaro.org/components/toolchain/binaries/7.3-2018.04-rc1=
/aarch64-linux-gnu_ilp32/
> Debian repo:
> http://people.linaro.org/~wookey/ilp32/
> OpenSUSE repo:
> https://build.opensuse.org/project/show/devel:ARM:Factory:Contrib:ILP32
>=20
> Changes:
> v3: https://lkml.org/lkml/2014/9/3/704
> v4: https://lkml.org/lkml/2015/4/13/691
> v5: https://lkml.org/lkml/2015/9/29/911
> v6: https://lkml.org/lkml/2016/5/23/661
> v7: https://lkml.org/lkml/2017/1/9/213
> v8: https://lkml.org/lkml/2017/6/19/624
> v9: - rebased on top of v4.16;
>     - signal subsystem reworked to avoid code duplication, as requested
>       by Dave Martin (patches 18 and 20);
>     - new files introduced in series use SPDX notation for license;
>     - linux-api and linux-arch CCed as the series changes kernel ABI;
>     - checkpatch and other minor fixes.
>     - Zhou Chengming's reported-by for patch 2 and signed-off-by for
>       patch 21 removed because his email became invalid. Zhou, please
>       share your new email.

This is 4.20-based version.
https://github.com/norov/linux/tree/ilp32-4.20

There's no important changes comparing to 4.19, but I would like to remind
that this series contains some generic arch patches that ACKed, but still
not upstreamed:
Yury Norov      asm-generic: Drop getrlimit and setrlimit syscalls from def=
ault list
Yury Norov      32-bit userspace ABI: introduce ARCH_32BIT_OFF_T config opt=
ion
Yury Norov      compat ABI: use non-compat openat and open_by_handle_at var=
iants
James Morse     ptrace: Add compat PTRACE_{G,S}ETSIGMASK handlers
Dave Martin     arm64: signal: Make parse_user_sigframe() independent of rt=
_sigframe layout

Please also notice that my email address is changed, from now it's
ynorov@marvell.com

Yury
