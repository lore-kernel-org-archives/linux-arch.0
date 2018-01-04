Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:38280 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751408AbeADRFl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Jan 2018 12:05:41 -0500
References: <20180103180618.18401-1-logang@deltatee.com>
 <20180103180618.18401-8-logang@deltatee.com>
 <VI1PR0402MB3342D07D8173696E94B38C54981F0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <27d6c265-c176-f769-6181-5c772e346953@deltatee.com>
Date: Thu, 4 Jan 2018 10:05:33 -0700
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB3342D07D8173696E94B38C54981F0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 7/8] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, Dan Douglass <dan.douglass@nxp.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Aymen Sghaier <aymen.sghaier@nxp.com>
Message-ID: <20180104170533.ud8HSq3obgzZqDJj0Vmcocee8YFsxklWOJ0tFlcn6Co@z>



On 04/01/18 12:25 AM, Horia Geantã wrote:
>> +#include <linux/io-64-nonatomic-hi-lo.h>
> Typo: lo-hi should be used instead (see previous patch versions).
> 
> Please add in the commit message the explanation (which was there in v8 but
> removed in v9):
> To be consistent with CAAM engine HW spec: in case of 64-bit registers,
> irrespective of device endianness, the lower address should be read from
> / written to first, followed by the upper address. Indeed the I/O
> accessors in CAAM driver currently don't follow the spec, however this
> is a good opportunity to fix the code.

Ok, well I just copied what the latest code did. I assumed that seeing 
it was cleaned up very recently that they would have done it correctly.

>>   
>>   /*
>>    * Architecture-specific register access methods
>> @@ -136,7 +136,6 @@ static inline void clrsetbits_32(void __iomem *reg, u32 clear, u32 set)
>>    *    base + 0x0000 : least-significant 32 bits
>>    *    base + 0x0004 : most-significant 32 bits
>>    */
>> -#ifdef CONFIG_64BIT
>>   static inline void wr_reg64(void __iomem *reg, u64 data)
>>   {
>>   	if (caam_little_end)
> Since the 2 cases (32/64-bit) are merged, caam_imx should be accounted for the
> logic to stay the same.

Oops, my mistake. I'll fix this and the above and send a revised set.

Logan
