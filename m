Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:54418 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbYC1ETx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 28 Mar 2008 00:19:53 -0400
Date: Fri, 28 Mar 2008 05:19:52 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch 1/2]: x86: implement pte_special
Message-ID: <20080328041951.GA6937@wotan.suse.de>
References: <20080328040442.GE8083@wotan.suse.de> <20080327.210910.101408473.davem@davemloft.net> <20080328041519.GF8083@wotan.suse.de> <20080327.211632.02770342.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080327.211632.02770342.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, shaggy@austin.ibm.com, axboe@oracle.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org
Message-ID: <20080328041952.q5_bL34xTHWD3TvpECxEIbzVJ-eV16MQYssB5I8rZTs@z>

On Thu, Mar 27, 2008 at 09:16:32PM -0700, David Miller wrote:
> From: Nick Piggin <npiggin@suse.de>
> Date: Fri, 28 Mar 2008 05:15:20 +0100
> 
> > The other thing is that the "how do I know if I can refcount the page
> > behind this (mm,vaddr,pte) tuple" can be quite arch specific as well.
> > And it is also non-trivial to do because that information can be dynamic
> > depending on what driver mapped in that given tuple.
> 
> Those are good points.

I know what you mean though... it doesn't feel like it is perfect code
just yet. However, given that it works on x86 and gives such good
results today, I feel that I'd rather get this merged first, and then
maybe when we get some more platforms on board and the code is a bit
more mature then we can try to make it "nicer"...

