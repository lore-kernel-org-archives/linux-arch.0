From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/12] unicore32 machine related files: pci bus handling
Date: Thu, 17 Feb 2011 18:19:52 +0100
Message-ID: <201102171819.52845.arnd@arndb.de>
References: <015501cbcdae$6961c5d0$3c255170$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59755 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab1BQRT7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2011 12:19:59 -0500
In-Reply-To: <015501cbcdae$6961c5d0$3c255170$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 'Greg KH' <greg@kroah.com>

On Wednesday 16 February 2011, Guan Xuetao wrote:
> +{
> +       PCICFG_ADDR = CONFIG_CMD(bus, devfn, where);
> +       switch (size) {
> +       case 1:
> +               *value = (PCICFG_DATA >> ((where & 3) * 8)) & 0xFF;
> +               break;
> +       case 2:

It took me a while to figure out what this actually does. PCICFG_ADDR
and PCICFG_DATA are pointers to MMIO registers, which you should not
simply dereference. A lot of things can go wrong there, especially
if future machines move to weakly ordered I/O subsystem or have
multiple CPUs, but even for the simple case, the compiler has
a lot of ways to mess this up.

As explained in my reply to the "hardware registers" patch, all these
pointers should be marked as __iomem, so that sparse warns about
dangerous accesses such as the one here.

The code above should be written as

{
       writel(CONFIG_CMD(bus, devfn, where), PCICFG_ADDR);
       switch (size) {
       case 1:
               *value = readl(PCICFG_DATA >> ((where & 3) * 8)) & 0xFF;
               break;
       case 2:

	Arnd
