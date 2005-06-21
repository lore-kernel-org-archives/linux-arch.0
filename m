Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <42B83923.1070202@shadowen.org>
Date: Tue, 21 Jun 2005 16:58:27 +0100
From: Andy Whitcroft <apw@shadowen.org>
MIME-Version: 1.0
Subject: Re: sparsemem patches in -mm
References: <B8E391BBE9FE384DAA4C5C003888BE6F03BF8505@scsmsx401.amr.corp.intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F03BF8505@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>, Jack Steiner <steiner@sgi.com>, linux-arch@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>, "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
List-ID: <linux-arch.vger.kernel.org>

Luck, Tony wrote:
>>Well ia64 SPARSEMEM hasn't been accepted yet by ia64.  I did test 
>>SPARSEMEM with recent -mm patches on ia64 (EXTREME) and x86_64 4 way 
>>Opteron (!EXTREME) with OSDL aim.
> 
> 
> I'm mostly worried about whether SGI are happy.  I saw the patches
> to add the "Extreme" option ... but have only seen minimal feedback
> from that.

I'd like to say here that the EXTREME stuff is faily new compared to the
other parts.  I'd be comfortable to push up the basic SPARSEMEM
implementation and leave the EXTREME in -mm for the moment I think there
will be other updates to it before we are done.

That said I'd like to also point out that SPARSEMEM is currently still
an additional memory model.  Any architecture that finds benefit from it
is welcome to use it, any that isn't yet finding it a benefit is not
being forced to use it.  Yes in a perfect world I'd like to minimise the
number of non 'standard' memory models there are for simplicity of code
etc, but it is not the intent that we force everyone into the same
staight jacket here.

-apw
