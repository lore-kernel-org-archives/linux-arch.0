From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC 1/5] gpiolib: factorize gpiod_get/set functions
Date: Fri, 20 Sep 2013 10:36:34 +0200
Message-ID: <CACRpkdZrjM0cQm8AXNDnaSh2Tp5BVcevDUObFg87cUTEmJxc1w@mail.gmail.com>
References: <1378294169-22661-1-git-send-email-acourbot@nvidia.com>
	<1378294169-22661-2-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:52255 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754226Ab3ITIge (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Sep 2013 04:36:34 -0400
Received: by mail-ob0-f173.google.com with SMTP id vb8so136381obc.4
        for <linux-arch@vger.kernel.org>; Fri, 20 Sep 2013 01:36:34 -0700 (PDT)
In-Reply-To: <1378294169-22661-2-git-send-email-acourbot@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Sep 4, 2013 at 1:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> gpiod_get/set functions share common code between their regular and
> cansleep variants. The exporting of the gpiod interface will make
> the situation worse. This patch factorizes the common code to avoid code
> redundancy.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

I don't see why this patch should be RFC?

I just rebased and applied it, it's a clean and nice refactoring.

Yours,
Linus Walleij
