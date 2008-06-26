From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 48/60] microblaze_v4: headers simple files - empty or redirect to asm-generic
Date: Thu, 26 Jun 2008 17:35:11 +0200
Message-ID: <200806261735.12738.arnd@arndb.de>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz> <1214483429-32360-48-git-send-email-monstr@seznam.cz> <1214483429-32360-49-git-send-email-monstr@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.174]:61013 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbYFZPfo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jun 2008 11:35:44 -0400
In-Reply-To: <1214483429-32360-49-git-send-email-monstr@seznam.cz>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk, hpa@zytor.com, Michal Simek <monstr@monstr.eu>

On Thursday 26 June 2008, monstr@seznam.cz wrote:
> +
> +#ifndef _ASM_MICROBLAZE_NAMEI_H
> +#define _ASM_MICROBLAZE_NAMEI_H
> +
> +#ifdef __KERNEL__
> +
> +/* This dummy routine maybe changed to something useful
> + * for /usr/gnemul/ emulation stuff.
> + * Look at asm-sparc/namei.h for details.
> + */
> +#define __emul_prefix() NULL
> +
> +#endif /* __KERNEL__ */
> +
> +#endif /* _ASM_MICROBLAZE_NAMEI_H */

Could you move this to asm-generic? Note that the comment is wrong,
asm-sparc doesn't actually implement it any more, only ia64, mips and
arm have an implementation that actually does something interesting
here.

	Arnd <><
