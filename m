From: John Williams <john.williams@petalogix.com>
Subject: Re: [PATCH 02/56] microblaze_v2: Makefiles for Microblaze cpu
Date: Mon, 05 May 2008 11:47:10 +1000
Message-ID: <1209952030.5798.32.camel@localhost>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz>
	 <a4a778e34c66d126f5c4bf1ca423cf32950ea5ab.1209897266.git.monstr@monstr.eu>
	 <c805caeb1dd7f6d1349c4a463cb88a5342a170d2.1209897266.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from uki.us.mooball.net ([66.98.178.13]:48705 "EHLO
	uki.us.mooball.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbYEEBrw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 21:47:52 -0400
In-Reply-To: <c805caeb1dd7f6d1349c4a463cb88a5342a170d2.1209897266.git.monstr@monstr.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>


> --- /dev/null
> +++ b/arch/microblaze/Makefile
> @@ -0,0 +1,63 @@
> +UTS_SYSNAME = -DUTS_SYSNAME=\"uClinux\"
> +
> +# What CPU vesion are we building for, and crack it open
> +# as major.minor.rev
> +CPU_VER=$(subst ",,$(CONFIG_XILINX_MICROBLAZE0_HW_VER) )
> +CPU_MAJOR=$(shell echo $(CPU_VER) | cut -d '.' -f 1)
> +CPU_MINOR=$(shell echo $(CPU_VER) | cut -d '.' -f 2)
> +CPU_REV=$(shell echo $(CPU_VER) | cut -d '.' -f 3)

No doubt there's some cleaner shell-fu to do this but I'm not
complaining as I'm responsible for the original yucky version!

> --- /dev/null
> +++ b/arch/microblaze/platform/Makefile
> @@ -0,0 +1,3 @@
> +#
> +# Makefile for arch/microblaze/platform directory
> +#

How about a single 

obj-$(CONFIG_PLATFORM_GENERIC) += generic/

to show how platform-specific setup code can be added (even though
there's none in the default generic target)?
