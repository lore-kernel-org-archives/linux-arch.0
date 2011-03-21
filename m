From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: Support for ARM940T core Samsung S3C2510A MCU under Linux
Date: Mon, 21 Mar 2011 21:37:52 +1000
Message-ID: <4D873890.5000302@snapgear.com>
References: <AANLkTi=T=QM_GmYYnd8yXJz37LOKqt+AFWk7EEw-7uaN@mail.gmail.com> <AANLkTimPoEi+XLUJgza-b_gXbd4kCGpF93MySAR0ZRvT@mail.gmail.com> <201103192114.05164.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sncsmrelay2.nai.com ([67.97.80.206]:34304 "EHLO
	sncsmrelay2.nai.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab1CULne (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2011 07:43:34 -0400
In-Reply-To: <201103192114.05164.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-arm-kernel@lists.infradead.org, Madhavi Manchala <madhavi.linux@gmail.com>, linux-arch@vger.kernel.org, gregkh@suse.de, prasadjoshi124@gmail.com, uClinux development list <uclinux-dev@uclinux.org>


Hi Arnd,

On 20/03/11 06:14, Arnd Bergmann wrote:
> On Saturday 19 March 2011, Geert Uytterhoeven wrote:
>> On Sat, Mar 19, 2011 at 10:53, Madhavi Manchala<madhavi.linux@gmail.com>  wrote:
>>> I have one basic question about the architecture files in Linux
>>> kernels. We have a board with Samsung S3C2510A MCU (ARM940T core)
>>> which is a no-mmu based CPU. I heard that "there was not a lot of ARM
>>> no-mmu support at the moment" from Ben Dooks.
>>>
>>> So, I started developing the architecture files for my Samsung
>>> S3C2510A MCU (ARM940T core) by looking at the existing S3C2410A
>>> (ARM920 core) architecture files. Is this my porting (developing the
>>> architecture files) correct?
>>>
>>> How can I port the Linux on to my board which has a Samsung S3C2510A
>>> MCU (ARM940T core) which is a NO-MMU based CPU?
>>>
>>> Please suggest me. It would be appreciated your help / suggestions.
>>
>> I think the uClinux mailing list (CCed) is a more appropriate mailing list for
>> your questions.
>
> It depends. Any questions regarding the ARM kernel should be on the
> arm-linux-kernel (also CCed now), since the nommu support is merged
> with the mainline kernel.
>
> uClinux seems to be rather focused on m68knommu (coldfire) these days,

That is more a factor of who shows interest and is active on
the uclinux-dev mailing list more than anything else though.
Quite of few different groups of people interested in non-MMU
ARM platforms have shown up over the years, but none seem to stay
active for long.


> and contains both a kernel and user space. The last uClinux release
> containst some changes for Samsung platforms (s3c24a0, s3c3410,
> s3c44b0x and s5c7375). It's probably a good idea to look at that
> code for reference, but I would suggest integrating the code for
> your platform in the upstream  tree directly.

Yes, highly encourage this.


> I could not find a git tree for uClinux that contains any recent
> kernel. Does that exist?

I used to keep one on git.kernel.org for promoting non-architectural
but non-MMU specific changes to mainline.

http://git.kernel.org/?p=linux/kernel/git/gerg/uclinux.git;a=summary

But I have had so few changes that fit in that category that I
haven't used it in quite a while.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
