From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Date: Mon, 9 Jul 2018 15:04:39 +0100
Message-ID: <20180709140438.ashvw4otyusj3nfa@lakrids.cambridge.arm.com>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
 <20180709135409.GQ2476@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180709135409.GQ2476@hirez.programming.kicks-ass.net>
Sender: stable-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, David Laight <David.Laight@ACULAB.COM>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 09, 2018 at 03:54:09PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 09, 2018 at 04:45:50PM +0300, Alexey Brodkin wrote:
> > diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> > index f98a097e73f2..d65327cb83c9 100644
> > --- a/drivers/base/devres.c
> > +++ b/drivers/base/devres.c
> > @@ -24,8 +24,12 @@ struct devres_node {
> >  
> >  struct devres {
> >  	struct devres_node		node;
> > -	/* -- 3 pointers */
> > -	unsigned long long		data[];	/* guarantee ull alignment */
> > +	/*
> > +	 * data[] must be 64 bit aligned even on 32 bit architectures
> > +	 * because it might be accessed by instructions that require
> > +	 * aligned memory arguments such as atomic64_t.
> > +	 */
> > +	u8 __aligned(8)			data[];
> >  };
> 
> From a quick reading in Documentation/driver-model/devres.txt this
> devres muck is supposed to be device memory, right?

It's for associating resources (e.g. memory allocations) with a struct
device.

e.g. you do:

	devm_kmalloc(dev, size, GFP_KERNEL);

... and that allocates sizeof(struct devres) + size, putting some
accounting data into that devres, and returning a pointer to the
remaining size bytes.

The data[] thing is a hack to ensure that the structure is padded to
64-bit alignment, in case you'd done:

struct foo {
	atomic64_t counter;
}

struct foo *f = devm_kmalloc(dev, sizeof(*f), GFP_KERNEL);

Mark.
