Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:39145 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S932288AbWGGTso (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 7 Jul 2006 15:48:44 -0400
Date: Fri, 7 Jul 2006 13:48:43 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [Kconfig] use disable command (was Re: [patch] s390 kconfig cleanup, 2nd version).
Message-ID: <20060707194843.GC1605@parisc-linux.org>
References: <1151670404.11575.5.camel@localhost> <20060630104103.0b394b20.akpm@osdl.org> <1152289149.6390.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152289149.6390.12.camel@localhost>
Sender: linux-arch-owner@vger.kernel.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, ak@suse.de, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, zippel@linux-m68k.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Jul 07, 2006 at 06:19:09PM +0200, Martin Schwidefsky wrote:
> > > +	depends on !PPC && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV && !ARM && !S390
> > 
> > Imagine not having crud like this in there.
> 
> And this patch uses the disable option to simplify a few config options,
> e.g. the above depends line.

Yes, but that's one which simply needs its conditions inverted.  eg:

@@ -713,7 +713,7 @@ config NVRAM
 
 config RTC
        tristate "Enhanced Real Time Clock Support"
-       depends on !PPC && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV && !ARM
+       depends on ALPHA || CRIS || H8300 || X86 || M32R || MIPS || SUPERH || (SPARC && PCI) || V850

(I suspect CRIS, H8300, V850 and M32R should not be in this list.
Presumably the maintainers are on this list; could they comment?)

