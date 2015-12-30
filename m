From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 08/34] asm-generic: smp_store_mb should use smp_mb
Date: Wed, 30 Dec 2015 23:43:29 +0100
Message-ID: <1735310.18sBYE1ZVH@wuerfel>
References: <1451473761-30019-1-git-send-email-mst@redhat.com> <5946017.BCmPrpGMuh@wuerfel> <20151230222703-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:55795 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbbL3Woc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Dec 2015 17:44:32 -0500
In-Reply-To: <20151230222703-mutt-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@kernel.org>

On Wednesday 30 December 2015 22:30:38 Michael S. Tsirkin wrote:
> On Wed, Dec 30, 2015 at 02:44:21PM +0100, Arnd Bergmann wrote:
> > On Wednesday 30 December 2015 15:24:47 Michael S. Tsirkin wrote:

> > >  #ifndef smp_store_mb
> > > -#define smp_store_mb(var, value)  do { WRITE_ONCE(var, value); mb(); } while (0)
> > > +#define smp_store_mb(var, value)  do { WRITE_ONCE(var, value); smp_mb(); } while (0)
> > >  #endif
> > >  
> > >  #ifndef smp_mb__before_atomic
> > > 
> > 
> > The same patch is already in the tip tree scheduled for 4.5 as d5a73cadf3fd
> > ("lcoking/barriers, arch: Use smp barriers in smp_store_release()").
> 
> Sorry which tree do you mean exactly?

$ git log --ancestry-path --oneline --merges d5a73cadf3fd..next/master | tail -n 17
cb17a685bed6 Merge remote-tracking branch 'tip/auto-latest'
f29c2e03f0b3 Merge branch 'x86/urgent'
8cd6990bf71d Merge branch 'x86/platform'
0541d92a5eb4 Merge branch 'x86/mm'
aa7c8013c8c0 Merge branch 'x86/fpu'
fcc9a1bd013c Merge branch 'x86/efi'
e74ef3f60886 Merge branch 'x86/cpu'
44a4f0063508 Merge branch 'x86/cleanups'
28c814578fcf Merge branch 'x86/cache'
d74ff99dada8 Merge branch 'x86/boot'
db3c55380b10 Merge branch 'x86/asm'
7cd91b91da20 Merge branch 'x86/apic'
7bfc343947e6 Merge branch 'timers/core'
1720bbcb66d1 Merge branch 'sched/core'
af9a59f26764 Merge branch 'ras/core'
984b85eca78d Merge branch 'perf/core'
d2b22d438aab Merge branch 'locking/core'

$ grep auto-latest Next/Trees 
tip             git     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git#auto-latest

So locking/core of tip.git has the patch and gets merged into linux-next
through auto-latest in tip.git.

> > I think you can drop your version.
> > 
> >       arnd
> 
> Will drop mine, thanks.
> I kind of dislike that if I just drop it, some arches will temporarily
> regress to a slower implementation.
> I think I can just cherry-pick d5a73cadf3fd into my tree: git
> normally figures such duplicates out nicely.
> Does this sound good?

I don't think there is a perfect solution, you can either cherry-pick
it and get a duplicate commit in the git history, or you merge in the
whole locking/core branch from tip.

I'd say ask Ingo/PeterZ/Davidlohr which way they prefer.

	Arnd
