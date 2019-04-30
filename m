Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44028 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbfD3NZk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Apr 2019 09:25:40 -0400
MIME-Version: 1.0
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
 <20190402161256.11044-3-daniel.lezcano@linaro.org> <1555922585.26198.19.camel@intel.com>
 <fb45157c-38c4-7940-3252-af459d446323@linaro.org> <1555999165.26198.39.camel@intel.com>
 <2c0bc40d-328a-fc96-73da-9d65fee253fb@linaro.org>
In-Reply-To: <2c0bc40d-328a-fc96-73da-9d65fee253fb@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 30 Apr 2019 15:25:21 +0200
Message-ID: <CAK8P3a2LAZnBKigo9v0qzaa-WAYkuoueF_jyJtaFrMeLXnDDow@mail.gmail.com>
Subject: Re: [PATCH 3/7] thermal/drivers/core: Add init section table for self-encapsulation
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Message-ID: <20190430132521.rwqAs-GUK9iT7RqCAEnxBzJGjwRqBs3YSXwIQP7xKyY@z>

On Mon, Apr 29, 2019 at 1:23 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 23/04/2019 07:59, Zhang Rui wrote:
> > Hi, Daniel,
> >
> > thanks for clarifying.
> > It is true that we need to make thermal framework ready as early as
> > possible. And a static table works for me as long as vmlinux.lds.h is
> > the proper place.
> >
> > Arnd,
> > are you okay with this patch? if yes, I suppose I can take it through
> > my tree, right?
>
> Arnd?

Sorry for missing this earlier. I have no objections to this, or to merging
it through the thermal tree.

Acked-by: Arnd Bergmann <arnd@arndb.de>
