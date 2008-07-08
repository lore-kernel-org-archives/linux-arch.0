From: Michal Simek <monstr@seznam.cz>
Subject: Re: [PATCH 31/60] microblaze_v4: memory inicialization, MMU, TLB
Date: Tue, 08 Jul 2008 08:17:57 +0200
Message-ID: <48730695.5010004@seznam.cz>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>	<1214483429-32360-31-git-send-email-monstr@seznam.cz>	<1214483429-32360-32-git-send-email-monstr@seznam.cz> <200806261714.12967.arnd@arndb.de>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mxl.seznam.cz ([77.75.72.44]:45762 "EHLO mxl.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453AbYGHGao (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 8 Jul 2008 02:30:44 -0400
In-Reply-To: <200806261714.12967.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk, Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org, drepper@redhat.com, linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com, John.Linn@xilinx.com, john.williams@petalogix.com

Hi Arnd,

> On Thursday 26 June 2008, monstr@seznam.cz wrote:
> 
>> +#include <linux/autoconf.h>
> 
> You should never need to include linux/autoconf.h anywhere,
> just remove this.

Remove from all files

>> +#include <linux/init.h>
>> +#include <linux/mm.h>
>> +#include "../../../mm/internal.h"
> 
> Why do you need to include the internal.h file here?
> If you have a good reason to do it, you should probably
> add the symbol you need to a global header file.

There was reason for doing it in older version. With current
version work without internal.h.

Thank for comment,
Michal



> 	Arnd <><
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 
> ------------------------------------------------------------------------
> 
> 
> No virus found in this incoming message.
> Checked by AVG. 
> Version: 8.0.101 / Virus Database: 270.4.1/1519 - Release Date: 25.6.2008 04:13
