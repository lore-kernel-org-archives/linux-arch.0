From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH] asm-generic: io: Fix ioread16/32be and iowrite16/32be
Date: Fri, 8 Feb 2013 09:24:11 +0100
Message-ID: <CAHTX3d+2SpK5pe5d-++j+CrDEF7orDa7zHfQChy21z+Ls2MDJQ@mail.gmail.com>
References: <1360246728-3490-1-git-send-email-michal.simek@xilinx.com>
	<CAMuHMdWEr-uZqc6P1CGNw0P6JG3FGsRKJLB1tLWzuYuBujTzfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWEr-uZqc6P1CGNw0P6JG3FGsRKJLB1tLWzuYuBujTzfQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

2013/2/8 Geert Uytterhoeven <geert@linux-m68k.org>:
> On Thu, Feb 7, 2013 at 3:18 PM, Michal Simek <michal.simek@xilinx.com> wrote:
>> Fix ioreadXXbe and iowriteXXbe functions which did
>> additional little endian conversion on native big endian systems.
>> Using be_to_cpu (cpu_to_be) conversions with __raw_read/write
>> functions have resolved it.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> CC: Geert Uytterhoeven <geert@linux-m68k.org>
>> CC: Will Deacon <will.deacon@arm.com>
>> CC: linux-arch@vger.kernel.org
>
> I have one question (see below). Apart from that:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
>> -#define ioread16be(addr)       be16_to_cpu(ioread16(addr))
>> +#define ioread16be(addr)       __be16_to_cpu(__raw_readw(addr))
>
> Why did you change it to the __beX_to_cpu variant with underscores?

The question could be probably different. Why are they even defined?
I have grepped the kernel and all archs use these generic macros

include/linux/byteorder/generic.h:94:#define be32_to_cpu __be32_to_cpu
include/linux/byteorder/generic.h:106:#define be32_to_cpup __be32_to_cpup
include/linux/byteorder/generic.h:118:#define be32_to_cpus __be32_to_cpus

What about to remove them?

Back to you question. I can't remember particular reason for that maybe
just experience that __ versions should be the fastest kernel implementation.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
