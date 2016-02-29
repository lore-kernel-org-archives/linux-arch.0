From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 13/18] exec: make exec path waiting for mmap_sem killable
Date: Mon, 29 Feb 2016 19:10:19 +0100
Message-ID: <20160229181018.GF3615@redhat.com>
References: <1456752417-9626-1-git-send-email-mhocko@kernel.org>
 <1456752417-9626-14-git-send-email-mhocko@kernel.org>
 <20160229172333.GB3615@redhat.com>
 <20160229174739.GL16930@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41991 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070AbcB2SK3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Feb 2016 13:10:29 -0500
Content-Disposition: inline
In-Reply-To: <20160229174739.GL16930@dhcp22.suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Alex Deucher <alexander.deucher@amd.com>, Alex Thorlton <athorlton@sgi.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Benjamin LaHaise <bcrl@kvack.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Davidlohr Bueso <dave@stgolabs.net>, David Rientjes <rientjes@google.com>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Khlebnikov <koct9i@gmail.com>, linux-arch@vger.kernel.org, Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>

On 02/29, Michal Hocko wrote:
>
> On Mon 29-02-16 18:23:34, Oleg Nesterov wrote:
> > On 02/29, Michal Hocko wrote:
> > >
> > > @@ -267,7 +267,10 @@ static int __bprm_mm_init(struct linux_binprm *bprm)
> > >  	if (!vma)
> > >  		return -ENOMEM;
> > >
> > > -	down_write(&mm->mmap_sem);
> > > +	if (down_write_killable(&mm->mmap_sem)) {
> > > +		err = -EINTR;
> > > +		goto err_free;
> > > +	}
> > >  	vma->vm_mm = mm;
> >
> > I won't argue, but this looks unnecessary. Nobody else can see this new mm,
> > down_write() can't block.
> >
> > In fact I think we can just remove down_write/up_write here. Except perhaps
> > there is lockdep_assert_held() somewhere in these paths.
>
> This is what I had initially but then I've noticed that mm_alloc() does
> mm_init(current)->init_new_context(current)

yes, and init_new_context() is arch dependant...

> code doesn't seem much harder to follow, the callers are already
> handling all error paths so I guess it would be better to simply move on
> this.

Yes, agreed, please forget.

Oleg.
