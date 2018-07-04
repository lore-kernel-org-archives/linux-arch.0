Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:46289 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932399AbeGDKwW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jul 2018 06:52:22 -0400
Date: Wed, 4 Jul 2018 18:51:50 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 13/19] csky: Library functions
Message-ID: <20180704105150.GA21269@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <7a1490b307d8e62cebe80ebc03fea6bad8b0f227.1530465326.git.ren_guo@c-sky.com>
 <CAK8P3a3jqib-GiWcRVo6ds8Q50nZTaRmC3ACW5xJJVJzV6=7NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3jqib-GiWcRVo6ds8Q50nZTaRmC3ACW5xJJVJzV6=7NA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Message-ID: <20180704105150.-CjxoqVNRA2qpF-P5x1A3xEc9kq0nEgd2PXZyveh6kg@z>

On Tue, Jul 03, 2018 at 10:04:57PM +0200, Arnd Bergmann wrote:
> It's better to avoid relying on libgcc here. Please use the
> CONFIG_GENERIC_LIB_ASHLDI3/ASHRDI3/LSHRDI3/etc
> helpers that we already have in the kernel.
Ok, I'll try

Guo Ren
