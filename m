From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v3 24/36] Hexagon: Provide basic implementation and/or stubs for I/O routines.
Date: Fri, 09 Sep 2011 23:13:12 +0200
Message-ID: <1883807.RYWKjfNqKd@wuerfel>
References: <20110909010847.294039464@codeaurora.org> <20110909010916.993872033@codeaurora.org> <20110909191412.GB2034@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110909191412.GB2034@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
To: "Linas Vepstas (Code Aurora)" <linas@codeaurora.org>
Cc: Richard Kuo <rkuo@codeaurora.org>, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Friday 09 September 2011 14:14:13 Linas Vepstas wrote:
> On Thu, Sep 08, 2011 at 08:09:11PM -0500, Richard Kuo wrote:
> > +     asm volatile(
> > +             "memb(%0) = %1;"
> > +             :
> > +             : "r" (addr), "r" (data)
> > +     );
> 
> I'm kind-of vague on this, but I think that this also needs a
> : "memory" at the end (to indicate that the asm snippet clobbers
> memory), as otherwise the compiler may be tempted to reorder
> these around other memory accesses. That is, the "volatile"
> keyword is not enough (well, I'm not sure...), but I think
> "volatile" only prevents the compiler from optimizing these
> away completely, but is not enough to prevent unwanted
> re-ordering.

Yes, absolutely correct. Specifically, this is required for the
case where you first store values into regular memory and then
use the writel() to trigger a DMA operation. Without the memory
clobber, the dma may read from memory before the CPU has accessed
it in case the store gets scheduled after the writel by the compiler.

	Arnd
