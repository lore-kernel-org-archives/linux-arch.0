From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: semantics of dma_map_single()
Date: Mon, 17 Jul 2017 09:06:29 -0700
Message-ID: <23203d16-da54-99c7-0eba-c082eba120d7@synopsys.com>
References: <dc128260-6641-828a-3bb6-c2f0b4f09f78@synopsys.com>
 <20170717064220.GA15807@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170717064220.GA15807@lst.de>
Content-Language: en-US
Sender: owner-linux-mm@kvack.org
To: Christoph Hellwig <hch@lst.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, bart.vanassche@sandisk.com, Alexander Duyck <alexander.h.duyck@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

Hi Christoph,

On 07/16/2017 11:42 PM, Christoph Hellwig wrote:
> I would expect that it would support any contiguous range in
> the kernel mapping (e.g. no vmalloc and friends).  But it's not
> documented anywhere, and if no in kernel users makes use of that
> fact at the moment it might be better to document a page size
> limitation and add asserts to enforce it.

My first thought was indeed to add a BUG_ON for @size > PAGE_SIZE (also accounting 
for offset etc), but I have a feeling this will cause too many breakages. So 
perhaps it would be better to add the fact to Documentation that it can handle any 
physically contiguous range.

-Vineet

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
