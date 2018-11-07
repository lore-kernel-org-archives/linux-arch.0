From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 2/2] mm/sparse: add common helper to mark all memblocks
 present
Date: Wed, 7 Nov 2018 13:19:08 -0700
Message-ID: <724be9bb-59b6-33f3-7b59-3ca644d59bf7@deltatee.com>
References: <20181107173859.24096-1-logang@deltatee.com>
 <20181107173859.24096-3-logang@deltatee.com>
 <20181107121207.62cb37cf58484b7cc80a8fd8@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107121207.62cb37cf58484b7cc80a8fd8@linux-foundation.org>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Stephen Bates <sbates@raithlin.com>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>
List-Id: linux-arch.vger.kernel.org



On 2018-11-07 1:12 p.m., Andrew Morton wrote:
>> +void __init memblocks_present(void)
>> +{
>> +	struct memblock_region *reg;
>> +
>> +	for_each_memblock(memory, reg) {
>> +		memory_present(memblock_get_region_node(reg),
>> +			       memblock_region_memory_base_pfn(reg),
>> +			       memblock_region_memory_end_pfn(reg));
>> +	}
>> +}
>> +
> 
> I don't like the name much.  To me, memblocks_present means "are
> memblocks present" whereas this actually means "memblocks are present".
> But whatever.  A little covering comment which describes what this
> does and why it does it would be nice.

The same argument can be made about the existing memory_present()
function and I think it's worth keeping the naming consistent. I'll add
a comment and resend shortly.

> Acked-by: Andrew Morton <akpm@linux-foundation.org>
> 
> I can grab both patches and shall sneak them into 4.20-rcX, but feel
> free to merge them into some git tree if you'd prefer.  If I see them
> turn up in linux-next I shall drop my copy.

Sounds good, thanks.

Logan
