Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:48057
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753237AbYC1Dob (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 27 Mar 2008 23:44:31 -0400
Date: Thu, 27 Mar 2008 20:44:31 -0700 (PDT)
Message-ID: <20080327.204431.201380891.davem@davemloft.net>
Subject: Re: [patch 1/2]: x86: implement pte_special
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080328033149.GD8083@wotan.suse.de>
References: <20080328025541.GB8083@wotan.suse.de>
	<20080327.202334.250213398.davem@davemloft.net>
	<20080328033149.GD8083@wotan.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: akpm@linux-foundation.org, shaggy@austin.ibm.com, axboe@oracle.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org
Message-ID: <20080328034431.Llb8NBJysOQCqArTD_3d6YvOuUamcUCoI6OpfEMkrek@z>

From: Nick Piggin <npiggin@suse.de>
Date: Fri, 28 Mar 2008 04:31:50 +0100

> Basically, the pfn-based mapping insertion (vm_insert_pfn, remap_pfn_range)
> calls pte_mkspecial. And that tells fast_gup "hands off".

I don't think it's wise to allocate a "soft PTE bit" for this on every
platform, especially for such a limited use case.

Is it feasible to test the page instead?  Or are we talking about
cases where there may not be a backing page?

If the issue is to discern things like I/O mappings and such vs. real
pages, there are ways a platform can handle that without a special
bit.

That would leave us with real memory that does not have backing
page structs, and we have a way to test that too.

The special PTE bit seems superfluous to me.
