Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 21 Jun 2005 13:01:50 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: sparsemem patches in -mm
Message-Id: <20050621130150.62fbd353.akpm@osdl.org>
In-Reply-To: <42B83771.1050304@shadowen.org>
References: <20050621021352.46fc3b81.akpm@osdl.org>
	<20050621141755.GX11655@parcelfarce.linux.theplanet.co.uk>
	<42B83771.1050304@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andy Whitcroft <apw@shadowen.org>
Cc: matthew@wil.cx, linux-arch@vger.kernel.org, haveblue@us.ibm.com, matthew.e.tolentino@intel.com, bob.picco@hp.com
List-ID: <linux-arch.vger.kernel.org>

Andy Whitcroft <apw@shadowen.org> wrote:
>
> Matthew Wilcox wrote:
> > On Tue, Jun 21, 2005 at 02:13:52AM -0700, Andrew Morton wrote:
> > 
> >>Could I ask the arch maintainers to review the `sparsemem' patches from -mm,
> >>please, if you haven't done so...
> >>
> >>They're all in http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/
> > 
> > 
> > Pretty confusing.  All kinds of options added, removed, modified, put
> > back ...  let's merge it, then see how it looks.  Maybe we'll switch
> > parisc from discontigmem to sparsemem.
> 
> Would it make sense for me to take the current pile of patches in -mm
> and merge the fixes into the appropriate main patches to make a
> consolidated patch set?  If we want to do that I am happy to put the
> effort in.

I've already done some of that, but I need to do another pass.

<looks>

The patches I have there seem fairly logical, although there's a lot of
Kconfig futzing going on.  Do you spy any patches which should be collapsed
together there?  If so, which?
