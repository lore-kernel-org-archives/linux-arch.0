From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 12/18] aio: make aio_setup_ring killable
Date: Mon, 29 Feb 2016 11:17:31 -0500
Message-ID: <x491t7vmqxw.fsf@segfault.boston.devel.redhat.com>
References: <1456752417-9626-1-git-send-email-mhocko@kernel.org>
	<1456752417-9626-13-git-send-email-mhocko@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52212 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbcB2QRh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Feb 2016 11:17:37 -0500
In-Reply-To: <1456752417-9626-13-git-send-email-mhocko@kernel.org> (Michal
	Hocko's message of "Mon, 29 Feb 2016 14:26:51 +0100")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Alex Deucher <alexander.deucher@amd.com>, Alex Thorlton <athorlton@sgi.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Benjamin LaHaise <bcrl@kvack.org>, Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Davidlohr Bueso <dave@stgolabs.net>, David Rientjes <rientjes@google.com>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Khlebnikov <koct9i@gmail.com>, linux-arch@vger.kernel.org, Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>Pe

Michal Hocko <mhocko@kernel.org> writes:

> From: Michal Hocko <mhocko@suse.com>
>
> aio_setup_ring waits for mmap_sem in writable mode. If the waiting
> task gets killed by the oom killer it would block oom_reaper from
> asynchronous address space reclaim and reduce the chances of timely
> OOM resolving. Wait for the lock in the killable mode and return with
> EINTR if the task got killed while waiting. This will also expedite
> the return to the userspace and do_exit.
>
> Cc: Benjamin LaHaise <bcrl@kvack.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  fs/aio.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/aio.c b/fs/aio.c
> index 56bcdf4105f4..1c2e7e2c1b2b 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -520,7 +520,12 @@ static int aio_setup_ring(struct kioctx *ctx)
>  	ctx->mmap_size = nr_pages * PAGE_SIZE;
>  	pr_debug("attempting mmap of %lu bytes\n", ctx->mmap_size);
>  
> -	down_write(&mm->mmap_sem);
> +	if (down_write_killable(&mm->mmap_sem)) {
> +		ctx->mmap_size = 0;
> +		aio_free_ring(ctx);
> +		return -EINTR;
> +	}
> +
>  	ctx->mmap_base = do_mmap_pgoff(ctx->aio_ring_file, 0, ctx->mmap_size,
>  				       PROT_READ | PROT_WRITE,
>  				       MAP_SHARED, 0, &unused);

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
