From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 08/34] asm-generic: smp_store_mb should use smp_mb
Date: Wed, 30 Dec 2015 22:30:38 +0200
Message-ID: <20151230222703-mutt-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
 <1451473761-30019-9-git-send-email-mst@redhat.com>
 <5946017.BCmPrpGMuh@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54327 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753338AbbL3Uam (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Dec 2015 15:30:42 -0500
Content-Disposition: inline
In-Reply-To: <5946017.BCmPrpGMuh@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>

On Wed, Dec 30, 2015 at 02:44:21PM +0100, Arnd Bergmann wrote:
> On Wednesday 30 December 2015 15:24:47 Michael S. Tsirkin wrote:
> > asm-generic variant of smp_store_mb() calls mb() which is stronger
> > than implied by both the name and the documentation.
> > 
> > smp_store_mb is only used by core kernel code at the moment, so
> > we know no one mis-uses it for an MMIO barrier.
> > Make it call smp_mb consistently before some arch-specific
> > code uses it as such by mistake.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/asm-generic/barrier.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> > index 538f8d1..987b2e0 100644
> > --- a/include/asm-generic/barrier.h
> > +++ b/include/asm-generic/barrier.h
> > @@ -93,7 +93,7 @@
> >  #endif	/* CONFIG_SMP */
> >  
> >  #ifndef smp_store_mb
> > -#define smp_store_mb(var, value)  do { WRITE_ONCE(var, value); mb(); } while (0)
> > +#define smp_store_mb(var, value)  do { WRITE_ONCE(var, value); smp_mb(); } while (0)
> >  #endif
> >  
> >  #ifndef smp_mb__before_atomic
> > 
> 
> The same patch is already in the tip tree scheduled for 4.5 as d5a73cadf3fd
> ("lcoking/barriers, arch: Use smp barriers in smp_store_release()").

Sorry which tree do you mean exactly?

> I think you can drop your version.
> 
> 	arnd

Will drop mine, thanks.
I kind of dislike that if I just drop it, some arches will temporarily
regress to a slower implementation.
I think I can just cherry-pick d5a73cadf3fd into my tree: git
normally figures such duplicates out nicely.
Does this sound good?

-- 
MST
