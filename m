Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 16 Dec 2005 15:58:11 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051216155811.GE1222@flint.arm.linux.org.uk>
References: <1134558188.25663.5.camel@localhost.localdomain> <1134558507.2894.22.camel@laptopd505.fenrus.org> <1134559470.25663.22.camel@localhost.localdomain> <20051214033536.05183668.akpm@osdl.org> <15412.1134561432@warthog.cambridge.redhat.com> <11202.1134730942@warthog.cambridge.redhat.com> <43A2BAA7.5000807@yahoo.com.au> <20051216132123.GB1222@flint.arm.linux.org.uk> <wn564ppnohn.fsf@linhd-2.ca.nortel.com> <20058.1134748001@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20058.1134748001@warthog.cambridge.redhat.com>
Sender: Russell King <rmk@arm.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Linh Dang <linhd@nortel.com>, Nick Piggin <nickpiggin@yahoo.com.au>, Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Christopher Friesen <cfriesen@nortel.com>, torvalds@osdl.org, hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Dec 16, 2005 at 03:46:41PM +0000, David Howells wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> > Do you now see what I mean?  (yup, ARM is a llsc architecture.)
> 
> Out of interest, at what point did ARM become so? ARM6?

Yes, ARM architecture version 6.

See the ldrex (load exclusive) / strex (store exclusive) instructions.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
