Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:15551 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S932514AbWCHIZX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2006 03:25:23 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
Subject: Re: [PATCH] Document Linux's memory barriers
Date: Wed, 8 Mar 2006 09:25:18 +0100
References: <1141756825.31814.75.camel@localhost.localdomain> <31492.1141753245@warthog.cambridge.redhat.com> <9551.1141762147@warthog.cambridge.redhat.com>
In-Reply-To: <9551.1141762147@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603080925.19425.duncan.sands@math.u-psud.fr>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tuesday 7 March 2006 21:09, David Howells wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > Better meaningful example would be barriers versus an IRQ handler. Which
> > leads nicely onto section 2
> 
> Yes, except that I can't think of one that's feasible that doesn't have to do
> with I/O - which isn't a problem if you are using the proper accessor
> functions.
> 
> Such an example has to involve more than one CPU, because you don't tend to
> get memory/memory ordering problems on UP.

On UP you at least need compiler barriers, right?  You're in trouble if you think
you are writing in a certain order, and expect to see the same order from an
interrupt handler, but the compiler decided to rearrange the order of the writes...

> The obvious one might be circular buffers, except there's no problem there
> provided you have a memory barrier between accessing the buffer and updating
> your pointer into it.
> 
> David

Ciao,

Duncan.
