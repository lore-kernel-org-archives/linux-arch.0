Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:54526 "EHLO
 bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1726466AbfD1IOA (ORCPT <rfc822;linux-arch@vger.kernel.org>); Sun,
 28 Apr 2019 04:14:00 -0400
Date: Sun, 28 Apr 2019 01:13:53 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: DISCONTIGMEM is deprecated
Message-ID: <20190428081353.GB30901@infradead.org>
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
 <0100016a461809ed-be5bd8fc-9925-424d-9624-4a325a7a8860-000000@email.amazonses.com>
 <25cabb7c-9602-2e09-2fe0-cad3e54595fa@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25cabb7c-9602-2e09-2fe0-cad3e54595fa@linux.ee>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Christopher Lameter <cl@linux.com>, Mel Gorman <mgorman@techsingularity.net>, Andrew Morton <akpm@linux-foundation.org>, Mikulas Patocka <mpatocka@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-parisc@vger.kernel.org, linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Message-ID: <20190428081353.22PzyAPOEg_iF8y3pvAHES_7oomCDGyC4oxJXSMXC78@z>

On Tue, Apr 23, 2019 at 07:49:57PM +0300, Meelis Roos wrote:
> > > ia64 (looks complicated ...)
> > 
> > Well as far as I can tell it was not even used 12 or so years ago on
> > Itanium when I worked on that stuff.
> 
> My notes tell that on UP ia64 (RX2620), !NUMA was broken with both
> SPARSEMEM and DISCONTIGMEM. NUMA+SPARSEMEM or !NUMA worked. Even
> NUMA+DISCONTIGMEM worked, that was my config on 2-CPU RX2660.

ia64 has a such a huge number of memory model choices.  Maybe we
need to cut it down to a small set that actually work.

That includes fund bits like the 'VIRTUAL_MEM_MAP' option where the
comment claims:

# VIRTUAL_MEM_MAP and FLAT_NODE_MEM_MAP are functionally equivalent.
# VIRTUAL_MEM_MAP has been retained for historical reasons.

but it still is selected as the default if sparsemem is not enabled..
