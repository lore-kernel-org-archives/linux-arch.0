From: Michal Simek <monstr@seznam.cz>
Subject: Re: [PATCH 36/56] microblaze_v2: dma support
Date: Wed, 07 May 2008 08:24:54 +0200
Message-ID: <48214B36.9060307@seznam.cz>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <200805061324.06282.arnd@arndb.de> <48205B0D.70202@seznam.cz> <200805061736.18180.arnd@arndb.de>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.wifiinternet.cz ([89.31.47.1]:60207 "EHLO
	bor.wifiinternet.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753602AbYEGGYC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 May 2008 02:24:02 -0400
In-Reply-To: <200805061736.18180.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, John Williams <john.williams@petalogix.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca


Hi Arnd and Geert,

struct scatterlist {
#ifdef CONFIG_DEBUG_SG
       unsigned long     sg_magic; /* 32 bit */
#endif
       unsigned long     page_link; /* 32 bit */
       dma_addr_t        dma_address; /* 32/64 bit */
       unsigned int      length;  /* 32 bit */
       unsigned int      offset; /* 32 bit */
};

#define sg_dma_address(sg)      ((sg)->dma_address)
#define sg_dma_len(sg)          ((sg)->length)

Is it OK now? This will moved to asm-generic too.

M

>> here is proposed struct.
>>
>> struct scatterlist {
>>       dma_addr_t        dma_address;
>>       unsigned long     page_link;
>> #ifdef CONFIG_DEBUG_SG
>>       unsigned long     sg_magic;
>> #endif
>>       unsigned int      length;
>>       unsigned int      offset;
>> };
>>
>> Is it OK now?
> 
> Everyone else has the sg_magic first, which makes sense for debugging.
> Don't worry about it too much, just use the same code as avr32, h8300,
> blackfin, fvr, mk68knommu, mn10300, sh, v850 and xtensa.
> 
> These are all the same, but I just saw that they also have
> 
> #define sg_dma_address(sg)      ((sg)->dma_address)
> #define sg_dma_len(sg)          ((sg)->length)
> 
> which you probably want as well.
> 
> 	Arnd <><
> 
> 
