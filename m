From: Michal Simek <monstr@seznam.cz>
Subject: Re: [PATCH 01/56] microblaze_v2: Kconfig patches
Date: Mon, 05 May 2008 08:36:07 +0200
Message-ID: <481EAAD7.2020000@seznam.cz>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz>	 <a4a778e34c66d126f5c4bf1ca423cf32950ea5ab.1209897266.git.monstr@monstr.eu> <fa686aa40805041424x26de27a1g16959e7b9c7ddbf2@mail.gmail.com>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.wifiinternet.cz ([89.31.47.1]:49161 "EHLO
	bor.wifiinternet.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750816AbYEEGfA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 5 May 2008 02:35:00 -0400
In-Reply-To: <fa686aa40805041424x26de27a1g16959e7b9c7ddbf2@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, Michal Simek <monstr@monstr.eu>

Hi Grant,

>> From: Michal Simek <monstr@monstr.eu>
>>
>>
>>  Signed-off-by: Michal Simek <monstr@monstr.eu>
> 
>>  diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
>>  new file mode 100644
>>  index 0000000..49767d1
>>  --- /dev/null
>>  +++ b/arch/microblaze/Kconfig
> <snip>
>>  +config XILINX_UNCACHED_SHADOW
>>  +       bool "Are you using uncached shadow for RAM ?"
>>  +       depends on MICROBLAZE
> 
> Isn't CONFIG_MICROBLAZE a given?

I forget to remove this option. I'll remove consistent.c file where was this
choice used.


>>  diff --git a/arch/microblaze/platform/Kconfig.platform b/arch/microblaze/platform/Kconfig.platform
>>  new file mode 100644
>>  index 0000000..64cbb80
>>  --- /dev/null
>>  +++ b/arch/microblaze/platform/Kconfig.platform
> <snip>
>>  +config HACK
>>  +       bool "Increase performance"
>>  +       default y
> 
> Is this appropriate for mainline?  If so, it should have a better
> description.  :-)

:-) Yes. A little bit.

Michal
