Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32778 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbeJMQ4n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 13 Oct 2018 12:56:43 -0400
Date: Sat, 13 Oct 2018 10:20:09 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
Message-ID: <20181013092009.gzxorufk4tqrzked@mbp>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180724173957.GA22106@yury-thinkpad>
 <20181010141017.GA2881@asgard.redhat.com>
 <7aac1a08-8948-1a04-cbd3-fbc6a53f9ff0@arm.com>
 <20181013020731.GD21972@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013020731.GD21972@asgard.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eugene Syromiatnikov <esyr@redhat.com>
Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>, linux-doc@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yury Norov <ynorov@caviumnetworks.com>, Pavel Machek <pavel@ucw.cz>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Joseph Myers <joseph@codesourcery.com>, linux-arch@vger.kernel.org, Steve Ellcey <sellcey@caviumnetworks.com>, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, Andreas Schwab <schwab@suse.de>, Alexander Graf <agraf@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Bamvor Zhangjian <bamv2005@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Adam Borowski <kilobyte@angband.pl>, Manuel Montezelo <manuel.montezelo@gmail.com>, James Hogan <james.hogan@imgtec.com>, Chris Metcalf <cmetcalf@mellanox.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Pinski <pinskia@gmail.com>, Lin Yongting <linyongting@huawei.com>, Alexey Klimov <klimov.linux@gmail.com>, Wookey <wookey@wookware.org>, Mark Brown <broonie@kernel.org>, nd@arm.com, linux-arm-kernel@lists.infradead.org, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Florian Weimer <fweimer@redhat.com>, linux-api@vger.kernel.org, Nathan_Lynch <Nathan_Lynch@mentor.com>, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>, Ramana Radhakrishnan <ramana.gcc@googlemail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "David S . Miller" <davem@davemloft.net>, Christoph Muellner <christoph.muellner@theobroma-systems.com>
Message-ID: <20181013092009.zPYhO3Htt2UjSUeO0vH6lgE8MdciJ4WxZ8r9hc9s5S0@z>

On Sat, Oct 13, 2018 at 04:07:31AM +0200, Eugene Syromiatnikov wrote:
> On Wed, Oct 10, 2018 at 03:39:07PM +0100, Szabolcs Nagy wrote:
> > On 10/10/18 15:10, Eugene Syromiatnikov wrote:
> > >  * What's the reasoning behind capping syscall arguments to 32 bit? x32
> > >    and MIPS N32 do not have such a restriction (and do not need special
> > >    wrappers for syscalls that pass 64-bit values as a result, except
> > >    when they do,  as it is the case for preadv2 on x32); moreover, that
> > >    would lead to insurmountable difficulties for AArch64 ILP32 tracers
> > >    that try to trace LP64 tracees, as it would be impossible to pass
> > >    64-bit addresses to process_vm_{read,write} or ptrace PEEK/POKE.
> > 
> > but that's necessarily the case for all ilp32 abis:
> > the userspace syscall function receives 32bit
> > arguments so even if the kernel abi takes 64bit
> > args you cannot use that from c code. (the libc
> > does not even know which args should be sign or
> > zero extended.)
> 
> glibc's syscall() prototype has kernel_ulong_t as its arguments (more
> specifically, to __syscall_ulong_t, which is 64-bit wide on x32; it
> should also have kernel_long_t as its return type instead of long,
> but that's another story), so it works perfectly fine in case of x32.

This would have been my preferred approach but the libc community were
not entirely happy with it as it breaks POSIX compatibility:

https://sourceware.org/bugzilla/show_bug.cgi?id=16437
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/323348.html

(there are other threads around x32 and people arguing whether POSIX is
wrong)

Some sometime around version 4 or 5 of this series, we made the move
(back) to compat-like ABI.

-- 
Catalin
