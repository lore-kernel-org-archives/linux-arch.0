From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/14] score - New architecure port to SunplusCT S+CORE
Date: Thu, 14 May 2009 10:44:55 +0200
Message-ID: <200905141044.56426.arnd@arndb.de>
References: <OFC83335DE.A18F9B53-ON48257592.00273C99-48257592.002856A8@sunplusct.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:63199 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbZENIpH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 May 2009 04:45:07 -0400
In-Reply-To: <OFC83335DE.A18F9B53-ON48257592.00273C99-48257592.002856A8@sunplusct.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, Sam Ravnborg <sam@ravnborg.org>, Thomas Gleixner <tglx@linutronix.de>, Kyle McMartin <kyle@mcmartin.ca>

Hi Liquin,

Have you had a chance to look at the asm-generic header files I posted
a few times?

I think it would be ideal if you can change your code to use the
asm-generic version whereever possible, by replacing your files
with something like

arch/score/include/asm/foo.h:
#include <asm-generic/foo.h>

In particular, all of the exported header files that get included
in user space should use only the asm-generic version, with the
exception of byteorder.h, elf.h and ptrace.h, which are by definition
architecture specific.

Please tell me if you find problems in the generic header files during
the conversion.

	Arnd <><
