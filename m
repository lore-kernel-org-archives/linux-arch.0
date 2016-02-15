Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35544 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbcBONfv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Feb 2016 08:35:51 -0500
Received: by mail-ob0-f180.google.com with SMTP id xk3so211264004obc.2
        for <linux-arch@vger.kernel.org>; Mon, 15 Feb 2016 05:35:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160202195323.10827.26654.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20160202195323.10827.26654.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Date: Mon, 15 Feb 2016 14:35:51 +0100
Message-ID: <CACRpkdYYtvTa91WW10oNs9KkqMfPCJhpZLcW5ksfyxG6F1cO7w@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: Include linux/gpio.h instead of asm/gpio.h
From: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20160215133551.wVD73pO20HJMBSId5iwxP1NmLvNBvdMFyHIpMy3Xjjc@z>

On Tue, Feb 2, 2016 at 8:53 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:

> Most arches have an asm/gpio.h that merely includes linux/gpio.h.  The
> others select ARCH_HAVE_CUSTOM_GPIO_H, and when that's selected,
> linux/gpio.h includes asm/gpio.h.
>
> Therefore, code should include linux/gpio.h instead of including asm/gpio.h
> directly.
>
> Remove includes of asm/gpio.h, adding an include of linux/gpio.h when
> necessary.
>
> This is a follow-on to 7563bbf89d06 ("gpiolib/arches: Centralise
> bolierplate asm/gpio.h").
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Patch applied after getting Arnds ACK over IRC.

Yours,
Linus Walleij
