Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268581AbUJTQUZ@vger.kernel.org>
Received: from mtagate4.de.ibm.com ([195.212.29.153]:8386 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S268436AbUJTQRk
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Oct 2004 12:17:40 -0400
In-Reply-To: <20041020152923.GC32257@wotan.suse.de>
Subject: Re: 4level page tables architecture porting
Message-ID: <OF94E60A42.12375CAD-ON42256F33.005836AA-42256F33.00597F58@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Wed, 20 Oct 2004 18:17:33 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
To: Andi Kleen <ak@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>





> But I see you're using order 1 pages on s390x, in case your hardware
> supports 4levels with order 0 pages it may be cheaper to use that.

It even worse, we do order-2 allocations for the pgd table. There is
a way to use partial region tables but that creates "holes" in the
virtual memory. One way to use this is to make a 2TB hole starting
from 2TB. Effectivly this reduces the virtual memory size to 2TB and
halves the size of the pgd table. If we want to use 4TB we have to use
4 consecutive pages in memory for the pgd table.

> > rather like to see a way to use a dynamic page table layout, where 32 bit
> > tasks always use only two level page tables, while 64 bit tasks start
> > with two or three levels and then go to four or five levels when users
> > map files that don't fit in.
>
> I don't see how that would work. The stack is always at the top
> and .text is near the beginning, so you need the maximum range of
> address space, which means all possible levels.

There are two possible ways to use this: 1) for 31 bit processes running
under a 64 bit kernel, or 2) don't let the stack start at the end of
memory. For 1) the stack starts at 2GB which is the end of memory for
a 31 bit process. 2) would require to rearrange the memory layout which
is in principle possible.

I prefer the pte_iterator idea to 4 level page tables since that allows
the architecture to decide about how many levels of page tables are
required for a particular memory layout.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH
