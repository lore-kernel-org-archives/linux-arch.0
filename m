Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:54682 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755881AbaIZVhz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Sep 2014 17:37:55 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 00/17] Cross-architecture definitions of relaxed MMIO accessors
Date: Fri, 26 Sep 2014 23:36:13 +0200
Message-ID: <3359318.XmOCYLZHTV@wuerfel>
In-Reply-To: <20140926134608.GT5182@n2100.arm.linux.org.uk>
References: <1411579056-16966-1-git-send-email-will.deacon@arm.com> <9197976.uQdLmtvIl1@wuerfel> <20140926134608.GT5182@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will.deacon@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "chris@zankel.net" <chris@zankel.net>, "cmetcalf@tilera.com" <cmetcalf@tilera.com>, "davem@davemloft.net" <davem@davemloft.net>, "deller@gmx.de" <deller@gmx.de>, "dhowells@redhat.com" <dhowells@redhat.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "hpa@zytor.com" <hpa@zytor.com>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>, "mingo@redhat.com" <mingo@redhat.com>, "monstr@monstr.eu" <monstr@monstr.eu>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "sam@ravnborg.org" <sam@ravnborg.org>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "starvik@axis.com" <starvik@axis.com>, "takata@linux-m32r.org" <takata@linux-m32r.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "tony.luck@intel.com" <tony.luck@intel.com>, "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>, "broonie@linaro.org" <broonie@linaro.org>
Message-ID: <20140926213613.r9f3Ey8ktSX4uIx7NabO4wrRrjtoLKZLuO4E6Wg5grk@z>

On Friday 26 September 2014 14:46:08 Russell King - ARM Linux wrote:
> 
> Obviously, this does nothing for the:
> 
> include/asm-generic/io.h:804:29: error: redefinition of 'virt_to_bus'
> include/asm-generic/io.h:809:21: error: redefinition of 'bus_to_virt'
> 
> errors which are also reported in Olof's build system.
> 
> Given how close we are to the merge window, I'd suggest this stuff gets
> reverted so that it can have a better period of testing, rather than
> stuffing it into -next at such a critical time.

Right, I've fixed these all up locally, but then found new warnings on
allmodconfig builds that I haven't been able to track down yet.

I've dropped everything from the asm-generic tree now, so we can get
a clean linux-next tree.

	Arnd
