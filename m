Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932441AbeGCDQl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 2 Jul 2018 23:16:41 -0400
Received: from mail-wr0-f171.google.com (mail-wr0-f171.google.com [209.85.128.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4194324F9F
        for <linux-arch@vger.kernel.org>; Tue,  3 Jul 2018 03:16:40 +0000 (UTC)
Received: by mail-wr0-f171.google.com with SMTP id h10-v6so358135wrq.8
        for <linux-arch@vger.kernel.org>; Mon, 02 Jul 2018 20:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1530465325.git.ren_guo@c-sky.com> <8c855b4a175fffcb5c897865b7e3d2fe754f0099.1530465326.git.ren_guo@c-sky.com>
In-Reply-To: <8c855b4a175fffcb5c897865b7e3d2fe754f0099.1530465326.git.ren_guo@c-sky.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 2 Jul 2018 21:16:27 -0600
Message-ID: <CABGGisyOSc+Mh3rrEwazgayue7hqZtNuAxRt112VAhDTTEeDrQ@mail.gmail.com>
Subject: Re: [PATCH V2 02/19] csky: defconfig
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: ren_guo@c-sky.com
Cc: linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Message-ID: <20180703031627.K5ylXdkFVbBiGnef7aw0WKYjhWhU1UkaRLBwP694dGI@z>

On Sun, Jul 1, 2018 at 11:34 AM Guo Ren <ren_guo@c-sky.com> wrote:
>

Needs a commit msg. Perhaps some overview of what's in each config.

> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  arch/csky/configs/gx66xx_defconfig     | 549 +++++++++++++++++++++++++++++++++
>  arch/csky/configs/qemu_ck807_defconfig | 541 ++++++++++++++++++++++++++++++++
>  2 files changed, 1090 insertions(+)
>  create mode 100644 arch/csky/configs/gx66xx_defconfig
>  create mode 100644 arch/csky/configs/qemu_ck807_defconfig

Are these configs mutually exclusive? We try to have one kernel build
serve many platforms. So you'd probably want to divide things between
the 2 ABIs.

It looks like you still have lots of options enabled that I wouldn't
expect you to need. Start with something more minimal for what you
need to boot and support upstream.

For a full config, you can use allmodconfig at least to build test.

Rob
