From: Alex Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH v2 0/4] remove GENERIC_GPIO
Date: Tue, 16 Apr 2013 18:01:13 +0900
Message-ID: <516D1359.2080609@nvidia.com>
References: <1365445950-5736-1-git-send-email-gnurou@gmail.com> <5166C331.7060404@synopsys.com> <CAAVeFuJ1T9FyBLBkxBGsWNppU66+7a2pzJVYieakNsEw35=9Ug@mail.gmail.com> <20130415074322.GC3264@ab42.lan> <516CB71D.9070603@nvidia.com> <20130416073459.GA30238@ab42.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:7743 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783Ab3DPJBT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Apr 2013 05:01:19 -0400
In-Reply-To: <20130416073459.GA30238@ab42.lan>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Ruppert <christian.ruppert@abilis.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Pierrick Hascoet <pierrick.hascoet@abilis.com>, sascha leuenberger <sascha.leuenberger@abilis.com>

Hi Christian,

On 04/16/2013 04:34 PM, Christian Ruppert wrote:
> Thanks for taking a look at the driver. I think the issue we see is due
> to the fact that "Platforms must declare GENERIC_GPIO support in their
> Kconfig (boolean true)" (from Documentation/gpio.txt). This seems to be
> still the case at the moment and I haven't found a way around it.
> Removing the config GENERIC_GPIO section from our platform's Kconfig
> (see arch/arc/plat-tb10x/Kconfig in linux-next) results in compilation
> errors. This seems logical since "config GPIOLIB" only selects
> GENERIC_GPIO but assumes it is defined elsewhere.
>
> We were wondering if we could get rid of the "config GENERIC_GPIO"
> section in the new platform's Kconfig in order to avoid adding things
> you are going to remove again soon and in order to check if there aren't
> any hidden dependencies on GENERIC_GPIO in the driver. Do I understand
> your mail correctly that this is not yet possible?

Oh, then it looks like *I* did not understand your mail correctly. It is 
absolutely necessary indeed that your architecture declares a 
GENERIC_GPIO config option. What I was trying to prevent you from doing 
was to put new "select GENERIC_GPIO" or "depends on GENERIC_GPIO" in 
your Kconfig files.

If the only reference to GENERIC_GPIO in your architecture or drivers is 
the declaration of this config option, then it is perfectly fine - I 
will take care of removing it when the time is right.

So I guess you guys are just fine - sorry about the misunderstanding!

Thanks,
Alex.
