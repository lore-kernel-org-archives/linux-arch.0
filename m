From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 00/34] arch: barrier cleanup + __smp_xxx barriers for virt
Date: Wed, 30 Dec 2015 23:36:29 +0200
Message-ID: <20151230224855-mutt-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
 <20151230.154646.596597479469584255.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32991 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753466AbbL3Vgd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Dec 2015 16:36:33 -0500
Content-Disposition: inline
In-Reply-To: <20151230.154646.596597479469584255.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, arnd@arndb.de, linux-arch@vger.kernel.org, andrew.cooper3@citrix.com, virtualization@lists.linux-foundation.org, stefano.stabellini@eu.citrix.com

On Wed, Dec 30, 2015 at 03:46:46PM -0500, David Miller wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Date: Wed, 30 Dec 2015 14:58:19 +0200
> 
> > -. Patch 1 documents the __smp APIs, and explains why they are
> >    useful for virt
> 
> If virt is doing things like interacting with descriptors that are
> shared with a (potentially SMP) host, why don't we just annotate those
> specific cases?

Using a bunch of per-arch ifdefs in virtio?
That's fundamentally what we have now.

But basically the rework reduces the LOC count in kernel anyway
by moving all ifdef CONFIG_SMP hacks into asm-generic.
So why not let virt benefit?

Or do you mean wrappers for __smp_XXX that explicitly
say they are for talking to host?
E.g. pv_mb() pv_rmb() etc.
That sounds very reasonable to me.

__smp_XXX things then become an implementation detail.

> The other memory barriers in the kernel do not matter for SMP'ness
> when build UP.
