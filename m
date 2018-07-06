From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] devres: Really align data field to unsigned long long
Date: Fri, 6 Jul 2018 21:10:37 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1807062109370.1592@nanos.tec.linutronix.de>
References: <20180706171504.10265-1-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180706171504.10265-1-abrodkin@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, 6 Jul 2018, Alexey Brodkin wrote:

> It looks like on most of architectures "data" member of devres struture
> gets aligned to 8-byte "unsigned long long" boundary as one may expect:
> if we don't explicitly pack a structure then natural alignment
> (which matches each member data type) is used.
> 
> But at least on 32-bit ARC architecture ABI requires "long long" types
> to be aligned by normal 32-bit word. This makes "data" field aligned to
> 12 bytes. This is still OK as long as we use 32-bit data only.
> 
> But once we want to use native atomic64_t type (i.e. when we use special
> instructions LLOCKD/SCONDD for accessing 64-bit data) we easily hit
> misaligned access exception.
> 
> That's because even on CPUs capable of non-aligned data access LL/SC
> instructions require strict alignment.
> 
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/base/devres.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index f98a097e73f2..35ddc8b66bc9 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -25,7 +25,7 @@ struct devres_node {
>  struct devres {
>  	struct devres_node		node;
>  	/* -- 3 pointers */
> -	unsigned long long		data[];	/* guarantee ull alignment */

Pretty please put a big fat comment here so that the innocent reader does
not start to wonder.

> +	unsigned long long		data[] __aligned(sizeof(unsigned long long));
>  };

Thanks,

	tglx
