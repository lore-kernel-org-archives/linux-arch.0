From: Trent Piepho <tpiepho@freescale.com>
Subject: Re: MMIO and gcc re-ordering issue
Date: Thu, 29 May 2008 18:53:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0805291840430.18973@t2.domain.actdsltmp>
References: <1211852026.3286.36.camel@pasglop>  <20080526.184047.88207142.davem@davemloft.net>
  <1211854540.3286.42.camel@pasglop>  <20080526.192812.184590464.davem@davemloft.net>
  <20080526204233.75b71bb8@infradead.org> <1211872130.3286.64.camel@pasglop>
  <adaprr721c6.fsf@cisco.com> <1211922696.3286.82.camel@pasglop>
 <adaiqwzsa83.fsf@cisco.com>  <yq0iqwxrwuh.fsf@jaguar.mkp.net>
 <1212097223.8888.55.camel@pasglop>  <Pine.LNX.4.64.0805291442420.18832@t2.domain.actdsltmp>
 <1212098739.8888.58.camel@pasglop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:44571 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753776AbYE3Bz1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 21:55:27 -0400
In-Reply-To: <1212098739.8888.58.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jes Sorensen <jes@sgi.com>, Roland Dreier <rdreier@cisco.com>, Arjan van de Ven <arjan@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, scottwood@freescale.com, torvalds@linux-foundation.org, David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk

On Fri, 30 May 2008, Benjamin Herrenschmidt wrote:
> On Thu, 2008-05-29 at 14:48 -0700, Trent Piepho wrote:
>
>> I wrote a JTAG over gpio driver for the powerpc MPC8572DS platform.  With the
>> non-raw io accessors, the JTAG clock can run at almost ~9.5 MHz.  Using raw
>> versions (which I had to write since powerpc doesn't have any), the clock
>> speed increases to about 28 MHz.  So it can make a very significant different.
>
> Yes, sync's can hurt a lot. This is why I initially tried to get more
> relaxed semantics.
>
> We could implement something like __ variants and do something that
> would still have eieio's but not sync's for example (ie. MMIOs are still
> ordered vs. each other but not vs. coherent memory).

The problem current with the raw variants is that not all archs have them. 
And for those that do, there is no defined semantics.  Each arch is different
as to what ordering they have (and endianness too).

If you want to write a driver that is (or might be one day) multi-platform,
there aren't any less ordered accessors one can use.  A lot of drivers don't
even use coherent DMA, and could use less strictly ordered semantics quite
trivially.  Except there aren't any.
