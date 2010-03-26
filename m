From: Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 03/24] x86: Do not free zero sized per cpu areas
Date: Sat, 27 Mar 2010 00:42:03 +0100
Message-ID: <20100326234203.GD29222@cmpxchg.org>
References: <1269642114-16588-1-git-send-email-yinghai@kernel.org> <1269642114-16588-4-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1269642114-16588-4-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ian Campbell <ian.campbell@citrix.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 26, 2010 at 03:21:33PM -0700, Yinghai Lu wrote:
> From: Ian Campbell <ian.campbell@citrix.com>
> 
> This avoids an infinite loop in free_early_partial().
> 
> Add a warning to free_early_partial to catch future problems.
> 
> -v5: put back start > end back into WARN_ONCE()
> -v6: use one line for warning according to linus
> -v7: more test by
> 
> Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Tested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Tested-by: Joel Becker <joel.becker@oracle.com>
> Tested-by: Stanislaw Gruszka <sgruszka@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@elte.hu>
> ---
>  kernel/early_res.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/kernel/early_res.c b/kernel/early_res.c
> index 3cb2c66..69bed5b 100644
> --- a/kernel/early_res.c
> +++ b/kernel/early_res.c
> @@ -333,6 +333,12 @@ void __init free_early_partial(u64 start, u64 end)
>  	struct early_res *r;
>  	int i;
>  
> +	if (start == end)
> +		return;
> +
> +	if (WARN_ONCE(start > end, "free_early_partial: wrong range [%#llx, %#llx]\n", start, end))
> +		return;

I think you can drop the function name, it will be in the stack dump
anyway.  And that would get the line back into bounds :)

Other than that,
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
