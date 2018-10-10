Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbeJJW7s (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Oct 2018 18:59:48 -0400
Date: Wed, 10 Oct 2018 16:36:56 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
Message-ID: <20181010153655.GA212880@arrakis.emea.arm.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180724173957.GA22106@yury-thinkpad>
 <20181010141017.GA2881@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010141017.GA2881@asgard.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eugene Syromiatnikov <esyr@redhat.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Adam Borowski <kilobyte@angband.pl>, Alexander Graf <agraf@suse.de>, Alexey Klimov <klimov.linux@gmail.com>, Andreas Schwab <schwab@suse.de>, Andrew Pinski <pinskia@gmail.com>, Bamvor Zhangjian <bamv2005@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Christoph Muellner <christoph.muellner@theobroma-systems.com>, Dave Martin <Dave.Martin@arm.com>, "David S . Miller" <davem@davemloft.net>, Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, James Hogan <james.hogan@imgtec.com>, James Morse <james.morse@arm.com>, Joseph Myers <joseph@codesourcery.com>, Lin Yongting <linyongting@huawei.com>, Manuel Montezelo <manuel.montezelo@gmail.com>, Mark Brown <broonie@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Nathan_Lynch <Nathan_Lynch@mentor.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, Ramana Radhakrishnan <ramana.gcc@googlemail.com>, Steve Ellcey <sellcey@caviumnetworks.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Pavel Machek <pavel@ucw.cz>, Palmer Dabbelt <palmer@sifive.com>, Wookey <wookey@wookware.org>
Message-ID: <20181010153656.YCR2dmEjA3SzPaTd3lajYtzuWuRon0LOR0u8XNK7l20@z>

On Wed, Oct 10, 2018 at 04:10:21PM +0200, Eugene Syromiatnikov wrote:
> I have some questions regarding AArch64 ILP32 implementation for which I
> failed to find an answer myself:
>  * How ptrace() tracer is supposed to distinguish between ILP32 and LP64
>    tracees? For MIPS N32 and x32 this is possible based on syscall
>    number, but for AArch64 ILP32 I do not see such a sign. There's also
>    ARM_ip is employed for signalling entering/exiting, I wonder whether
>    it's possible to employ it also for signalling tracee's personality.

With the current implementation, I don't think you can distinguish. From
the kernel perspective, the register set is the same. What is the
use-case for this?

We could add a new regset to expose the ILP32 state (NT_ARM_..., I can't
think of a name now but probably not PER* as this implies PER_LINUX_...
which is independent from TIF_32BIT_*).

>  * What's the reasoning behind capping syscall arguments to 32 bit? x32
>    and MIPS N32 do not have such a restriction (and do not need special
>    wrappers for syscalls that pass 64-bit values as a result, except
>    when they do,  as it is the case for preadv2 on x32); moreover, that
>    would lead to insurmountable difficulties for AArch64 ILP32 tracers
>    that try to trace LP64 tracees, as it would be impossible to pass
>    64-bit addresses to process_vm_{read,write} or ptrace PEEK/POKE.

We've attempted in earlier versions to allow a mix of 32 and 64-bit
register values from ILP32 but it got pretty complicated. The entry code
would need to know which registers need zeroing of the top 32-bit and
the generic unistd.h wrapper hacks were not very nice. Some past
discussions:

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1211716.html

-- 
Catalin
