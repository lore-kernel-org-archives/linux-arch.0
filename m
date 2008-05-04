From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] OF: Fix coding style violation in of_device.c and of_platform.c
Date: Sun, 4 May 2008 21:42:45 +0200
Message-ID: <200805042142.45872.arnd@arndb.de>
References: <monstr@seznam.cz> <200805032304.58709.arnd@arndb.de> <481D71D3.7060703@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:52883 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580AbYEDTmv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 15:42:51 -0400
In-Reply-To: <481D71D3.7060703@seznam.cz>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sunday 04 May 2008, Michal Simek wrote:
> this is question to powerpc guys not to me. I haven't tried to compiled but I
> think dcr.h is important header for powerpc.
> I only fixed problem for Microblaze because we don't have these headers.

A google search on "microblaze DCR" shows a number of results, leading me to
the conclusion that microblaze actually does have DCR registers. In that
case, the best option should be to just implement a dcr.h based on 
asm-powerpc/dcr-native.h.

	Arnd <><
