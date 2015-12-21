From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Xen-devel] new barrier type for paravirt (was Re: [PATCH]
 virtio_ring: use smp_store_mb)
Date: Mon, 21 Dec 2015 09:10:52 +0200
Message-ID: <20151221085947-mutt-send-email-mst@redhat.com>
References: <1450347932-16325-1-git-send-email-mst@redhat.com>
 <20151217105238.GA6375@twins.programming.kicks-ass.net>
 <20151217131554-mutt-send-email-mst@redhat.com>
 <20151217135726.GA6344@twins.programming.kicks-ass.net>
 <20151217161124-mutt-send-email-mst@redhat.com>
 <20151217143910.GD6344@twins.programming.kicks-ass.net>
 <20151220105146-mutt-send-email-mst@redhat.com>
 <5676E047.3010808@citrix.com>
 <20151220195944.GT6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54245 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219AbbLUHLA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 21 Dec 2015 02:11:00 -0500
Content-Disposition: inline
In-Reply-To: <20151220195944.GT6344@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Jason Wang <jasowang@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, qemu-devel@nongnu.org, Alexander Duyck <alexander.duyck@gmail.com>, linux-kernel@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org

On Sun, Dec 20, 2015 at 08:59:44PM +0100, Peter Zijlstra wrote:
> On Sun, Dec 20, 2015 at 05:07:19PM +0000, Andrew Cooper wrote:
> > 
> > Very much +1 for fixing this.
> > 
> > Those names would be fine, but they do add yet another set of options in
> > an already-complicated area.
> > 
> > An alternative might be to have the regular smp_{w,r,}mb() not revert
> > back to nops if CONFIG_PARAVIRT, or perhaps if pvops have detected a
> > non-native environment.  (I don't know how feasible this suggestion is,
> > however.)
> 
> So a regular SMP kernel emits the LOCK prefix and will patch it out with
> a DS prefix (iirc) when it finds but a single CPU. So for those you
> could easily do this.
> 
> However an UP kernel will not emit the LOCK and do no patching.
> 
> So if you're willing to make CONFIG_PARAVIRT depend on CONFIG_SMP or
> similar, this is doable.

One of the uses for virtio is to allow testing an existing kernel on
kvm just by loading a module, and this will break this usecase.

> I don't see people going to allow emitting the LOCK prefix (and growing
> the kernel text size) for UP kernels.

Thinking about this more, maybe __smp_*mb is a better set of names.

The nice thing about it is that we can then have generic code
that does basically

#ifdef CONFIG_SMP
#define smp_mb() __smp_mb()
#else
#define smp_mb() barrier()
#endif 

and reuse this on all architectures.

So instead of a maintainance burden, we are actually
removing code duplication.

-- 
MST
