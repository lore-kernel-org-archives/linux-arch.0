From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [RESEND PATCH v4 1/8] bitops: Introduce the for_each_set_clump
 macro
Date: Thu, 4 Oct 2018 19:30:28 +0900
Message-ID: <20181004103028.GA4779@icarus>
References: <cover.1538441919.git.vilhelm.gray@gmail.com>
 <f5250b9c78377e476667be1b616c86cf573b57dc.1538441919.git.vilhelm.gray@gmail.com>
 <40ecad49-2797-0d30-b52d-a2e6838dc1ab@rasmusvillemoes.dk>
 <20181002082142.GC15943@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181002082142.GC15943@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linus.walleij@linaro.org, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 02, 2018 at 11:21:42AM +0300, Andy Shevchenko wrote:
> On Tue, Oct 02, 2018 at 09:42:48AM +0200, Rasmus Villemoes wrote:
> > On 2018-10-02 03:13, William Breathitt Gray wrote:
> 
> > The cover letter says
> > 
> >   The clump_size argument can be an arbitrary number of bits and is not
> >   required to be a multiple of 2.
> > 
> > by which I assume you mean "power of 2", but either way, the above code
> > does not seem to take into account the case where bits_offset +
> > clump_size straddles a word boundary, so it wouldn't work for a
> > clump_size that does not divide BITS_PER_LONG.
> 
> E.g. 3 bits in a clump? Hmm...
> 
> Why would we need that? I mean some real use case?

GPIOs in hardware may be routed to devices logically in groups of I/O
lines, yet must still be accessed via the word-sized registers on the
operating machine.

For example, suppose a GPIO card is used to control a set of shower
devices. The card supports 4 shower devices, each device controlled by 3
lines of I/O: enable, hot-cold selection, high-low pressure selection.
In this case, a operating machine would still have to access the GPIO
lines via the I/O registers (e.g. 8-bit port I/O); but with a macro
handling a clump size of 3-bits, we can loop logically by each shower
device which is much simpler from a driver perspective.

William Breathitt Gray
