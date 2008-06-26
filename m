From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 31/60] microblaze_v4: memory inicialization, MMU, TLB
Date: Thu, 26 Jun 2008 17:14:11 +0200
Message-ID: <200806261714.12967.arnd@arndb.de>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz> <1214483429-32360-31-git-send-email-monstr@seznam.cz> <1214483429-32360-32-git-send-email-monstr@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:58745 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbYFZPOu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jun 2008 11:14:50 -0400
In-Reply-To: <1214483429-32360-32-git-send-email-monstr@seznam.cz>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk, hpa@zytor.com, Michal Simek <monstr@monstr.eu>

On Thursday 26 June 2008, monstr@seznam.cz wrote:

> +#include <linux/autoconf.h>

You should never need to include linux/autoconf.h anywhere,
just remove this.

> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include "../../../mm/internal.h"

Why do you need to include the internal.h file here?
If you have a good reason to do it, you should probably
add the symbol you need to a global header file.

	Arnd <><
