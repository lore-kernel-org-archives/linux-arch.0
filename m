From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH v3 2/4] asm-generic: Provide a fncpy() implementation
Date: Tue, 20 Jun 2017 17:27:02 +0300
Message-ID: <20170620142702.mmks36ydoujvvhan@yury-thinkpad>
References: <20170617000744.22158-1-f.fainelli@gmail.com>
 <20170617000744.22158-3-f.fainelli@gmail.com>
 <20170618235108.peaxdi367jpkt542@yury-thinkpad>
 <20170619151818.pvjygbdvm6arvarq@yury-thinkpad>
 <20170619174348.GA23750@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170619174348.GA23750@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Keerthy J <j-keerthy@ti.com>, Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, open list <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Mon, Jun 19, 2017 at 06:43:48PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 19, 2017 at 06:18:18PM +0300, Yury Norov wrote:
> > One else thing I forgot to ask - now you have the generic
> > implementation for fncpy(), so do you really need to save arm
> > version of it?
> 
> This was covered in the review of v1, which took the ARM version
> and incorrectly used it as an asm-generic implementation.
> 
> I explicitly asked Florian _not_ to copy the ARM fncpy() version
> to asm-generic because it has (surprise surprise) ARM specific
> behaviours that do not belong in a cross-architecture generic
> version.
> 
> Namely, the ARM specific behaviour that bit 0 of a code address is
> used to signal whether the code should be executed as ARM code or
> as Thumb code.
> 
> This behaviour has no meaning on other architectures (eg, x86)
> where code addresses are not 32-bit aligned.
> 
> So, suggesting that the ARM fncpy() should be used as an asm-generic
> version is completely absurd, and just because we have an asm-generic
> version also does not mean ARM should use it.
> 
> Florian's approach to providing an asm-generic version, leaving the
> ARM specific version is entirely correct and appropriate.
> 
> So, in answer to your question, yes, we need _both_ an ARM specific
> version and an asm-generic version, where the ARM specific version is
> different from the asm-generic version.  Purely because it needs
> architecture specific details.

Hi Russell, Florian,

Thanks for clarifications. Thumb bit is a good reason to save arm
version, and I completely agree with you in this. Sorry that missed it
in the v1 discussion.

> I explicitly asked Florian _not_ to copy the ARM fncpy() version
> to asm-generic because it has (surprise surprise) ARM specific
> behaviours that do not belong in a cross-architecture generic
> version.

But it seems that v3 does exactly that - copies arm with very small
changes. :) Maybe there are good reasons to have arm version exactly
how it looks now, but in general case, for me, some things that
it does are not needed. I mean checking the alignment of the source and
the type of destination. And after some headscratching I became even
more convinced that for the general case it would be much preferable
to write the fncpy() as regular function in .c file, not a macro, at
least to have the corresponding symbol in binary and let the assembler
code to call it, which is very probable.

Yury
