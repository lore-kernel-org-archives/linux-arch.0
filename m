From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: PAGE_KERNEL_RO
Date: Thu, 13 Jan 2011 10:12:17 +0100
Message-ID: <4D2EC1F1.2040107@ladisch.de>
References: <20110112160722.6486a6c2.akpm@linux-foundation.org>	 <1294877484.9586.66.camel@pasglop> <20110113073458.2179590a@stein>	 <522C1DF17AF50042AD8AE87F7887BD3D01E1655529@exch.hq.tensilica.com>	 <4D2EA95C.7000900@ladisch.de> <1294909442.3162.11.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57082 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932428Ab1AMJM3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 13 Jan 2011 04:12:29 -0500
In-Reply-To: <1294909442.3162.11.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Marc Gauthier <marc@tensilica.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux1394-devel@lists.sourceforge.net

James Bottomley wrote:
> On Thu, 2011-01-13 at 08:27 +0100, Clemens Ladisch wrote:
>> firewire: ohci: fix compilation on arches without PAGE_KERNEL_RO, e.g. sparc
>> 
>> PAGE_KERNEL_RO is not available on all architectures, so its use in the
>> new AR code broke compilation on sparc64.
>> 
>> Because the R/O mapping is only used to catch drivers that try to write
>> to the reception buffer and not actually required for correct operation,
>> we can just use a normal PAGE_KERNEL mapping where _RO is not available.
>> 
>> Thanks to Stefan Richter and Marc Gauthier <marc@tensilica.com> for
>> suggesting this fix.
>> 
>> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
>> 
>> --- a/drivers/firewire/ohci.c
>> +++ b/drivers/firewire/ohci.c
>> @@ -91,6 +91,14 @@ struct descriptor {
>>  #define MAX_AR_PACKET_SIZE	(16 + MAX_ASYNC_PAYLOAD + 4)
>>  #define AR_WRAPAROUND_PAGES	DIV_ROUND_UP(MAX_AR_PACKET_SIZE, PAGE_SIZE)
>>  
>> +/*
>> + * For archs where PAGE_KERNEL_RO is not supported;
>> + * mapping the AR buffers readonly for the CPU is just a debugging aid.
>> + */
>> +#ifndef PAGE_KERNEL_RO
>> +#define PAGE_KERNEL_RO PAGE_KERNEL
>> +#endif
> 
> This might cause interesting issues on sparc64 if it ever acquired a
> PAGE_KERNEL_RO.  Sparc64 has extern pgprot_t for it's PAGE_KERNEL types
> rather than #defines, so the #ifdef check wouldn't see this.
> 
> I think either PAGE_PROT_RO becomes part of our arch API (so all
> architectures are forced to add it), or, if it's not part of the API,
> ohci isn't entitled to use it.  The latter seems simplest since you have
> no real use for write protection anyway.

--8<---------------------------------------------------------------->8--
firewire: ohci: fix compilation on arches without PAGE_KERNEL_RO

PAGE_KERNEL_RO is not available on all architectures, so its use
in the new AR code broke compilation on sparc64.

Because the read-only mapping was just a debugging aid, just use
PAGE_KERNEL instead.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -961,7 +961,7 @@ static int ar_context_init(struct ar_context *ctx, struct fw_ohci *ohci,
 	for (i = 0; i < AR_WRAPAROUND_PAGES; i++)
 		pages[AR_BUFFERS + i] = ctx->pages[i];
 	ctx->buffer = vm_map_ram(pages, AR_BUFFERS + AR_WRAPAROUND_PAGES,
-				 -1, PAGE_KERNEL_RO);
+				 -1, PAGE_KERNEL);
 	if (!ctx->buffer)
 		goto out_of_memory;
 
