From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCH/RFC 3/8] numa:  x86_64:  use generic percpu var for
 numa_node_id() implementation
Date: Thu, 4 Mar 2010 15:16:49 -0600 (CST)
Message-ID: <alpine.DEB.2.00.1003041514310.2644@router.home>
References: <20100304170654.10606.32225.sendpatchset@localhost.localdomain>  <20100304170716.10606.24477.sendpatchset@localhost.localdomain>  <alpine.DEB.2.00.1003041245280.21776@router.home> <1267735368.29020.104.camel@useless.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from nlpi157.sbcis.sbc.com ([207.115.36.171]:56636 "EHLO
	nlpi157.prodigy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932368Ab0CDVRl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Mar 2010 16:17:41 -0500
In-Reply-To: <1267735368.29020.104.camel@useless.americas.hpqcorp.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-numa@vger.kernel.org, Tejun Heo <tj@kernel.org>, Mel Gorman <mel@csn.ul.ie>, Andi Kleen <andi@firstfloor.org>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>, akpm@linux-foundation.org, eric.whitney@hp.com

On Thu, 4 Mar 2010, Lee Schermerhorn wrote:

> Well, in linux/percpu-defs.h after the first patch in this series, but
> x86 is overriding it with the percpu_to_op() implementation.  You're
> saying that the x86 percpu_to_op() macro doesn't handle 8-byte 'pcp'
> operands?  It appears to handle sizes 1, 2, 4 and 8.

8 byte operands are not allowed for 32 bit but work on 64 bit.

> So, I'll remove those definitions in V4.

Ok.

> Do we want to retain the x86 definitions of __this_cpu_xxx_[124]() or
> remove those and let the generic definitions handle them?

Generic definitions would not be as efficient as the use of the segment
register to shift the address to the cpu area.

I have not figured out exactly what you are doing with the percpu
definitions and why yet. Ill look at that when I have some time.
