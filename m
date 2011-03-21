From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: Support for ARM940T core Samsung S3C2510A MCU under Linux
Date: Mon, 21 Mar 2011 21:27:54 +1000
Message-ID: <4D87363A.7090209@snapgear.com>
References: <AANLkTinSMPPHzmp5e1JrPByXC0XCY-591S=jGATXHR=U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sncsmrelay2.nai.com ([67.97.80.206]:20636 "EHLO
	sncsmrelay2.nai.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211Ab1CULc1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2011 07:32:27 -0400
In-Reply-To: <AANLkTinSMPPHzmp5e1JrPByXC0XCY-591S=jGATXHR=U@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Madhavi Manchala <madhavi.linux@gmail.com>
Cc: linux-arch@vger.kernel.org


Hi Madhavi,

On 19/03/11 01:54, Madhavi Manchala wrote:
> I have one basic question about the architecture files in Linux
> kernels. We have a board with Samsung S3C2510A MCU (ARM940T core)
> which is a no-mmu based CPU. I heard that "there was not a lot of ARM
> no-mmu support at the moment" from Ben Dooks.

The core is there, but there is very little specific machine support.
The one I use for testing is non-MMU ARM is the Atmel/AT91X40 (that is
CONFIG_ARCH_AT91X40). I don't run it on real hardware, but on the
SkyEye emulator.


> So, I started developing the architecture files for my Samsung
> S3C2510A MCU (ARM940T core) by looking at the existing S3C2410A
> (ARM920 core) architecture files. Is this my porting (developing the
> architecture files) correct?

Would make sense to start on something similar, yes.


> How can I port the Linux on to my board which has a Samsung S3C2510A
> MCU (ARM940T core) which is a NO-MMU based CPU?
>
> Thanks for your suggestions / hints / comments.

You can look at what I did with the AT91X40 for an example.
Or look at the patches that Ithamar Adema sent to the ARM linux
mailing list in the last few days for supporting the NXP LPC2K
family as another example (they are also non-MMU parts).

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
