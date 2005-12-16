Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <15167.1134488373@warthog.cambridge.redhat.com>
	<1134490205.11732.97.camel@localhost.localdomain>
	<1134556187.2894.7.camel@laptopd505.fenrus.org>
	<1134558188.25663.5.camel@localhost.localdomain>
	<1134558507.2894.22.camel@laptopd505.fenrus.org>
	<1134559470.25663.22.camel@localhost.localdomain>
	<20051214033536.05183668.akpm@osdl.org>
	<15412.1134561432@warthog.cambridge.redhat.com>
	<11202.1134730942@warthog.cambridge.redhat.com>
	<43A2BAA7.5000807@yahoo.com.au>
	<20051216132123.GB1222@flint.arm.linux.org.uk>
From: "Linh Dang" <linhd@nortel.com>
Date: Fri, 16 Dec 2005 08:46:44 -0500
In-Reply-To: <20051216132123.GB1222@flint.arm.linux.org.uk> (Russell King's
 message of "Fri, 16 Dec 2005 13:21:23 +0000")
Message-ID: <wn564ppnohn.fsf@linhd-2.ca.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: "Linh Dang" <linhd@nortel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>, Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Christopher Friesen <cfriesen@nortel.com>, torvalds@osdl.org, hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Sat, Dec 17, 2005 at 12:01:27AM +1100, Nick Piggin wrote:
>> You were proposing a worse default, which is the reason I suggested
>> it.
>
> I'd like to qualify that.  "for architectures with native cmpxchg".
>
> For general consumption (not specifically related to mutex stuff)...
>
> For architectures with llsc, sequences stuch as:
>
> 	load
> 	modify
> 	cmpxchg
>
> are inefficient because they have to be implemented as:
>
> 	load
> 	modify
> 	load
> 	compare
> 	store conditional
>

I dont know what arch u have in mind but for ppc it is:

        load-reserve
        modify
        store-conditional

and NOT the sequence you show.

-- 
Linh Dang
