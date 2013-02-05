From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 5/9] gpiolib: use gpio_chips list in gpiochip_find_base
Date: Tue, 5 Feb 2013 18:21:06 +0100
Message-ID: <CACRpkdYT4p8uez8DHTSsjKFb=KmWbtCXJQtyXLAJkCC7fKaErw@mail.gmail.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
	<1359822572-26009-7-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:54061 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941Ab3BERVI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Feb 2013 12:21:08 -0500
Received: by mail-ie0-f170.google.com with SMTP id c11so557700ieb.1
        for <linux-arch@vger.kernel.org>; Tue, 05 Feb 2013 09:21:06 -0800 (PST)
In-Reply-To: <1359822572-26009-7-git-send-email-acourbot@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>, Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, gnurou@gmail.com

On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> Re-implement gpiochip_find_base using the list of chips instead of the
> global gpio_desc[] array. This makes it both simpler and more efficient,
> and is needed to remove the global descriptors array.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

So Haojian just submitted a different patch to the same piece of
code staring to search for GPIO number in ascending order instead,
but I NACKed it.

This looks like it is preserving this userspace-sensitive semantic
so that dynamically added chips will still get the same assigned
numbers.

But I want some guarantees, so state clearly in the commit
that any dynamically assigned chip will get the same base
address after this change as it got before it, and please take
this opportunity to add a comment stating that this search
method is vital for userspace ABIs, and must be preserved.

Yours,
Linus Walleij
