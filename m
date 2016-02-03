Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54886 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933572AbcBCIVF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2016 03:21:05 -0500
Date: Wed, 3 Feb 2016 09:19:55 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/2] GPIO: Clean up asm/gpio.h
In-Reply-To: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <alpine.DEB.2.11.1602030919190.25254@nanos>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Message-ID: <20160203081955.F4vx41IirpvG6E-s5UHRNBfDd_rXU-zRQuutbNFKuBU@z>

On Tue, 2 Feb 2016, Bjorn Helgaas wrote:

> Many arches supply an asm/gpio.h that contains only this:
> 
>   #warning Include linux/gpio.h instead of asm/gpio.h
>   #include <linux/gpio.h>
> 
> These two patches change all the places that include asm/gpio.h
> so they include linux/gpio.h instead, and then remove the asm/gpio.h
> files.
> 
> There are several arches that supply asm/gpio.h with useful
> arch-specific content; I didn't touch those.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
