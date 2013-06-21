From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH] drivers/block/xsysace - replace
 in(out)_8/in(out)_be16/in(out)_le16 with generic iowrite(read)8/16(be)
Date: Fri, 21 Jun 2013 18:35:46 +0000
Message-ID: <4881796E12491D4BB15146FE0209CE643F5F683F@DE02WEMBXB.internal.synopsys.com>
References: <1371823336-19678-1-git-send-email-abrodkin@synopsys.com>
 <201306211623.06016.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from alvesta.synopsys.com ([198.182.60.77]:61974 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423388Ab3FUSfw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jun 2013 14:35:52 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Mischa Jonker <Mischa.Jonker@synopsys.com>, Grant Likely <grant.likely@secretlab.ca>, Michal Simek <monstr@monstr.eu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

On 06/21/2013 06:23 PM, Arnd Bergmann wrote:
 >>   static void ace_datain_8(struct ace_device *ace)
 >> @@ -248,7 +248,7 @@ static void ace_datain_8(struct ace_device *ace)
 >>   	u8 *dst = ace->data_ptr;
 >>   	int i = ACE_FIFO_SIZE;
 >>   	while (i--)
 >> -		*dst++ = in_8(r++);
 >> +		*dst++ = ioread8(r++);
 >>   	ace->data_ptr = dst;
 >>   }
 >
 > Why not just use ioread8_rep() to replace the loop?

My intention with this first patch was to do a simple iteration that is 
supposed to not break anything. As it it said in patch title - just 
replace accessors. And for now (for this patch) leave improper 
implemented functionality as it is.

And in the next patch I will introduce changes that you've suggested 
with "_rep" accessors.

Maybe I should have sent both patches at once so my intention would be 
clear.

 >
 > I guess the last two modifications are actually needed for correct
 > operation independent of CPU endianess. I don't what led to the
 > combination of big- and little-endian accessors, but my guess is
 > that it was trial-and-error together with cut-and-paste. The point
 > is that the single register access should match the endianess of
 > the device while the streaming access should match the endianess
 > of the CPU.

Completely agree.

-Alexey
