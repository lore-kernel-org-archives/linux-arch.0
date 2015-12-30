From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 00/34] arch: barrier cleanup + __smp_xxx barriers for virt
Date: Wed, 30 Dec 2015 23:45:41 +0200
Message-ID: <20151230234521-mutt-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
 <11919001.9WHgFoPpmK@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56287 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940AbbL3Vpo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Dec 2015 16:45:44 -0500
Content-Disposition: inline
In-Reply-To: <11919001.9WHgFoPpmK@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>

On Wed, Dec 30, 2015 at 02:49:53PM +0100, Arnd Bergmann wrote:
> On Wednesday 30 December 2015 15:24:12 Michael S. Tsirkin wrote:
> > This is really trying to cleanup some virt code, as suggested by Peter, who
> > said
> > > You could of course go fix that instead of mutilating things into
> > > sort-of functional state.
> > 
> > This work is needed for virtio, so it's probably easiest to
> > merge it through my tree - is this fine by everyone?
> > Arnd, if you agree, could you ack this please?
> 
> I've looked over all patches now, and everything seems fine (I had one
> small comment about a duplicate patch). It's a very nice cleanup, both
> for using the asm-generic file, and for the virtualization users.
> 
> Please add my "Acked-by: Arnd Bergmann <arnd@arndb.de>" when merging the
> series through your tree.
> 
> 	Arnd

To all patches in the series?
