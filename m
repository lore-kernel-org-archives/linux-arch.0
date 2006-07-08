Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:1254 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1030423AbWGHXmX
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 8 Jul 2006 19:42:23 -0400
Received: from localhost.localdomain ([127.0.0.1]:3258 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133583AbWGHXmW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jul 2006 00:42:22 +0100
Date: Sun, 9 Jul 2006 00:42:00 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [Kconfig] use disable command (was Re: [patch] s390 kconfig cleanup, 2nd version).
Message-ID: <20060708234200.GA2729@linux-mips.org>
References: <1151670404.11575.5.camel@localhost> <20060630104103.0b394b20.akpm@osdl.org> <1152289149.6390.12.camel@localhost> <20060707194843.GC1605@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707194843.GC1605@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, ak@suse.de, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, zippel@linux-m68k.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Jul 07, 2006 at 01:48:43PM -0600, Matthew Wilcox wrote:

>  config RTC
>         tristate "Enhanced Real Time Clock Support"
> -       depends on !PPC && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV && !ARM
> +       depends on ALPHA || CRIS || H8300 || X86 || M32R || MIPS || SUPERH || (SPARC && PCI) || V850
> 
> (I suspect CRIS, H8300, V850 and M32R should not be in this list.
> Presumably the maintainers are on this list; could they comment?)

Making this depend on the CPU is grosly simplifying things - and wrong.  On
MIPS the MC146818 is used in several systems but not all and chances are
the driver will crash the system if selected on some of the systems.  So
in the end I would suggeste something like in drivers/char/Kconfig:

config RTC
	tristate "Enhanced Real Time Clock Support"
	depends on SYS_HAS_MC146818

config SYS_HAS_MC146818
	bool

and somewhere from arch/*/Kconfig SYS_HAS_MC146818 will have to be selected.

The other rant of course is that the symbol CONFIG_RTC looks like it is
generic RTC support while it really only is for MC146818 and lookalikes.
So it should be renamed to something like CONFIG_MC146818.

  Ralf
