From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/2] gpiolib: remove gpiochip_reserve()
Date: Sat, 2 Feb 2013 16:01:37 +0100
Message-ID: <CACRpkdbFTt3bN4y5QFMFq6dfAA3XOkKWF4FY5X4jcGfYbYvxOw@mail.gmail.com>
References: <1359816246-3979-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:53955 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757874Ab3BBPBh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 2 Feb 2013 10:01:37 -0500
Received: by mail-ia0-f182.google.com with SMTP id w33so6578446iag.13
        for <linux-arch@vger.kernel.org>; Sat, 02 Feb 2013 07:01:37 -0800 (PST)
In-Reply-To: <1359816246-3979-1-git-send-email-acourbot@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Dirk Opfer <dirk@opfer-online.de>, Grant Likely <grant.likely@secretlab.ca>, Eric Miao <eric.y.miao@gmail.com>, Russell King <linux@arm.linux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com

On Sat, Feb 2, 2013 at 3:44 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> If Dmitri could give his Acked-by or Tested-by and one of the GPIO maintainers
> merge this series, I could go ahead with the deeper changes to gpiolib.

Good riddance.

Both patches applied to get some rotation in linux-next.

This is too good stuff to wait and I like to push this work ahead
a bit. I can still back them out if there is some problem on the
TOSA.


Yours,
Linus Walleij
