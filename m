From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 24/40] metag: DMA
Date: Fri, 23 Nov 2012 16:20:29 +0000
Message-ID: <50AFA24D.4030501@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <1351700061-7203-25-git-send-email-james.hogan@imgtec.com> <201211091425.13492.arnd@arndb.de> <50AF9C06.3010705@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:55657 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755208Ab2KWQUc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 Nov 2012 11:20:32 -0500
In-Reply-To: <50AF9C06.3010705@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

On 23/11/12 15:53, James Hogan wrote:
> On 09/11/12 14:25, Arnd Bergmann wrote:
>> On Wednesday 31 October 2012, James Hogan wrote:
>>> +static inline void
>>> +dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
>>> +                enum dma_data_direction direction)
>>> +{
>>> +       BUG_ON(!valid_dma_direction(direction));
>>> +       dma_sync_for_cpu((void *)bus_to_virt(dma_addr), size, direction);
>>> +}
>>
>> bus_to_virt is deprecated an should not be visible to device drivers
>> any more for new stuff. Maybe you can remove the definition and introduce
>> a __bus_to_virt() function for internal use that also returns a pointer
>> type instead.
> 
> Hi Arnd,
> 
> Is there any reason not to just directly use phys_to_virt (which
> bus_to_virt was defined as before)?
> 
> Thanks
> James
> 

asm-generic/io.h has bitten me. Does the following look reasonable?

Thanks
James

Subject: [PATCH 1/1] asm-generic/io.h: check CONFIG_VIRT_TO_BUS

Make asm-generic/io.h check CONFIG_VIRT_TO_BUS before defining
virt_to_bus() and bus_to_virt(), otherwise it's easy to accidentally
have a silently failing incorrect direct mapped definition rather then
no definition at all.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 include/asm-generic/io.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 616eea5..34823ef 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -350,6 +350,7 @@ extern void ioport_unmap(void __iomem *p);
 #define xlate_dev_kmem_ptr(p)	p
 #define xlate_dev_mem_ptr(p)	__va(p)
 
+#ifdef CONFIG_VIRT_TO_BUS
 #ifndef virt_to_bus
 static inline unsigned long virt_to_bus(volatile void *address)
 {
@@ -361,6 +362,7 @@ static inline void *bus_to_virt(unsigned long address)
 	return (void *) address;
 }
 #endif
+#endif
 
 #define memset_io(a, b, c)	memset(__io_virt(a), (b), (c))
 #define memcpy_fromio(a, b, c)	memcpy((a), __io_virt(b), (c))
-- 
1.7.7.6
