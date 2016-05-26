Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:22226 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754095AbcEZOuN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 May 2016 10:50:13 -0400
Message-ID: <57470D19.2000501@arm.com>
Date: Thu, 26 May 2016 15:50:01 +0100
From: Szabolcs Nagy <szabolcs.nagy@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 01/23] all: syscall wrappers: add documentation
References: <6293194.tGy03QJ9ME@wuerfel> <20160525.135039.244098606649448826.davem@davemloft.net> <6407614.fdv5XFSBue@wuerfel> <20160525.142821.1719403997976778673.davem@davemloft.net> <20160526142057.GA7456@e104818-lin.cambridge.arm.com>
In-Reply-To: <20160526142057.GA7456@e104818-lin.cambridge.arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, David Miller <davem@davemloft.net>
Cc: nd@arm.com, arnd@arndb.de, ynorov@caviumnetworks.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
Message-ID: <20160526145001.1vvsyycjc42jZE8LQXpURGhMKQAPZN3TV-cuyTbgM40@z>

On 26/05/16 15:20, Catalin Marinas wrote:
> While writing the above, I realised the current ILP32 patches still miss
> on converting pointers passed from user space (unless I got myself
> confused in macros). The new __SC_WRAP() and COMPAT_SYSCALL_WRAPx()
> macros take care of zero or sign extension via __SC_COMPAT_CAST().
> However, we have two more existing cases which I don't see covered:
> 
> a) Native syscalls taking a pointer argument and invoked directly from
>    ILP32. For example, sys_read() takes a pointer but I don't see any
>    __SC_WRAP added by patch 5
> 
> b) Current compat syscalls taking a pointer argument. For example,
>    compat_sys_vmsplice() gets the iov32 pointer and the compiler assumes
>    it is a 64-bit variable. I don't see where the upper half is zeroed
> 

on x32 sign/zero extension is currently left to userspace,
which is difficult to deal with, (long long)arg does the
wrong thing for pointer args.

> We can solve (a) by adding more __SC_WRAP annotations in the generic
> unistd.h. For (b), we would need an __SC_DELOUSE with a bit of penalty
> on AArch32/compat support where it isn't needed. So maybe davem has a
> point on the overall impact of always zeroing the upper half of the
> arguments ;) (both from a performance and maintainability perspective).
> I guess this part of the ABI is still up for discussion.
> 

