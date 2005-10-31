Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 31 Oct 2005 14:57:46 -0800
From: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 17/20] inflate: mark some arrays as initdata
Message-ID: <20051031225746.GD4367@waste.org>
References: <17.196662837@selenic.com> <18.196662837@selenic.com> <20051031224301.GF20452@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051031224301.GF20452@flint.arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Oct 31, 2005 at 10:43:01PM +0000, Russell King wrote:
> On Mon, Oct 31, 2005 at 02:54:51PM -0600, Matt Mackall wrote:
> > inflate: mark some arrays as INITDATA and define it in in-core callers
> 
> This breaks ARM.  Our decompressor has some rather odd requirements
> due to the way we support PIC - it's PIC text with fixed data.
> 
> This means that all fixed initialised data must be "const" or initialised
> by code.  This patch breaks that assertion.

It would have been helpful if you quoted the patch.

+#ifndef INITDATA
+#define INITDATA
+#endif
...
-static const u16 cplens[] = {
+static INITDATA u16 cplens[] = {
        3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31,
        35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258, 0, 0
 };

etc..

I think for ARM, we can simply do -DINITDATA=const, yes?

-- 
Mathematics is the supreme nostalgia of our time.
