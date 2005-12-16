Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <43A2DEA9.4000209@yahoo.com.au>
Date: Sat, 17 Dec 2005 02:35:05 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <1134556187.2894.7.camel@laptopd505.fenrus.org>	<1134558188.25663.5.camel@localhost.localdomain>	<1134558507.2894.22.camel@laptopd505.fenrus.org>	<1134559470.25663.22.camel@localhost.localdomain>	<20051214033536.05183668.akpm@osdl.org>	<15412.1134561432@warthog.cambridge.redhat.com>	<11202.1134730942@warthog.cambridge.redhat.com>	<43A2BAA7.5000807@yahoo.com.au>	<20051216132123.GB1222@flint.arm.linux.org.uk>	<wn564ppnohn.fsf@linhd-2.ca.nortel.com>	<20051216143110.GC1222@flint.arm.linux.org.uk> <wn5bqzhm5ex.fsf@linhd-2.ca.nortel.com>
In-Reply-To: <wn5bqzhm5ex.fsf@linhd-2.ca.nortel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Linh Dang <linhd@nortel.com>
Cc: David Howells <dhowells@redhat.com>, Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Christopher Friesen <cfriesen@nortel.com>, torvalds@osdl.org, hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Linh Dang wrote:

>>Do you now see what I mean?  (yup, ARM is a llsc architecture.)
> 
> 
> Well, it may be true for ARM but for ppc (i dunno what exactly llsc
> means but someone in the thread put ppc in llsc group)  it's:
> 

load locked or load with lock, IIRC.

>    loop:
>         load-reserve foo => old
>         new = old * N
>         store-conditional new => foo
>         if failed goto loop     
> 

The point is that the typical use case for a cmpxchg is less optimal
if cmpxchg is simulated with llsc than if the same functionality were
directly implemented with llsc instructions.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
