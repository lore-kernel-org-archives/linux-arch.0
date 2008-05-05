From: Michal Simek <monstr@seznam.cz>
Subject: Re: [PATCH 1/2] OF: Fix coding style violation in of_device.c and
 of_platform.c
Date: Mon, 05 May 2008 08:33:19 +0200
Message-ID: <481EAA2F.7060101@seznam.cz>
References: <monstr@seznam.cz> <200805032304.58709.arnd@arndb.de> <481D71D3.7060703@seznam.cz> <200805042142.45872.arnd@arndb.de>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.wifiinternet.cz ([89.31.47.1]:56671 "EHLO
	bor.wifiinternet.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753775AbYEEGcI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 5 May 2008 02:32:08 -0400
In-Reply-To: <200805042142.45872.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hi Arnd,

>> this is question to powerpc guys not to me. I haven't tried to compiled but I
>> think dcr.h is important header for powerpc.
>> I only fixed problem for Microblaze because we don't have these headers.
> 
> A google search on "microblaze DCR" shows a number of results, leading me to
> the conclusion that microblaze actually does have DCR registers. In that
> case, the best option should be to just implement a dcr.h based on 
> asm-powerpc/dcr-native.h.

You are right. Google can find a lot of things. :-)

Microblaze doesn't have any DCR instruction. If you want to use DCR you will
have to add bridge to design but I think 99,5% of designs don't have it. (Maybe
older from EDK 6 had).

Michal
