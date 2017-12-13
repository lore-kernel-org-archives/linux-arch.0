Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752714AbdLMNBh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Dec 2017 08:01:37 -0500
Date: Wed, 13 Dec 2017 14:01:35 +0100
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce MAP_FIXED_SAFE
Message-ID: <20171213130135.GG25185@dhcp22.suse.cz>
References: <20171213092550.2774-1-mhocko@kernel.org>
 <20171213092550.2774-2-mhocko@kernel.org>
 <20171213125053.GB2384@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171213125053.GB2384@bombadil.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-api@vger.kernel.org, Khalid Aziz <khalid.aziz@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, John Hubbard <jhubbard@nvidia.com>
Message-ID: <20171213130135.MjJiDlWUBY9O2ML-8uq4oyRa39GWWPUATdtVRyoqLyU@z>

On Wed 13-12-17 04:50:53, Matthew Wilcox wrote:
> On Wed, Dec 13, 2017 at 10:25:49AM +0100, Michal Hocko wrote:
> > +++ b/mm/mmap.c
> > @@ -1342,6 +1342,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> >  		if (!(file && path_noexec(&file->f_path)))
> >  			prot |= PROT_EXEC;
> >  
> > +	/* force arch specific MAP_FIXED handling in get_unmapped_area */
> > +	if (flags & MAP_FIXED_SAFE)
> > +		flags |= MAP_FIXED;
> > +
> >  	if (!(flags & MAP_FIXED))
> >  		addr = round_hint_to_min(addr);
> >  
> 
> We're up to 22 MAP_ flags now.  We'll run out soon.  Let's preserve half
> of a flag by giving userspace the definition:
> 
> #define MAP_FIXED_SAFE	(MAP_FIXED | _MAP_NOT_HINT)

I've already tried to explain why this cannot be a modifier for
MAP_FIXED. Read about the backward compatibility note...
Or do I misunderstand what you are saying here?
 
> then in here:
> 
> 	if ((flags & _MAP_NOT_HINT) && !(flags & MAP_FIXED))
> 		return -EINVAL;
> 
> Now we can use _MAP_NOT_HINT all by itself in the future to mean
> something else.

-- 
Michal Hocko
SUSE Labs
