Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32774 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfAXCAh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Jan 2019 21:00:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so2176031pfb.0
        for <linux-arch@vger.kernel.org>; Wed, 23 Jan 2019 18:00:37 -0800 (PST)
Date: Wed, 23 Jan 2019 18:00:35 -0800 (PST)
Subject: Re: [PATCH] riscv: fixup max_low_pfn with PFN_DOWN.
In-Reply-To: <20190116010738.GA4817@guoren-Inspiron-7460>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-7c486840-63d3-4645-84ff-8c89660fc552@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: guoren@kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu, linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, ren_guo@c-sky.com, mao_han@c-sky.com
Message-ID: <20190124020035.323SYvfrl3YcFliZ7mAfSpaB5AS6wKhER4kFp3lUYN0@z>

On Tue, 15 Jan 2019 17:07:38 PST (-0800), guoren@kernel.org wrote:
> Hi Christoph,
>
> I use PFN_DOWN() every where as possible and seems it's a habit
> problem. So let risc-v maintainer to choose "PFN_DOW()" or
> ">> PAGE_SHIFT".
>
> Also the same with "end_of_DRAM & max_low_pfn".

PFN_DOWN makes sense to me, as that's what we're trying to do here (round a 
physical address down to page frame number).  Am a I misunderstanding 
something?

>
> Best Regards
>  Guo Ren
>
> On Tue, Jan 15, 2019 at 08:12:54AM -0800, Christoph Hellwig wrote:
>> On Wed, Jan 16, 2019 at 12:10:00AM +0800, Guo Ren wrote:
>> > > >  	set_max_mapnr(PFN_DOWN(mem_size));
>> > > > -	max_low_pfn = memblock_end_of_DRAM();
>> > > > +	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());
>> > >
>> > > I know it is used just above, but can we please just switch this
>> > > code to use >> PAGE_SHIFT instead of PFN_DOWN, which just horribly
>> > > obsfucates what is going on?
>> > ???
>> > #define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
>> >
>> > phys_addr_t __init_memblock memblock_end_of_DRAM(void)
>> > {
>> > 	int idx = memblock.memory.cnt - 1;
>> >
>> > 	return (memblock.memory.regions[idx].base + memblock.memory.regions[idx].size);
>> > }
>> >
>> > What's the problem? PFN_DOWN() couldn't be used with function call?
>>
>> PFN_DOWN gives you the correct result.  But I think it actually
>> drastically reduces readability over just opencoding it.
>>
>> > My patch just want to point out that max_low_pfn is PFN not size. In fact
>> > there is no error for running without my patch :P
>>
>> No, I think your patch is correct.  I just wonder if we could make
>> the code easier to read.
