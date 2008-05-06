From: Michal Simek <monstr@seznam.cz>
Subject: Re: [PATCH 02/56] microblaze_v2: Makefiles for Microblaze cpu
Date: Tue, 06 May 2008 10:51:47 +0200
Message-ID: <48201C23.1040609@seznam.cz>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz>	 <a4a778e34c66d126f5c4bf1ca423cf32950ea5ab.1209897266.git.monstr@monstr.eu>	 <c805caeb1dd7f6d1349c4a463cb88a5342a170d2.1209897266.git.monstr@monstr.eu> <1209952030.5798.32.camel@localhost>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.wifiinternet.cz ([89.31.47.1]:51612 "EHLO
	bor.wifiinternet.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756489AbYEFIuu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 May 2008 04:50:50 -0400
In-Reply-To: <1209952030.5798.32.camel@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Williams <john.williams@petalogix.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>

Hi John,

>> --- /dev/null
>> +++ b/arch/microblaze/Makefile
>> @@ -0,0 +1,63 @@
>> +UTS_SYSNAME = -DUTS_SYSNAME=\"uClinux\"
>> +
>> +# What CPU vesion are we building for, and crack it open
>> +# as major.minor.rev
>> +CPU_VER=$(subst ",,$(CONFIG_XILINX_MICROBLAZE0_HW_VER) )
>> +CPU_MAJOR=$(shell echo $(CPU_VER) | cut -d '.' -f 1)
>> +CPU_MINOR=$(shell echo $(CPU_VER) | cut -d '.' -f 2)
>> +CPU_REV=$(shell echo $(CPU_VER) | cut -d '.' -f 3)
> 
> No doubt there's some cleaner shell-fu to do this but I'm not
> complaining as I'm responsible for the original yucky version!

I think you told me that toolchain can use this flags. This is not pain for now.
I'll add to my future plans.

>> --- /dev/null
>> +++ b/arch/microblaze/platform/Makefile
>> @@ -0,0 +1,3 @@
>> +#
>> +# Makefile for arch/microblaze/platform directory
>> +#
> 
> How about a single 
> 
> obj-$(CONFIG_PLATFORM_GENERIC) += generic/
> 
> to show how platform-specific setup code can be added (even though
> there's none in the default generic target)?

We'll add this to Microblaze readme file. Chapter: how to add platform specific
files.

M
