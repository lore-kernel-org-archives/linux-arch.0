From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 19/20] sparc64: use embedding percpu first chunk
 allocator
Date: Tue, 21 Jul 2009 20:54:19 -0700 (PDT)
Message-ID: <20090721.205419.251322907.davem@davemloft.net>
References: <1248171979-29166-1-git-send-email-tj@kernel.org>
	<1248171979-29166-20-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:56220
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754319AbZGVDyO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 21 Jul 2009 23:54:14 -0400
In-Reply-To: <1248171979-29166-20-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tj@kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, benh@kernel.crashing.org, dhowells@redhat.com, npiggin@suse.de, JBeulich@novell.com, cl@linux-foundation.org, rusty@rustcorp.com.au, hpa@zytor.com, tglx@linutronix.de, akpm@linux-foundation.org, x86@kernel.org, andi@firstfloor.org

From: Tejun Heo <tj@kernel.org>
Date: Tue, 21 Jul 2009 19:26:18 +0900

> sparc64 currently allocates a large page for each cpu and partially
> remap them into vmalloc area much like what lpage first chunk
> allocator did.  As a 4M page is used for each cpu, this results in
> very large unit size and also adds TLB pressure due to the double
> mapping of pages in the first chunk.
> 
> This patch converts sparc64 to use the embedding percpu first chunk
> allocator which now knows how to handle NUMA configurations.  This
> simplifies the code a lot, doesn't incur any extra TLB pressure and
> results in better utilization of address space.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: David S. Miller <davem@davemloft.net>
