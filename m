From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/2] io: prevent compiler reordering on the default
 readX() implementation
Date: Tue, 3 Apr 2018 11:49:25 +0100
Message-ID: <20180403104925.fuyajja6tyanlna4@lakrids.cambridge.arm.com>
References: <1522425494-2916-1-git-send-email-okaya@codeaurora.org>
 <1522425494-2916-2-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1522425494-2916-2-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: arnd@arndb.de, timur@codeaurora.org, sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi,

On Fri, Mar 30, 2018 at 11:58:13AM -0400, Sinan Kaya wrote:
> The default implementation of mapping readX() to __raw_readX() is wrong.
> readX() has stronger ordering semantics. Compiler is allowed to reorder
> __raw_readX().

Could you please specify what the compiler is potentially reordering
__raw_readX() against, and why this would be wrong?

e.g. do we care about prior normal memory accesses, subsequent normal
memory accesses, and/or other IO accesses?

I assume that the asm-generic __raw_{read,write}X() implementations are
all ordered w.r.t. each other (at least for a specific device).

Thanks,
Mark.

> In the abscence of a read barrier or when using a strongly ordered
> architecture, readX() should at least have a compiler barrier in
> it to prevent commpiler from clobbering the execution order.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  include/asm-generic/io.h | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index e8c2078..2554f15 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -110,7 +110,12 @@ static inline void __raw_writeq(u64 value, volatile void __iomem *addr)
>  #define readb readb
>  static inline u8 readb(const volatile void __iomem *addr)
>  {
> -	return __raw_readb(addr);
> +	u8 val;
> +
> +	val = __raw_readb(addr);
> +	barrier();
> +
> +	return val;
>  }
>  #endif
>  
> @@ -118,7 +123,12 @@ static inline u8 readb(const volatile void __iomem *addr)
>  #define readw readw
>  static inline u16 readw(const volatile void __iomem *addr)
>  {
> -	return __le16_to_cpu(__raw_readw(addr));
> +	u16 val;
> +
> +	val = __le16_to_cpu(__raw_readw(addr));
> +	barrier();
> +
> +	return val;
>  }
>  #endif
>  
> @@ -126,7 +136,12 @@ static inline u16 readw(const volatile void __iomem *addr)
>  #define readl readl
>  static inline u32 readl(const volatile void __iomem *addr)
>  {
> -	return __le32_to_cpu(__raw_readl(addr));
> +	u32 val;
> +
> +	val = __le32_to_cpu(__raw_readl(addr));
> +	barrier();
> +
> +	return val;
>  }
>  #endif
>  
> @@ -135,7 +150,12 @@ static inline u32 readl(const volatile void __iomem *addr)
>  #define readq readq
>  static inline u64 readq(const volatile void __iomem *addr)
>  {
> -	return __le64_to_cpu(__raw_readq(addr));
> +	u64 val;
> +
> +	val = __le64_to_cpu(__raw_readq(addr));
> +	barrier();
> +
> +	return val;
>  }
>  #endif
>  #endif /* CONFIG_64BIT */
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
