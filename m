From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 0/4] remove GENERIC_GPIO
Date: Thu, 11 Apr 2013 19:35:37 +0530
Message-ID: <5166C331.7060404@synopsys.com>
References: <1365445950-5736-1-git-send-email-gnurou@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtp3.synopsys.com ([198.182.44.81]:44886 "EHLO
	hermes.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464Ab3DKOF4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Apr 2013 10:05:56 -0400
In-Reply-To: <1365445950-5736-1-git-send-email-gnurou@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, "christian.ruppert@abilis.com" <christian.ruppert@abilis.com>, Pierrick Hascoet <pierrick.hascoet@abilis.com>, sascha leuenberger <sascha.leuenberger@abilis.com>

Hi Alexandre,

On 04/09/2013 12:02 AM, Alexandre Courbot wrote:
> From: Alexandre Courbot <acourbot@nvidia.com>
> 
> Second version, based on -next this time, of the GENERIC_GPIO removal patches.
> Considering there is only a short amount of time before 3.10 merge window opens,
> I hope this version will be considered for inclusion, otherwise we'd end up
> with an half-baked removal or I will have to rebase everything for 3.11. :(
> 
> Grant, if this is ok with you, how shall we have this integrated into your
> branch? Half of this has been tested in my -next branch, and the present patches
> make the next half, should I resend you the whole series based on -next and
> withdraw my branch? This is a fast moving target, so we should try and shoot
> that duck as soon as we can! :)
> 
> Changes from v1:
> * Rebased on -next
> * Added Chinese documentation update from Chen Baozi
> 
> Alexandre Courbot (3):
>   gpio: convert selectors of GENERIC_GPIO to GPIOLIB
>   gpio: remove GENERIC_GPIO config option
>   gpio: rename CONFIG_GPIOLIB to CONFIG_GPIO
> 

I'm the maintainer for arch/arc.

For 3.10, we are going to have a sub-platform included which enables GPIO.
However given that your patch is still not in a maintainer tree I'm going to apply
the platform patch with GENERIC_GPIO and it would show up in -next as well. But
don't be alarmed - to align with your work, Christian or you can then possibly
apply a patch to make arch/arc/* confirm to your work - preferably via your
tree/patchseries  - OK ?


Thx,
-Vineet
