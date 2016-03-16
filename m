Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55059 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293AbcCPBqC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Mar 2016 21:46:02 -0400
Date: Wed, 16 Mar 2016 02:45:48 +0100
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
Message-ID: <20160316014548.GK1990@wotan.suse.de>
References: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com>
 <20160304094424.GA16228@gmail.com>
 <1457115514.15454.216.camel@hpe.com>
 <20160305114012.GA7259@gmail.com>
 <1457370228.15454.311.camel@hpe.com>
 <20160308121601.GA6573@gmail.com>
 <1457483385.15454.519.camel@hpe.com>
 <20160309091525.GA11866@gmail.com>
 <1457734432.6393.199.camel@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1457734432.6393.199.camel@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Toshi Kani <toshi.kani@hpe.com>, Julia Lawall <julia.lawall@lip6.fr>
Cc: Ingo Molnar <mingo@kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Message-ID: <20160316014548._aJxfKi0mDhONWDI3CMo47L7LJDIZjj3epB38G6lBxE@z>

On Fri, Mar 11, 2016 at 03:13:52PM -0700, Toshi Kani wrote:
> Hi Ingo,
> 
> My apology for the delay...
> 
> On Wed, 2016-03-09 at 10:15 +0100, Ingo Molnar wrote:
> > * Toshi Kani <toshi.kani@hpe.com> wrote:
> > 
> > > On Tue, 2016-03-08 at 13:16 +0100, Ingo Molnar wrote:
> > > > * Toshi Kani <toshi.kani@hpe.com> wrote:
> > > > 
> > > > > > So where is the problem? The memtype implementation and hence
> > > > > > most ioremap() users are supposed to be safe. set_memory_*() APIs
> > > > > > are supposed to be safe as well, as they too go via the memtype
> > > > > > API.
> > > > > 
> > > > > Let me try to summarize...
> > > > > 
> > > > > The original issue Luis brought up was that drivers written to work
> > > > > with MTRR may create a single ioremap range covering multiple cache
> > > > > attributes since MTRR can overwrite cache attribute of a certain
> > > > > range.  Converting such drivers with PAT-based ioremap interfaces,
> > > > > i.e. ioremap_wc() and ioremap_nocache(), requires a separate
> > > > > ioremap map for each cache attribute, which can be challenging as
> > > > > it may result in overlapping ioremap ranges (in his term) with
> > > > > different cache attributes.
> > > > > 
> > > > > So, Luis asked about 'sematics of overlapping ioremap()' calls.
> > > > >  Hence, I responded that aliasing mapping itself is supported, but
> > > > > alias with different cache attribute is not.  We have checks in
> > > > > place to detect such condition.  Overlapping ioremap calls with a
> > > > > different cache attribute either fails or gets redirected to the
> > > > > existing cache attribute on x86.
> > > > 
> > > > Ok, fair enough!
> > > > 
> > > > So to go back to the original suggestion from Luis, I've quoted it,
> > > > but with a s/overlapping/aliased substitution:
> > > > 
> > > > > I had suggested long ago then that one possible resolution was for
> > > > > us to add an API that *enables* aliased ioremap() calls, and only
> > > > > use it on select locations in the kernel. This means we only have
> > > > > to convert a few users to that call to white list such semantics,
> > > > > and by default we'd disable aliased calls. To kick things off -- is
> > > > > this strategy agreeable for all other architectures?
> > > > 
> > > > I'd say that since the overwhelming majority of ioremap() calls are
> > > > not aliased, ever, thus making it 'harder' to accidentally alias is
> > > > probably a good idea.
> > > 
> > > Did you mean 'aliased' or 'aliased with different cache attribute'?
> > >  The former check might be too strict.
> > 
> > I'd say even 'same attribute' aliasing is probably relatively rare.
> > 
> > And 'different but compatible cache attribute' is in fact more of a sign
> > that the driver author does the aliasing for a valid _reason_: to have
> > two different types of access methods to the same piece of physical
> > address space...
> 
> Right.  So, if we change to fail ioremap() on aliased cases, it'd be easier
> to start with the different attribute case first.  This case should be rare
> enough that we can manage to identify such callers and make them use a new
> API as necessary.  If we go ahead to fail any aliased cases, it'd be
> challenging to manage without a regression or two.
