Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 9 Nov 2005 06:49:32 -0700
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: irq-type-flags.patch
Message-ID: <20051109134932.GB27540@parisc-linux.org>
References: <20051108191057.09f57114.akpm@osdl.org> <20051109133023.GD17992@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109133023.GD17992@linux-sh.org>
To: Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Nov 09, 2005 at 03:30:23PM +0200, Paul Mundt wrote:
> > +#define SA_TRIGGER_LOW		0x00000004
> > +#define SA_TRIGGER_RISING	0x00000002
> > +#define SA_TRIGGER_FALLING	0x00000001
> It probably makes sense to move SA_TRIGGER here as well, as it's going to
> be a pretty common mask. Otherwise everyone that plans to make use of
> this will likely end up duplicating it.

Are there any other architectures that plan to make use of this?
