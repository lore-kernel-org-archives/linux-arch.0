Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 21 Jun 2005 11:50:41 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: sparsemem patches in -mm
Message-ID: <20050621095039.GC4171@wotan.suse.de>
References: <20050621021352.46fc3b81.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050621021352.46fc3b81.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Dave Hansen <haveblue@us.ibm.com>, Matt Tolentino <matthew.e.tolentino@intel.com>, Bob Picco <bob.picco@hp.com>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jun 21, 2005 at 02:13:52AM -0700, Andrew Morton wrote:
> 
> Could I ask the arch maintainers to review the `sparsemem' patches from -mm,
> please, if you haven't done so...

The x86-64 part is ok for me from a review standpoint.

However how much testing has been done on these yet? 
It would be good to at least boot it on EM64T and AMD boxes.

-Andi
