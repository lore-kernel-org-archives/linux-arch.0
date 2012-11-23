From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 24/40] metag: DMA
Date: Fri, 23 Nov 2012 15:53:42 +0000
Message-ID: <50AF9C06.3010705@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <1351700061-7203-25-git-send-email-james.hogan@imgtec.com> <201211091425.13492.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:52727 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755163Ab2KWPxp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 Nov 2012 10:53:45 -0500
In-Reply-To: <201211091425.13492.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

On 09/11/12 14:25, Arnd Bergmann wrote:
> On Wednesday 31 October 2012, James Hogan wrote:
>> +static inline void
>> +dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
>> +                enum dma_data_direction direction)
>> +{
>> +       BUG_ON(!valid_dma_direction(direction));
>> +       dma_sync_for_cpu((void *)bus_to_virt(dma_addr), size, direction);
>> +}
> 
> bus_to_virt is deprecated an should not be visible to device drivers
> any more for new stuff. Maybe you can remove the definition and introduce
> a __bus_to_virt() function for internal use that also returns a pointer
> type instead.

Hi Arnd,

Is there any reason not to just directly use phys_to_virt (which
bus_to_virt was defined as before)?

Thanks
James
