From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [Linux-Xtensa] [PATCH v3 11/17] xtensa: move built-in PIC to
 drivers/irqchip
Date: Sun, 1 Dec 2013 10:18:22 +0200
Message-ID: <20131201081822.GG4302@tarshish>
References: <1385885097-28972-1-git-send-email-jcmvbkbc@gmail.com>
 <1385885097-28972-2-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:36606 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848Ab3LAISY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 1 Dec 2013 03:18:24 -0500
Content-Disposition: inline
In-Reply-To: <1385885097-28972-2-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org

Hi Max,

On Sun, Dec 01, 2013 at 12:04:56PM +0400, Max Filippov wrote:
> Extract xtensa built-in interrupt controller implementation from
> xtensa/kernel/irq.c and move it to other irqchips, providing way to
> instantiate it from the device tree.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v1 -> v3:
> - update compatible string for PIC irqchip

[...]

>  #ifdef CONFIG_OF
> -	/* The interrupt controller device node is mandatory */
> -	intc = of_find_compatible_node(NULL, NULL, "xtensa,pic");

[...]

> +IRQCHIP_DECLARE(xtensa_irq_chip, "cdns,xtensa-pic", xtensa_pic_init);

This changes the binding for an existing in-tree user 
(arch/xtensa/boot/dts/xtfpga.dtsi). I think this user should also be updated.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
