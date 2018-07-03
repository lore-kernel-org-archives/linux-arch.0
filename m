Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932198AbeGCDeE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 2 Jul 2018 23:34:04 -0400
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA49F24EE1
        for <linux-arch@vger.kernel.org>; Tue,  3 Jul 2018 03:34:03 +0000 (UTC)
Received: by mail-wm0-f43.google.com with SMTP id w16-v6so669187wmc.2
        for <linux-arch@vger.kernel.org>; Mon, 02 Jul 2018 20:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1530465325.git.ren_guo@c-sky.com> <a26901aab87306c389e656a3ef200adfbc5195c0.1530465325.git.ren_guo@c-sky.com>
In-Reply-To: <a26901aab87306c389e656a3ef200adfbc5195c0.1530465325.git.ren_guo@c-sky.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 2 Jul 2018 21:33:51 -0600
Message-ID: <CABGGiswb+SmdAi9qV80Yum3Uf=ohrSMpZKWkvJXK8n=GjTzxhQ@mail.gmail.com>
Subject: Re: [PATCH V2 01/19] csky: Build infrastructure
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: ren_guo@c-sky.com
Cc: linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Message-ID: <20180703033351.BUsYso4M1svlNgRLKnj77mQgp4DqzhQgliBY8-3RSy4@z>

On Sun, Jul 1, 2018 at 11:36 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---

[...]

> +config CSKY_BUILTIN_DTB
> +       bool "Use kernel builtin dtb"
> +
> +config CSKY_BUILTIN_DTB_NAME
> +       string "kernel builtin dtb name"
> +       depends on CSKY_BUILTIN_DTB
> +endmenu

These options generally exist for backwards compatibility with legacy
bootloaders that don't support DT which shouldn't apply here given
this is a new arch. If we need this for other reasons, it should not
be an architecture specific option.

Rob
