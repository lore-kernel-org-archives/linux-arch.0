From: "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>
Subject: Re: [RFC2 nowrap: PATCH v7 00/18] ILP32 for ARM64
Date: Wed, 17 Aug 2016 16:32:23 +0200
Message-ID: <B06DCD94-01BD-4494-BCE8-4C03C11BFDE2@theobroma-systems.com>
References: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com> <175AE090-EDA7-4A8D-9044-3FFA74AC1903@suse.de> <20160817124822.GA25751@yury-N73SV> <DF24AFA0-5B5C-47E8-9B78-7C6C8711948E@theobroma-systems.com> <20160817142916.GC20762@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from vegas.theobroma-systems.com ([144.76.126.164]:52007 "EHLO
	mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751556AbcHQOcj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Aug 2016 10:32:39 -0400
In-Reply-To: <20160817142916.GC20762@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>, linux-doc@vger.kernel.org, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, "Joseph S. Myers" <joseph@codesourcery.com>, linux-arch@vger.kernel.org, zhouchengming1@huawei.com, "Kapoor, Prasun" <Prasun.Kapoor@caviumnetworks.com>, Alexander Graf <agraf@suse.de>, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, Arnd Bergmann <arnd@arndb.de>, Andrew Pinski <pinskia@gmail.com>, linyongting@huawei.com, Alexey Klimov <klimov.linux@gmail.com>, broonie@kernel.org, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, libc-alpha@sourceware.org, Nathan Lynch <Nathan_Lynch@mentor.com>, LKML <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, davem@davemloft.net, =?utf-8?Q?Ch


> On 17 Aug 2016, at 16:29, Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> On Wed, Aug 17, 2016 at 02:54:59PM +0200, Dr. Philipp Tomsich wrote:
>> On 17 Aug 2016, at 14:48, Yury Norov <ynorov@caviumnetworks.com> wrote:
>>> On Wed, Aug 17, 2016 at 02:28:50PM +0200, Alexander Graf wrote:
>>>> On 17 Aug 2016, at 13:46, Yury Norov <ynorov@caviumnetworks.com> wrote:
>>>>> This series enables aarch64 with ilp32 mode, and as supporting work,
>>>>> introduces ARCH_32BIT_OFF_T configuration option that is enabled for
>>>>> existing 32-bit architectures but disabled for new arches (so 64-bit
>>>>> off_t is is used by new userspace).
>>>>> 
>>>>> This version is based on kernel v4.8-rc2.
>>>>> It works with glibc-2.23, and tested with LTP.
>>>>> 
>>>>> This is RFC because there is still no solid understanding what type of registers
>>>>> top-halves delousing we prefer. In this patchset, w0-w7 are cleared for each
>>>>> syscall in assembler entry. The alternative approach is in introducing compat
>>>>> wrappers which is little faster for natively routed syscalls (~2.6% for syscall
>>>>> with no payload) but much more complicated.
>>>> 
>>>> So you’re saying there are 2 options:
>>>> 
>>>> 1) easy to get right, slightly slower, same ABI to user space as 2
>>>> 2) harder to get right, minor performance benefit
>>> 
>>> No, ABI is little different. If 1) we pass off_t in a pair to syscalls,
>>> if 2) - in a single register. So if 1, we 'd take some wrappers from aarch32.
>>> See patch 12 here.
>> 
>> From our experience with ILP32, I’d prefer to have off_t (and similar)
>> in a single register whenever possible (i.e. option #2).  It feels
>> more natural to use the full 64bit registers whenever possible, as
>> ILP32 on ARMv8 should really be understood as a 64bit ABI with a 32bit
>> memory model.
> 
> I think we are well past the point where we considered ILP32 a 64-bit
> ABI. It would have been nice but we decided that breaking POSIX
> compatibility is a bad idea, so we went back (again) to a 32-bit ABI for
> ILP32. While there are 64-bit arguments that, at a first look, would
> make sense to be passed in 64-bit registers, the kernel maintenance cost
> is significant with changes to generic files.
> 
> Allowing 64-bit wide registers at the ILP32 syscall interface means that
> the kernel would have to zero/sign-extend the upper half of the 32-bit
> arguments for the cases where they are passed directly to a native
> syscall that expects a 64-bit argument. This (a) adds a significant
> number of wrappers to the generic code together additional annotations
> to the generic unistd.h and (b) it adds a small overhead to the AArch32
> (compat) ABI since it doesn't need such generic wrapping (the upper half
> of 64-bit registers is guaranteed to be zero/preserved by the
> architecture when coming from the AArch32 mode).

Yes, I remember the discussions and just wanted to put option #2 in context again.
Everything points to just going with the pair-of-registers and getting this merged 
quickly then, I suppose.

Cheers,
Philipp.