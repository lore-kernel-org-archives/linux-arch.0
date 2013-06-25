From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v2 2/3] drivers/block/xsysace - use "_rep" accessors
 with CPU endianess for data
Date: Tue, 25 Jun 2013 06:32:12 +0000
Message-ID: <4881796E12491D4BB15146FE0209CE643F60030B@DE02WEMBXB.internal.synopsys.com>
References: <1372062364-25861-1-git-send-email-abrodkin@synopsys.com>
 <1372062364-25861-3-git-send-email-abrodkin@synopsys.com>
 <51C93117.3090809@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from alvesta.synopsys.com ([198.182.60.77]:48617 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab3FYGcS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2013 02:32:18 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "monstr@monstr.eu" <monstr@monstr.eu>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Mischa Jonker <Mischa.Jonker@synopsys.com>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

On 06/25/2013 09:58 AM, Michal Simek wrote:
> On 06/24/2013 10:26 AM, Alexey Brodkin wrote:
>> Initially different data accessors were used for LE abd BE CPUs:
>> "ioread16" in "ace_datain_be16" and "ioread16be" in "ace_datain_le16".
>> The same with writes.
>>
>> While it worked in some cases (for example on BE PPC) it didn't work in
>> others (LE ARC).
>
> I am not sure about this. It seems to me that what you need to do
> is swapped wires in your hw design to use the same configuration
> as is used on ppc and microblaze for data access.
 >
>> Mentioned functions access data (by 16-bit chunks) from storage (i.e.
>> CompactFlash card) via DATABUFREG of Xilinx SystemACE CF controller.
>> And to interpret data properly CPU needs to access data in DATABUFREG
>> with native endianess.
>
> I have had a lot of discussions about using native endianess.
> This driver supports endian detection on register side
> but not on data side.
> Is this soft IP? If yes then just swapped wires on bus and use
> standard configuration.

I don't think there's a wiring problem.
For starters "Xilinx SystemACE CF controller" (at least the one I'm 
dealing with on "Xilinx ML-509" board) is a real hardware IC (with part 
number XCCACE-TQ144I).

And what about your HW? Is your SystemACE controller is a soft-IP?

As described in corresponding datasheet 
(http://www.xilinx.com/support/documentation/data_sheets/ds080.pdf) 
CF-card is connected to this IC directly - so CPU itself doesn't have 
any connection to CF.

CPU only can access (read/write) SystemACE's registers and by these actions:
1. Config SystemACE or read its configuration and status (registers 
0x00-0x1d).
2. Read/write data from/to CF-card (register 0x40).

And as long as configuration/status registers access is proven to work I 
expect access to data via just reads/writes from/to another same 
register should work as well.

> Grant is driver owner and he has to decide if this is acceptable
> or not.

As far as I may see from latest MAINTAINERS file grant is no longer 
maintains it. So who may take any decision now? Arnd?

> I can test it on microblaze hw.

Would be very nice and helpful if you give it a shot on Microblaze HW.
BTW what is an endianess of this HW? Only BE or both BE/LE?

Regards,
Alexey
