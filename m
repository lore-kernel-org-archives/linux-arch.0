From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/22] dma-debug: move initialization to common code
Date: Tue, 24 Apr 2018 09:35:24 +0200
Message-ID: <20180424073524.GB18945@lst.de>
References: <20180420080313.18796-1-hch@lst.de> <20180420080313.18796-2-hch@lst.de> <294a1469-01d6-10fb-5de1-b1d4513a066c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <294a1469-01d6-10fb-5de1-b1d4513a066c@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Vincent Chen <deanbo422@gmail.com>, linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 20, 2018 at 11:23:43AM +0100, Robin Murphy wrote:
>> -void dma_debug_init(u32 num_entries)
>> +static int dma_debug_init(void)
>>   {
>> +	u32 num_entries;
>
> Maybe initialise it to PREALLOC_DMA_DEBUG_ENTRIES?

We initialize it down in an if/else clause which seems a little more clear
to me, at the cost of two extra lines of code.  But I suspect I should
just go a little further and merge the global req_entries and the local
num_entries into a single variable with a better name.

>> +core_initcall(dma_debug_init);
>
> I think it's worth noting that for most users this now happens much earlier 
> than before. In general that's probably good (e.g. on arm64 it should 
> prevent false-positives from the Arm SMMU drivers under ACPI), and I can't 
> imagine it's high-risk, but it is a behaviour change.

I'll mention this in the changelog, thanks!
