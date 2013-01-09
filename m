From: Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH 1/4] gpiolib: introduce descriptor-based GPIO interface
Date: Wed, 9 Jan 2013 10:06:16 +0900
Message-ID: <CAAVeFu+4VbCbj9TaeMm+NMDJ9_M4-j4O0ONF7Yh_un63wS38+Q@mail.gmail.com>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
 <1357629535-26033-2-git-send-email-acourbot@nvidia.com> <201301081259.29839.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:51153 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806Ab3AIBGh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jan 2013 20:06:37 -0500
In-Reply-To: <201301081259.29839.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Tue, Jan 8, 2013 at 9:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Please avoid the use of IS_ERR_OR_NULL(), especially on interfaces you
> introduce yourself. AFAICT, gpiod_get cannot return NULL, so you
> should not check for that.

Sure - you sound like IS_ERR_OR_NULL() is generally considered evil,
may I ask why this is the case?

>> +       *dr = desc;
>> +       devres_add(dev, dr);
>> +
>> +       return 0;
>> +}
>
> I'm pretty sure you meant to write 'return desc;' here.

Absolutely, thanks.

Alex.
