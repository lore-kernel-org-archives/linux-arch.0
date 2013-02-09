Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:54312 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537Ab3BIKKE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 9 Feb 2013 05:10:04 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr12so3481502wgb.23
        for <linux-arch@vger.kernel.org>; Sat, 09 Feb 2013 02:10:03 -0800 (PST)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/9] gpiolib: use gpio_chips list in gpiolib_sysfs_init
In-Reply-To: <CACRpkdaz8h_1uKoH1q9gLmCxE0BMAxBakaq_eFfnfJr2V_Ct5w@mail.gmail.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com> <1359822572-26009-4-git-send-email-acourbot@nvidia.com> <CACRpkdaz8h_1uKoH1q9gLmCxE0BMAxBakaq_eFfnfJr2V_Ct5w@mail.gmail.com>
Date: Sat, 09 Feb 2013 09:22:32 +0000
Message-ID: <20130209092232.64D0A3E2C01@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, gnurou@gmail.com
Message-ID: <20130209092232.JDe8mr7d6BGRwlMC9qagpBRzm7vdEIzWP9GkRJobVfE@z>

On Tue, 5 Feb 2013 18:04:43 +0100, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> 
> > Use the small list of GPIO chips instead of parsing the whole GPIO
> > number space.
> >
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 

Applied, thanks.

g.

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
