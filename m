From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] Export kmap_atomic_pfn for DRM-GEM.
Date: Wed, 27 Aug 2008 23:36:05 +1000
Message-ID: <200808272336.05736.nickpiggin@yahoo.com.au>
References: <1219779789-8368-1-git-send-email-eric@anholt.net> <1219779789-8368-2-git-send-email-eric@anholt.net> <1219779789-8368-3-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756290AbYH0Ng1@vger.kernel.org>
In-Reply-To: <1219779789-8368-3-git-send-email-eric@anholt.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Anholt <eric@anholt.net>, Dave Airlie <airlied@gmail.com>, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wednesday 27 August 2008 05:43, Eric Anholt wrote:
> The driver would like to map IO space directly for copying data in when
> appropriate, to avoid CPU cache flushing for streaming writes.
> kmap_atomic_pfn lets us avoid IPIs associated with ioremap for this
> process.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  arch/x86/mm/highmem_32.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/x86/mm/highmem_32.c b/arch/x86/mm/highmem_32.c
> index 165c871..d52e91d 100644
> --- a/arch/x86/mm/highmem_32.c
> +++ b/arch/x86/mm/highmem_32.c
> @@ -137,6 +137,7 @@ void *kmap_atomic_pfn(unsigned long pfn, enum km_type
> type)
>
>  	return (void*) vaddr;
>  }
> +EXPORT_SYMBOL(kmap_atomic_pfn);
>
>  struct page *kmap_atomic_to_page(void *ptr)
>  {


I wonder if you ever tested my vmap rework patches with this issue? It
seems somewhat x86 specific and also not conceptually so clean to use
kmap_atomic_pfn for this. vmap may not be used by all architectures but
I think it might be able to cover some of them.

As I said, there are some other possible improvements that can be made
to my vmap rewrite if performance isn't good enough, but I simply have
not seen numbers...

Thanks,
Nick
