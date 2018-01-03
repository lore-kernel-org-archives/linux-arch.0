Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:44669 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750907AbeACGYG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Jan 2018 01:24:06 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 16/67] powerpc: rename dma_direct_ to dma_nommu_
In-Reply-To: <CAMuHMdWWus2kNSOzS94k-3678826W1YjKwCWTquu3hBLZ80cvw@mail.gmail.com>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-17-hch@lst.de> <878tdgtwzp.fsf@concordia.ellerman.id.au> <CAMuHMdWWus2kNSOzS94k-3678826W1YjKwCWTquu3hBLZ80cvw@mail.gmail.com>
Date: Wed, 03 Jan 2018 17:24:02 +1100
Message-ID: <87h8s3cvel.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-c6x-dev@linux-c6x.org, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, adi-buildroot-devel@lists.sourceforge.net, linux-m68k <linux-m68k@lists.linux-m68k.org>, patches@groups.riscv.org, "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, Parisc List <linux-parisc@vger.kernel.org>, Cris <linux-cris-kernel@axis.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alpha <linux-alpha@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20180103062402.mizEm98l90eNCtJuy9NjqNaQBpYa8grzkx8_Qhj2-xo@z>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Tue, Jan 2, 2018 at 10:45 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Christoph Hellwig <hch@lst.de> writes:
>>
>>> We want to use the dma_direct_ namespace for a generic implementation,
>>> so rename powerpc to the second best choice: dma_nommu_.
>>
>> I'm not a fan of "nommu". Some of the users of direct ops *are* using an
>> IOMMU, they're just setting up a 1:1 mapping once at init time, rather
>> than mapping dynamically.
>>
>> Though I don't have a good idea for a better name, maybe "1to1",
>> "linear", "premapped" ?
>
> "identity"?

I think that would be wrong, but thanks for trying to help :)

The address on the device side is sometimes (often?) offset from the CPU
address. So eg. the device can DMA to RAM address 0x0 using address
0x800000000000000.

Identity would imply 0 == 0 etc.

I think "bijective" is the correct term, but that's probably a bit
esoteric.

cheers
