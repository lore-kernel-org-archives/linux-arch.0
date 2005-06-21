Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 21 Jun 2005 03:09:39 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: sparsemem patches in -mm
Message-Id: <20050621030939.2c46efb2.akpm@osdl.org>
In-Reply-To: <20050621095039.GC4171@wotan.suse.de>
References: <20050621021352.46fc3b81.akpm@osdl.org>
	<20050621095039.GC4171@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org, apw@shadowen.org, haveblue@us.ibm.com, matthew.e.tolentino@intel.com, bob.picco@hp.com
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen <ak@suse.de> wrote:
>
> On Tue, Jun 21, 2005 at 02:13:52AM -0700, Andrew Morton wrote:
> > 
> > Could I ask the arch maintainers to review the `sparsemem' patches from -mm,
> > please, if you haven't done so...
> 
> The x86-64 part is ok for me from a review standpoint.

OK.

> However how much testing has been done on these yet? 
> It would be good to at least boot it on EM64T and AMD boxes.

Works OK on my emt64 box.  Lots of people have Optera, and I haven't heard
anything which sounds like it's sparsemem-related.
