Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34213 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbeACIUJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jan 2018 03:20:09 -0500
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWYDz_jHNxQ-B8944520R-myzHkjkL1rKWUjA38inU7cw@mail.gmail.com>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-17-hch@lst.de>
 <878tdgtwzp.fsf@concordia.ellerman.id.au> <CAMuHMdWWus2kNSOzS94k-3678826W1YjKwCWTquu3hBLZ80cvw@mail.gmail.com>
 <87h8s3cvel.fsf@concordia.ellerman.id.au> <CAMuHMdWYDz_jHNxQ-B8944520R-myzHkjkL1rKWUjA38inU7cw@mail.gmail.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 3 Jan 2018 19:19:46 +1100
Message-ID: <CAGRGNgV+DnZAAtiE5oe8rxp4=_JHJrtSQc8F5jrgN0rgYKfwjA@mail.gmail.com>
Subject: Re: [PATCH 16/67] powerpc: rename dma_direct_ to dma_nommu_
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-c6x-dev@linux-c6x.org, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, adi-buildroot-devel@lists.sourceforge.net, linux-m68k <linux-m68k@lists.linux-m68k.org>, patches@groups.riscv.org, "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>, "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>, Michal Simek <monstr@monstr.eu>, Parisc List <linux-parisc@vger.kernel.org>, Cris <linux-cris-kernel@axis.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alpha <linux-alpha@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20180103081946.7cXu_TRrduj1l0GElQiB0zzse8hOizBfelCNsMFIp5g@z>

Hi All,

On Wed, Jan 3, 2018 at 6:49 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Michael,
>
> On Wed, Jan 3, 2018 at 7:24 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>>
>>> On Tue, Jan 2, 2018 at 10:45 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>>> Christoph Hellwig <hch@lst.de> writes:
>>>>
>>>>> We want to use the dma_direct_ namespace for a generic implementation,
>>>>> so rename powerpc to the second best choice: dma_nommu_.
>>>>
>>>> I'm not a fan of "nommu". Some of the users of direct ops *are* using an
>>>> IOMMU, they're just setting up a 1:1 mapping once at init time, rather
>>>> than mapping dynamically.
>>>>
>>>> Though I don't have a good idea for a better name, maybe "1to1",
>>>> "linear", "premapped" ?
>>>
>>> "identity"?
>>
>> I think that would be wrong, but thanks for trying to help :)
>>
>> The address on the device side is sometimes (often?) offset from the CPU
>> address. So eg. the device can DMA to RAM address 0x0 using address
>> 0x800000000000000.
>>
>> Identity would imply 0 == 0 etc.
>>
>> I think "bijective" is the correct term, but that's probably a bit
>> esoteric.
>
> OK, didn't know about the offset.
> Then "linear" is what we tend to use, right?

If this is indeed a linear mapping, can we just remove this and
replace it with the new "generic" mapping being introduced by this
patchset?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
