From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] m32r: fix readl/writel prototypes
Date: Tue, 2 Jan 2018 22:52:56 +0100
Message-ID: <20180102215245.ajrvyctrffqiynhi@ltop.local>
References: <20180102105653.1645748-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180102105653.1645748-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 02, 2018 at 11:56:41AM +0100, Arnd Bergmann wrote:
> All other architectures use 'unsigned int' as the data in readl/write,
> but m32r uses 'unsigned long', leading to lots of harmless build warnings
> like:
> 
> drivers/mmc/host/dw_mmc.c: In function 'dw_mci_regs_show':
> drivers/mmc/host/dw_mmc.c:168:31: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int' [-Wformat=]
>   seq_printf(s, "STATUS:\t0x%08x\n", mci_readl(host, STATUS));
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/m32r/include/asm/io.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/m32r/include/asm/io.h b/arch/m32r/include/asm/io.h
> index 1b653bb16f9a..093486b5b931 100644
> --- a/arch/m32r/include/asm/io.h
> +++ b/arch/m32r/include/asm/io.h
> @@ -108,9 +108,9 @@ static inline unsigned short _readw(unsigned long addr)
>  	return *(volatile unsigned short __force *)addr;
>  }
>  
> -static inline unsigned long _readl(unsigned long addr)
> +static inline unsigned int _readl(unsigned long addr)
>  {
> -	return *(volatile unsigned long __force *)addr;
> +	return *(volatile unsigned int __force *)addr;
>  }

The __force is not needed here, so I think it would be better to
remove it. Maybe better to do that in another patch, though.

-- Luc Van Oostenryck
