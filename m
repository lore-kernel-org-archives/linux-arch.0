Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 21 Jun 2005 12:45:13 -0400
From: Bob Picco <bob.picco@hp.com>
Subject: Re: sparsemem patches in -mm
Message-ID: <20050621164513.GI23911@localhost.localdomain>
References: <20050621021352.46fc3b81.akpm@osdl.org> <20050621110006.GH23911@localhost.localdomain> <1119369476.27442.30.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119369476.27442.30.camel@localhost>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Matt Tolentino <matthew.e.tolentino@intel.com>
List-ID: <linux-arch.vger.kernel.org>

Dave Hansen wrote:	[Tue Jun 21 2005, 11:57:56AM EDT]
> On Tue, 2005-06-21 at 07:00 -0400, Bob Picco wrote:
> > Andrew Morton wrote:	[Tue Jun 21 2005, 05:13:52AM EDT]
> > > 
> > > Could I ask the arch maintainers to review the `sparsemem' patches from -mm,
> > > please, if you haven't done so...
> > > 
> > Well ia64 SPARSEMEM hasn't been accepted yet by ia64.  I did test 
> > SPARSEMEM with recent -mm patches on ia64 (EXTREME) and x86_64 4 way 
> > Opteron (!EXTREME) with OSDL aim.
> 
> I think the whole set is just about ready for mainline.  If anybody
> wants a consolidated set of patches that's easier to review, that's no
> problem.
> 
> I'd only suggest that we keep the "extreme" stuff in -mm for a couple
> more releases.  It's a pretty clean add-on, and it has only had a very
> short time in -mm.  Bob, would you agree?
> 
> -- Dave
> 
I agree.

bob
