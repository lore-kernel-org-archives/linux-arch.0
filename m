Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42647 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933055AbdK2PuN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Nov 2017 10:50:13 -0500
Date: Wed, 29 Nov 2017 16:50:09 +0100
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 0/2] mm: introduce MAP_FIXED_SAFE
Message-ID: <20171129155009.i5xai77rrapsyrd2@dhcp22.suse.cz>
References: <20171129144219.22867-1-mhocko@kernel.org>
 <b154b794-7a8b-995e-0954-9234b9446b31@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b154b794-7a8b-995e-0954-9234b9446b31@prevas.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: linux-api@vger.kernel.org, Khalid Aziz <khalid.aziz@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>, Kees Cook <keescook@chromium.org>
Message-ID: <20171129155009.i6ICNzBeprxQPBXeHfUXXyGhI_m4AAAwen69FiU44Qg@z>

On Wed 29-11-17 16:13:53, Rasmus Villemoes wrote:
> On 2017-11-29 15:42, Michal Hocko wrote:
[...]
> >The flag is introduced as a completely
> > new one rather than a MAP_FIXED extension because of the backward
> > compatibility. We really want a never-clobber semantic even on older
> > kernels which do not recognize the flag. Unfortunately mmap sucks wrt.
> > flags evaluation because we do not EINVAL on unknown flags. On those
> > kernels we would simply use the traditional hint based semantic so the
> > caller can still get a different address (which sucks) but at least not
> > silently corrupt an existing mapping. I do not see a good way around
> > that.
> 
> I think it would be nice if this rationale was in the 1/2 changelog,
> along with the hint about what userspace that wants to be compatible
> with old kernels will have to do (namely, check that it got what it
> requested) - which I see you did put in the man page.

OK, I've added there.

-- 
Michal Hocko
SUSE Labs
