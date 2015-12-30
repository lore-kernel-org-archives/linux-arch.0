Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:39804 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004AbbL3V7K (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Dec 2015 16:59:10 -0500
Date: Wed, 30 Dec 2015 16:59:08 -0500 (EST)
Message-ID: <20151230.165908.1627575055770897057.davem@davemloft.net>
Subject: Re: [PATCH 00/34] arch: barrier cleanup + __smp_xxx barriers for
 virt
From: David Miller <davem@davemloft.net>
In-Reply-To: <20151230224855-mutt-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
	<20151230.154646.596597479469584255.davem@davemloft.net>
	<20151230224855-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, arnd@arndb.de, linux-arch@vger.kernel.org, andrew.cooper3@citrix.com, virtualization@lists.linux-foundation.org, stefano.stabellini@eu.citrix.com
Message-ID: <20151230215908.pYlnEjqBziry8XHJRjUVr_21bXDmZ8Ad5Vj-wasEbVo@z>

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 30 Dec 2015 23:36:29 +0200

> On Wed, Dec 30, 2015 at 03:46:46PM -0500, David Miller wrote:
>> From: "Michael S. Tsirkin" <mst@redhat.com>
>> Date: Wed, 30 Dec 2015 14:58:19 +0200
>> 
>> > -. Patch 1 documents the __smp APIs, and explains why they are
>> >    useful for virt
>> 
>> If virt is doing things like interacting with descriptors that are
>> shared with a (potentially SMP) host, why don't we just annotate those
>> specific cases?
> 
> Using a bunch of per-arch ifdefs in virtio?
> That's fundamentally what we have now.

I was suggesting a generic interface to get what you want.

virt_mb() or something like that.  You can name it something
else, that's not the important part.

> Or do you mean wrappers for __smp_XXX that explicitly
> say they are for talking to host?
> E.g. pv_mb() pv_rmb() etc.
> That sounds very reasonable to me.

Exactly!
