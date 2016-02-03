From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH 2/2] gpio: Remove unused asm/gpio.h files
Date: Wed, 3 Feb 2016 09:03:16 +0900
Message-ID: <CAAVeFu+A4OKZL4WuR7R9fLcDc9W9rF7GLywQw0oYjUa-vWM+mA@mail.gmail.com>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160202195330.10827.68542.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34842 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbcBCADg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2016 19:03:36 -0500
In-Reply-To: <20160202195330.10827.68542.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Feb 3, 2016 at 4:53 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> asm/gpio.h is included only by linux/gpio.h, and then only when the arch
> selects ARCH_HAVE_CUSTOM_GPIO_H.  Only the following arches select it: arm
> avr32 blackfin m68k (COLDFIRE only) sh unicore32.
>
> Remove the unused asm/gpio.h files for the arches that do not select
> ARCH_HAVE_CUSTOM_GPIO_H.
>
> This is a follow-on to 7563bbf89d06 ("gpiolib/arches: Centralise
> bolierplate asm/gpio.h").

Very nice.

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
