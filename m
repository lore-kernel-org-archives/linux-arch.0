From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/34] arch: barrier cleanup + __smp_xxx barriers for virt
Date: Wed, 30 Dec 2015 23:45:20 +0100
Message-ID: <1914055.TbMeCZZgKY@wuerfel>
References: <1451473761-30019-1-git-send-email-mst@redhat.com> <11919001.9WHgFoPpmK@wuerfel> <20151230234521-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:58277 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbbL3Wp5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Dec 2015 17:45:57 -0500
In-Reply-To: <20151230234521-mutt-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>

On Wednesday 30 December 2015 23:45:41 Michael S. Tsirkin wrote:
> On Wed, Dec 30, 2015 at 02:49:53PM +0100, Arnd Bergmann wrote:
> > On Wednesday 30 December 2015 15:24:12 Michael S. Tsirkin wrote:
> > > This is really trying to cleanup some virt code, as suggested by Peter, who
> > > said
> > > > You could of course go fix that instead of mutilating things into
> > > > sort-of functional state.
> > > 
> > > This work is needed for virtio, so it's probably easiest to
> > > merge it through my tree - is this fine by everyone?
> > > Arnd, if you agree, could you ack this please?
> > 
> > I've looked over all patches now, and everything seems fine (I had one
> > small comment about a duplicate patch). It's a very nice cleanup, both
> > for using the asm-generic file, and for the virtualization users.
> > 
> > Please add my "Acked-by: Arnd Bergmann <arnd@arndb.de>" when merging the
> > series through your tree.
> > 
> >       Arnd
> 
> To all patches in the series?

Your choice, either all of them, or just the asm-generic ones.

	Arnd
