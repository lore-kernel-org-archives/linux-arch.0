Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:57757 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014Ab3BDUmi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Feb 2013 15:42:38 -0500
Received: by mail-ie0-f172.google.com with SMTP id c10so6378929ieb.31
        for <linux-arch@vger.kernel.org>; Mon, 04 Feb 2013 12:42:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAN1soZxOX24QCYOTXmVOmNGu-+ShUPaBScxh38C=p7-v_2OZnw@mail.gmail.com>
References: <1359816246-3979-1-git-send-email-acourbot@nvidia.com>
	<1359816246-3979-2-git-send-email-acourbot@nvidia.com>
	<CAN1soZxOX24QCYOTXmVOmNGu-+ShUPaBScxh38C=p7-v_2OZnw@mail.gmail.com>
Date: Mon, 4 Feb 2013 21:42:37 +0100
Message-ID: <CACRpkdY83TqF5zzKrD1LNQ1reL5Z+HPKHAWwLxLWj4fYr3SSZw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: pxa: tosa: do not use gpiochip_reserve()
From: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Dirk Opfer <dirk@opfer-online.de>, Grant Likely <grant.likely@secretlab.ca>, Eric Miao <eric.y.miao@gmail.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-arch@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, gnurou@gmail.com
Message-ID: <20130204204237.TiILmYGZuq-VI_n1pVzsht9Kb2_XReihCJi2xSTjM34@z>

On Sun, Feb 3, 2013 at 1:29 AM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:

> Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>

Thanks!

> Linus,
>
> Could you help to merge this patch into your gpio git tree? I think
> that both of them should go through one git tree.

Yep, already merged it.

Yours,
Linus Walleij
