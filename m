Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:52742 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbdLMMuz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Dec 2017 07:50:55 -0500
Date: Wed, 13 Dec 2017 04:50:53 -0800
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/2] mm: introduce MAP_FIXED_SAFE
Message-ID: <20171213125053.GB2384@bombadil.infradead.org>
References: <20171213092550.2774-1-mhocko@kernel.org>
 <20171213092550.2774-2-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171213092550.2774-2-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-api@vger.kernel.org, Khalid Aziz <khalid.aziz@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Michal Hocko <mhocko@suse.com>
Message-ID: <20171213125053.APuZOkZoFlu4zW8CkPBbDnnmbss9mkr4JDtCq2zB-0s@z>

On Wed, Dec 13, 2017 at 10:25:49AM +0100, Michal Hocko wrote:
> +++ b/mm/mmap.c
> @@ -1342,6 +1342,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  		if (!(file && path_noexec(&file->f_path)))
>  			prot |= PROT_EXEC;
>  
> +	/* force arch specific MAP_FIXED handling in get_unmapped_area */
> +	if (flags & MAP_FIXED_SAFE)
> +		flags |= MAP_FIXED;
> +
>  	if (!(flags & MAP_FIXED))
>  		addr = round_hint_to_min(addr);
>  

We're up to 22 MAP_ flags now.  We'll run out soon.  Let's preserve half
of a flag by giving userspace the definition:

#define MAP_FIXED_SAFE	(MAP_FIXED | _MAP_NOT_HINT)

then in here:

	if ((flags & _MAP_NOT_HINT) && !(flags & MAP_FIXED))
		return -EINVAL;

Now we can use _MAP_NOT_HINT all by itself in the future to mean
something else.
