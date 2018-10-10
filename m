Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:12483
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726515AbeJJWCE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Oct 2018 18:02:04 -0400
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180724173957.GA22106@yury-thinkpad>
 <20181010141017.GA2881@asgard.redhat.com>
From: Szabolcs Nagy <szabolcs.nagy@arm.com>
Message-ID: <7aac1a08-8948-1a04-cbd3-fbc6a53f9ff0@arm.com>
Date: Wed, 10 Oct 2018 15:39:07 +0100
MIME-Version: 1.0
In-Reply-To: <20181010141017.GA2881@asgard.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eugene Syromiatnikov <esyr@redhat.com>, Yury Norov <ynorov@caviumnetworks.com>
Cc: nd@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Adam Borowski <kilobyte@angband.pl>, Alexander Graf <agraf@suse.de>, Alexey Klimov <klimov.linux@gmail.com>, Andreas Schwab <schwab@suse.de>, Andrew Pinski <pinskia@gmail.com>, Bamvor Zhangjian <bamv2005@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Christoph Muellner <christoph.muellner@theobroma-systems.com>, Dave Martin <Dave.Martin@arm.com>, "David S . Miller" <davem@davemloft.net>, Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, James Hogan <james.hogan@imgtec.com>, James Morse <james.morse@arm.com>, Joseph Myers <joseph@codesourcery.com>, Lin Yongting <linyongting@huawei.com>, Manuel Montezelo <manuel.montezelo@gmail.com>, Mark Brown <broonie@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Nathan_Lynch <Nathan_Lynch@mentor.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, Ramana Radhakrishnan <ramana.gcc@googlemail.com>, Steve Ellcey <sellcey@caviumnetworks.com>, Pavel Machek <pavel@ucw.cz>, Palmer Dabbelt <palmer@sifive.com>, Wookey <wookey@wookware.org>
Message-ID: <20181010143907.U77bZ7HaSyWGNehZ9On5sXo4_RfqAe55iGwYakalZ94@z>

On 10/10/18 15:10, Eugene Syromiatnikov wrote:
>  * What's the reasoning behind capping syscall arguments to 32 bit? x32
>    and MIPS N32 do not have such a restriction (and do not need special
>    wrappers for syscalls that pass 64-bit values as a result, except
>    when they do,  as it is the case for preadv2 on x32); moreover, that
>    would lead to insurmountable difficulties for AArch64 ILP32 tracers
>    that try to trace LP64 tracees, as it would be impossible to pass
>    64-bit addresses to process_vm_{read,write} or ptrace PEEK/POKE.

but that's necessarily the case for all ilp32 abis:
the userspace syscall function receives 32bit
arguments so even if the kernel abi takes 64bit
args you cannot use that from c code. (the libc
does not even know which args should be sign or
zero extended.)

process_vm_readv/writev is limited by the ilp32
iovec struct, not by the syscall arguments.

ptrace is specified to take void* addr argument,
and void* is 32bit on all ilp32 targets.
so again on the c language level there is no
way around the 32bit limitation.
