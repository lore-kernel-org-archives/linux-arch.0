From: Alex Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH v2 0/4] remove GENERIC_GPIO
Date: Tue, 16 Apr 2013 11:27:41 +0900
Message-ID: <516CB71D.9070603@nvidia.com>
References: <1365445950-5736-1-git-send-email-gnurou@gmail.com> <5166C331.7060404@synopsys.com> <CAAVeFuJ1T9FyBLBkxBGsWNppU66+7a2pzJVYieakNsEw35=9Ug@mail.gmail.com> <20130415074322.GC3264@ab42.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:16589 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935053Ab3DPC1u (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Apr 2013 22:27:50 -0400
In-Reply-To: <20130415074322.GC3264@ab42.lan>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Ruppert <christian.ruppert@abilis.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Pierrick Hascoet <pierrick.hascoet@abilis.com>, sascha leuenberger <sascha.leuenberger@abilis.com>

On 04/15/2013 04:43 PM, Christian Ruppert wrote:
> Hello Alexandre,
>
> On Fri, Apr 12, 2013 at 11:42:42AM -0700, Alexandre Courbot wrote:
>> Hi Vineet,
>>
>> On Thu, Apr 11, 2013 at 7:05 AM, Vineet Gupta
>> <Vineet.Gupta1@synopsys.com> wrote:
>>> I'm the maintainer for arch/arc.
>>>
>>> For 3.10, we are going to have a sub-platform included which enables GPIO.
>>> However given that your patch is still not in a maintainer tree I'm going to apply
>>> the platform patch with GENERIC_GPIO and it would show up in -next as well. But
>>> don't be alarmed - to align with your work, Christian or you can then possibly
>>> apply a patch to make arch/arc/* confirm to your work - preferably via your
>>> tree/patchseries  - OK ?
>>
>> I guess that would work, but since I assume your platforms' GPIO
>> implementation use gpiolib anyway wouldn't it be simpler and more
>> logical to directly require it?
>>
>> If you have reasons for not doing so I'm ok with doing the switch
>> later too, anyway that's what I had to do for all the other archs.
>
> The GPIO driver patch was proposed on lkml a few days ago and although I
> am not aware of any "GENERIC" methods it uses it does not compile
> without GENERIC_GPIO being defined (errors in of_gpio.h etc). You can
> review the patch at https://lkml.org/lkml/2013/4/10/385.
>
> We'd be happy to accept any guidance on how to remove GENERIC_GPIO.
> Also, I'm not sure the custom interface to the pin controller is a great
> solution and suggestions are welcome. The goal is to remove redundancy
> between the drivers in the definition of pin groups.

Hi Christian,

Thanks for the link to the patch. This is rather puzzling - in 
drivers/gpio/Kconfig your GPIO_TB10X config option seems to be under the 
"if GPIOLIB" condition which is what I expect, since your driver uses 
gpiolib. If you go to the GPIOLIB config option, you notice that is 
explicitly selects GENERIC_GPIO as a result of being enabled. Therefore 
CONFIG_GENERIC_GPIO should always be defined whenever your driver is 
compiled and it should not be needed to select it elsewhere. Do we agree 
on that?

I'd really like to go to the bottom of this since I saw several similar 
issues already, but I don't understand how this can happen at all. 
Having the .config of both the working (with GENERIC_GPIO selected) and 
non-working (only GPIOLIB selected) cases would probably be helpful, 
could you send them to me?

Thanks,
Alex.
