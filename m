From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v2 2/3] drivers/block/xsysace - use "_rep" accessors
 with CPU endianess for data
Date: Thu, 27 Jun 2013 13:44:41 +0000
Message-ID: <4881796E12491D4BB15146FE0209CE643F606E83@DE02WEMBXB.internal.synopsys.com>
References: <1372062364-25861-1-git-send-email-abrodkin@synopsys.com>
 <1372062364-25861-3-git-send-email-abrodkin@synopsys.com>
 <51C93117.3090809@monstr.eu>
 <4881796E12491D4BB15146FE0209CE643F60030B@DE02WEMBXB.internal.synopsys.com>
 <51CAB4AF.7040407@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from kiruna.synopsys.com ([198.182.44.80]:61211 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab3F0Now convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jun 2013 09:44:52 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "monstr@monstr.eu" <monstr@monstr.eu>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Mischa Jonker <Mischa.Jonker@synopsys.com>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

On 06/26/2013 01:31 PM, Michal Simek wrote:
> On 06/25/2013 08:32 AM, Alexey Brodkin wrote:
>> On 06/25/2013 09:58 AM, Michal Simek wrote:
>>> On 06/24/2013 10:26 AM, Alexey Brodkin wrote:
>>>> Initially different data accessors were used for LE abd BE CPUs:
>>>> "ioread16" in "ace_datain_be16" and "ioread16be" in "ace_datain_le16".
>>>> The same with writes.
>>>>
>>>> While it worked in some cases (for example on BE PPC) it didn't work in
>>>> others (LE ARC).
>>>
>>> I am not sure about this. It seems to me that what you need to do
>>> is swapped wires in your hw design to use the same configuration
>>> as is used on ppc and microblaze for data access.
>>   >
>>>> Mentioned functions access data (by 16-bit chunks) from storage (i.e.
>>>> CompactFlash card) via DATABUFREG of Xilinx SystemACE CF controller.
>>>> And to interpret data properly CPU needs to access data in DATABUFREG
>>>> with native endianess.
>>>
>>> I have had a lot of discussions about using native endianess.
>>> This driver supports endian detection on register side
>>> but not on data side.
>>> Is this soft IP? If yes then just swapped wires on bus and use
>>> standard configuration.
>>
>> I don't think there's a wiring problem.
>> For starters "Xilinx SystemACE CF controller" (at least the one I'm
>> dealing with on "Xilinx ML-509" board) is a real hardware IC (with part
>> number XCCACE-TQ144I).
>>
>> And what about your HW? Is your SystemACE controller is a soft-IP?
>
> bus-> sysace soft IP -> connetion to the real chip(MPD below) -> chip -> CF
>
> In xilinx mhs file there are MPD pins which are data pins
> and they are wired like this for 16bit mode
> PORT fpga_0_SysACE_CompactFlash_SysACE_MPD_pin = fpga_0_SysACE_CompactFlash_SysACE_MPD_pin, DIR = IO, VEC = [15:0]
> and like this for 8bit mode.
> PORT SysACE_MPD = SysACE_MPD, DIR = IO, VEC = [7:0]
>
> I am not sure about configuration but if you have something similar
> what xilinx has then you should be simple able to change data pins
> and this will reflect linux driver.
>
> what configuration do you use?

Well, we have our own BVCI-to-MPU bridge that maps SystemACE interface 
in CPU memory space (i.e. memory-mapped registers). This bridge also 
implements data read/write from/to SyatemACE FIFO. And frankly I cannot 
say how data is transferred to/from this FIFO.

I will need to look into bridge's Verilog to get all specifics.
but I'm not an expert in HW/Verilog so not sure how useful this 
excursion might be.

So no good clarification on this yet, sorry.

>> As described in corresponding datasheet
>> (http://www.xilinx.com/support/documentation/data_sheets/ds080.pdf)
>> CF-card is connected to this IC directly - so CPU itself doesn't have
>> any connection to CF.
>
> I am not talking about connection between system ace chip and CF.
> xilinx configuration is done as I have described above where
> we can setup data lines order. I haven't done any experiment with it
> but seems to me straight forward to do it.
>
>> CPU only can access (read/write) SystemACE's registers and by these actions:
>> 1. Config SystemACE or read its configuration and status (registers
>> 0x00-0x1d).
>> 2. Read/write data from/to CF-card (register 0x40).
>>
>> And as long as configuration/status registers access is proven to work I
>> expect access to data via just reads/writes from/to another same
>> register should work as well.
>>
>>> Grant is driver owner and he has to decide if this is acceptable
>>> or not.
>>
>> As far as I may see from latest MAINTAINERS file grant is no longer
>> maintains it. So who may take any decision now? Arnd?
>
> I should probably assign it to my me as the part of my microblaze
> responsibility. And xilinx virtex as part of my work for xilinx.
>
> MAINTAINERS: Update Grant's email address and maintainership
> sha1: 19624236cce1b33a5d43895a92e3a9d438dc36e2
>
>
>>> I can test it on microblaze hw.
>>
>> Would be very nice and helpful if you give it a shot on Microblaze HW.
>> BTW what is an endianess of this HW? Only BE or both BE/LE?
>
> 8bit BE/LE 16bit BE. I have one 16bit LE configuration too
> but before I do testing on real HW let's clear your connection.

If this won't take much time I will appreciate if you try proposed patch 
at least on 1 pair of LE/BE hw.

If it doesn't work then data accessors might need to be implemented the 
same way they were initially done. And in this case my v1 patch may make 
sense (replace accessors with generic versions).

Regards,
Alexey
