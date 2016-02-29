From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 11/18] coredump: make coredump_wait wait for mma_sem for
 write killable
Date: Mon, 29 Feb 2016 16:57:58 +0100
Message-ID: <20160229155757.GB1964@redhat.com>
References: <1456752417-9626-1-git-send-email-mhocko@kernel.org>
 <1456752417-9626-12-git-send-email-mhocko@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51126 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753604AbcB2P6F (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Feb 2016 10:58:05 -0500
Content-Disposition: inline
In-Reply-To: <1456752417-9626-12-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Alex Deucher <alexander.deucher@amd.com>, Alex Thorlton <athorlton@sgi.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Benjamin LaHaise <bcrl@kvack.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Davidlohr Bueso <dave@stgolabs.net>, David Rientjes <rientjes@google.com>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Khlebnikov <koct9i@gmail.com>, linux-arch@vger.kernel.org, Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>

On 02/29, Michal Hocko wrote:
>
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -410,7 +410,9 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
>  	core_state->dumper.task = tsk;
>  	core_state->dumper.next = NULL;
>  
> -	down_write(&mm->mmap_sem);
> +	if (down_write_killable(&mm->mmap_sem))
> +		return -EINTR;
> +

ACK, thanks.

Oleg.
