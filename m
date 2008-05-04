From: Michal Simek <monstr@seznam.cz>
Subject: Re: [PATCH 1/2] OF: Fix coding style violation in of_device.c and
 of_platform.c
Date: Sun, 04 May 2008 10:20:35 +0200
Message-ID: <481D71D3.7060703@seznam.cz>
References: <monstr@seznam.cz> <1209824532-7939-1-git-send-email-monstr@seznam.cz> <765c6c8053679c45eb370255a110f7bc680a8f25.1209824033.git.monstr@monstr.eu> <200805032304.58709.arnd@arndb.de>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.wifiinternet.cz ([89.31.47.1]:56421 "EHLO
	bor.wifiinternet.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752477AbYEDITS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 04:19:18 -0400
In-Reply-To: <200805032304.58709.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hi Arnd,

this is question to powerpc guys not to me. I haven't tried to compiled but I
think dcr.h is important header for powerpc.
I only fixed problem for Microblaze because we don't have these headers.

M

>>  
>>  #include <asm/errno.h>
>> +
>> +#ifdef CONFIG_PPC_PSERIES
>>  #include <asm/dcr.h>
>> +#endif
>>  
> 
> The patch looks basically good, but we normally try to not have an #include
> inside of #ifdef. If the file builds without this #include, maybe you should
> better leave it out entirely? Same for the ppc-pci.h in the other file.
> 
> 	Arnd <><
> 
