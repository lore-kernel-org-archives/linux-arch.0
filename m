Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <42B836F7.7060106@shadowen.org>
Date: Tue, 21 Jun 2005 16:49:11 +0100
From: Andy Whitcroft <apw@shadowen.org>
MIME-Version: 1.0
Subject: Re: sparsemem patches in -mm
References: <20050621021352.46fc3b81.akpm@osdl.org> <20050621095039.GC4171@wotan.suse.de>
In-Reply-To: <20050621095039.GC4171@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>, Matt Tolentino <matthew.e.tolentino@intel.com>, Bob Picco <bob.picco@hp.com>
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen wrote:
> On Tue, Jun 21, 2005 at 02:13:52AM -0700, Andrew Morton wrote:
> 
>>Could I ask the arch maintainers to review the `sparsemem' patches from -mm,
>>please, if you haven't done so...
> 
> 
> The x86-64 part is ok for me from a review standpoint.
> 
> However how much testing has been done on these yet? 
> It would be good to at least boot it on EM64T and AMD 

I've been testing this on a range of test boxes we have here, mostly x86
and ppc.  Mostly with kernbench and the like.  So far no problems have
reared their heads.

I've not been able to get much or a realistic test on amd64 box, I seem
to be struggling with combinations of scsi problems on the machine from
other changes in -mm.   The good news is that it gets far enough to
break with scsi problems and problems in sparsemem generally lead to
death much earlier than this.

-apw
