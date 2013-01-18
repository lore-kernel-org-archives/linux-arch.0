From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 31/76] ARC: Build system: Makefiles, Kconfig, Linker script
Date: Fri, 18 Jan 2013 19:25:36 +0000
Message-ID: <201301181925.36466.arnd@arndb.de>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-32-git-send-email-vgupta@synopsys.com> <20130118190452.GA14433@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:63182 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab3ARTZq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2013 14:25:46 -0500
In-Reply-To: <20130118190452.GA14433@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 18 January 2013, Sam Ravnborg wrote:
> > +obj-y        := arcksyms.o setup.o irq.o time.o reset.o ptrace.o entry.o process.o \
> > +        signal.o traps.o sys.o troubleshoot.o stacktrace.o clk.o
> 
> For new stuff I usually recommend to drop line continuation using \
> 
> Just do the much prettier:
> obj-y := arcksyms.o setup.o irq.o time.o reset.o ptrace.o entry.o process.o
> obj-y += signal.o traps.o sys.o troubleshoot.o stacktrace.o clk.o

Agreed, although we are moving some files to the more verbose

obj-y += arcksyms.o
obj-y += clk.o
obj-y += entry.o
obj-y += ...

and use alphabetical order, both of which help avoid merge conflicts
when Makefile changes come in through separate branches. This 
particular Makefile is likely to remain rather stable though, so
it's not necessary to go this far.

	Arnd
