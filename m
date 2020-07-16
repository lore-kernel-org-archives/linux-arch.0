From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v9 0/4] Introduce the for_each_set_clump macro
Date: Thu, 16 Jul 2020 14:49:35 +0200
Message-ID: <CACRpkdYyCNEUSOtCJMTm7t1z15oK7nH3KcTe5LreJAzZ0KtQuw@mail.gmail.com>
References: <cover.1593243079.git.syednwaris@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbgGPMts (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 08:49:48 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178C9C08C5C0
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 05:49:48 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r19so6924684ljn.12
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 05:49:48 -0700 (PDT)
In-Reply-To: <cover.1593243079.git.syednwaris@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Syed Nayyar Waris <syednwaris@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Arnd Bergmann <arnd@arndb.de>, Robert Richter <rrichter@marvell.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@verdurent.com>, linux-arch@vger.kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Syed,

sorry for taking so long. I was on vacation and a bit snowed
under by work.

On Sat, Jun 27, 2020 at 10:10 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:

> Since this patchset primarily affects GPIO drivers, would you like
> to pick it up through your GPIO tree?

I have applied the patches to an immutable branch and pushed
to kernelorg for testing (autobuilders will play with it I hope).

If all works fine I will merge this into my devel branch for v5.9.

It would be desirable if Andrew gave his explicit ACK on it too.

Yours,
Linus Walleij
