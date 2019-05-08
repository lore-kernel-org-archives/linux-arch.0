Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40287 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHXKp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 May 2019 19:10:45 -0400
Date: Wed, 8 May 2019 16:10:35 -0700
From: Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
Message-ID: <20190508231035.GB14091@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20190508225900.GA14091@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508225900.GA14091@yury-thinkpad>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Adam Borowski <kilobyte@angband.pl>, Alexander Graf <agraf@suse.de>, Alexey Klimov <klimov.linux@gmail.com>, Andreas Schwab <schwab@suse.de>, Andrew Pinski <pinskia@gmail.com>, Bamvor Zhangjian <bamv2005@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Christoph Muellner <christoph.muellner@theobroma-systems.com>, Dave Martin <Dave.Martin@arm.com>, "David S . Miller" <davem@davemloft.net>, Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, James Hogan <james.hogan@imgtec.com>, James Morse <james.morse@arm.com>, Joseph Myers <joseph@codesourcery.com>, Lin Yongting <linyongting@huawei.com>, Manuel Montezelo <manuel.montezelo@gmail.com>, Mark Brown <broonie@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Nathan_Lynch <Nathan_Lynch@mentor.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, Ramana Radhakrishnan <ramana.gcc@googlemail.com>, Steve Ellcey <sellcey@caviumnetworks.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>
Message-ID: <20190508231035.LeaNYITnOScd0kmPYiaLUo7Bx6bDRfJp308zg4Jcisk@z>

On Wed, May 08, 2019 at 03:59:00PM -0700, Yury Norov wrote:
> Hi all,
> 
> On Wed, May 16, 2018 at 11:18:45AM +0300, Yury Norov wrote:
> > This series enables AARCH64 with ILP32 mode.
> > 
> > As supporting work, it introduces ARCH_32BIT_OFF_T configuration
> > option that is enabled for existing 32-bit architectures but disabled
> > for new arches (so 64-bit off_t userspace type is used by new userspace).
> > Also it deprecates getrlimit and setrlimit syscalls prior to prlimit64.
> > 
> > Based on kernel v4.16. Tested with LTP, glibc testsuite, trinity, lmbench,
> > CPUSpec.
> > 
> > This series on github: 
> > https://github.com/norov/linux/tree/ilp32-4.16
> > Linaro toolchain:
> > http://snapshots.linaro.org/components/toolchain/binaries/7.3-2018.04-rc1/aarch64-linux-gnu_ilp32/
> > Debian repo:
> > http://people.linaro.org/~wookey/ilp32/
> > OpenSUSE repo:
> > https://build.opensuse.org/project/show/devel:ARM:Factory:Contrib:ILP32
> 
> This is the 5.1-based version.
> Changes comparing to 5.0:
>  - drop arch patches that has been taken upstream:
>    80d7da1cac62 asm-generic: Drop getrlimit and setrlimit syscalls from default list
>    942fa985e9f1 32-bit userspace ABI: introduce ARCH_32BIT_OFF_T config option
>    0d0216c03a7a compat ABI: use non-compat openat and open_by_handle_at variants
>  - in include/linux/thread_bits.h define current_thread_info() prior to
>    inclusion of asm/thread_info.h, to avoid circullar dependencies (thread: move
>    thread bits accessors to separated file);
>  - enable old IPC interfaces for ilp32, according to mainline changes
>    (arm64: ilp32: introduce syscall table for ILP32).

Missed link:
https://github.com/norov/linux/tree/ilp32-5.1

> 
> Thanks,
> Yury
