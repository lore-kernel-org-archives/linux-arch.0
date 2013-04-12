From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH v2 0/4] remove GENERIC_GPIO
Date: Fri, 12 Apr 2013 11:42:42 -0700
Message-ID: <CAAVeFuJ1T9FyBLBkxBGsWNppU66+7a2pzJVYieakNsEw35=9Ug@mail.gmail.com>
References: <1365445950-5736-1-git-send-email-gnurou@gmail.com> <5166C331.7060404@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:44766 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920Ab3DLSnD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Apr 2013 14:43:03 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so3307886iec.14
        for <linux-arch@vger.kernel.org>; Fri, 12 Apr 2013 11:43:02 -0700 (PDT)
In-Reply-To: <5166C331.7060404@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, "christian.ruppert@abilis.com" <christian.ruppert@abilis.com>, Pierrick Hascoet <pierrick.hascoet@abilis.com>, sascha leuenberger <sascha.leuenberger@abilis.com>

Hi Vineet,

On Thu, Apr 11, 2013 at 7:05 AM, Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
> I'm the maintainer for arch/arc.
>
> For 3.10, we are going to have a sub-platform included which enables GPIO.
> However given that your patch is still not in a maintainer tree I'm going to apply
> the platform patch with GENERIC_GPIO and it would show up in -next as well. But
> don't be alarmed - to align with your work, Christian or you can then possibly
> apply a patch to make arch/arc/* confirm to your work - preferably via your
> tree/patchseries  - OK ?

I guess that would work, but since I assume your platforms' GPIO
implementation use gpiolib anyway wouldn't it be simpler and more
logical to directly require it?

If you have reasons for not doing so I'm ok with doing the switch
later too, anyway that's what I had to do for all the other archs.

Alex.
