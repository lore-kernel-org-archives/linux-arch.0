From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH v3 2/4] asm-generic: Provide a fncpy() implementation
Date: Mon, 19 Jun 2017 04:11:05 +0300
Message-ID: <20170619011105.gjkisjrrtzlmgk6s@yury-thinkpad>
References: <20170617000744.22158-1-f.fainelli@gmail.com>
 <20170617000744.22158-3-f.fainelli@gmail.com>
 <20170618235108.peaxdi367jpkt542@yury-thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam03on0052.outbound.protection.outlook.com ([104.47.42.52]:44526
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753020AbdFSBLR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 18 Jun 2017 21:11:17 -0400
Content-Disposition: inline
In-Reply-To: <20170618235108.peaxdi367jpkt542@yury-thinkpad>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Keerthy J <j-keerthy@ti.com>, Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org

> > +/*
> > + * Minimum alignment requirement for the source and destination addresses
> > + * for function copying.
> > + */
> > +#define FNCPY_ALIGN 8
> 
> >From now this is not arm-only, and it's possible that some architectures
> might want to redefine it in their arch/xxx/include/asm/fncpy.h files.
> So it will be easier for them if you'll wrap FNCPY_ALIGN here with #ifdef
> guards.
> 
> By the way, compiler already has an information on the proper alignment.
> Maybe it's better to use it as the default value here instead of the
> hardcoded value?
> 
> #ifndef FNCPY_ALIGN
> #define FNCPY_ALIGN ({void foo(); __alignof__(&foo);})
> #endif

Ah sorry, at first it should be like this:
#define FNCPY_ALIGN ({void foo(); __alignof__(foo);})

And at second, the correct version returns 1 always.

Even if I pass falign-functions=4096 to gcc, and I see that functions
are aligned accordingly in elf file, the macro returns 1 anyway. So if 
it doesn't work, the hardcoded '8' is the only option.

Yury
