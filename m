From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/4] arch: Clean up asm/barrier.h implementations using asm-generic/barrier.h
Date: Mon, 11 Nov 2013 23:04:49 +0000
Message-ID: <24054.1384211089@warthog.procyon.org.uk>
References: <1426746962.63022.1383906498239.JavaMail.zimbra@efficios.com> <20131108062645.GB2693@Krystal>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38327 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369Ab3KKXFz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Nov 2013 18:05:55 -0500
In-Reply-To: <1426746962.63022.1383906498239.JavaMail.zimbra@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: dhowells@redhat.com, peterz@infradead.org, linux-arch@vger.kernel.org, geert@linux-m68k.org, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, VICTORK@il.ibm.com, oleg@redhat.com, anton@samba.org, benh@kernel.crashing.org, fweisbec@gmail.com, michael@ellerman.id.au, mikey@neuling.org, linux@arm.linux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, tony.luck@intel.com

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > > +#ifndef nop
> > > +#define nop()	asm volatile ("nop")
> > > +#endif
> > >  
> > 
> > I don't really understand why "no-op" sits within barrier.h. It might be
> > a lack of imagination on my part though.

I didn't want to create yet another header file just to hold that.

David
