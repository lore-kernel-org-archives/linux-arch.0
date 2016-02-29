From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 08/18] mm, fork: make dup_mmap wait for mmap_sem for
 write killable
Date: Mon, 29 Feb 2016 18:54:18 +0100
Message-ID: <20160229175418.GD3615@redhat.com>
References: <1456752417-9626-1-git-send-email-mhocko@kernel.org>
 <1456752417-9626-9-git-send-email-mhocko@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53638 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753252AbcB2RyZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Feb 2016 12:54:25 -0500
Content-Disposition: inline
In-Reply-To: <1456752417-9626-9-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Alex Deucher <alexander.deucher@amd.com>, Alex Thorlton <athorlton@sgi.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Benjamin LaHaise <bcrl@kvack.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Davidlohr Bueso <dave@stgolabs.net>, David Rientjes <rientjes@google.com>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Khlebnikov <koct9i@gmail.com>, linux-arch@vger.kernel.org, Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>

On 02/29, Michal Hocko wrote:
>
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -413,7 +413,10 @@ static int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
>  	unsigned long charge;
>  
>  	uprobe_start_dup_mmap();
> -	down_write(&oldmm->mmap_sem);
> +	if (down_write_killable(&oldmm->mmap_sem)) {
> +		uprobe_end_dup_mmap();
> +		return -EINTR;
> +	}

This is really cosmetic and subjective, I won't insist if you prefer it this way.

But perhaps it makes sense to add another "fail" label above uprobe_end_dup_mmap()
we already have... IMO it is always better to avoid duplicating when it comes to
"unlock".

Oleg.
