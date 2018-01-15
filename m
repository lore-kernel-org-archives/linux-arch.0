From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH v6 02/36] openrisc: add ioremap_nocache declaration
 before include asm-generic/io.h and sync ioremap prototype with it.
Date: Mon, 15 Jan 2018 22:07:28 +0900
Message-ID: <20180115130728.GG13019@lianli.shorne-pla.net>
References: <cover.1515766253.git.green.hu@gmail.com>
 <3e5ba33674a883b56e20b35ea9ae34990ea838c8.1515766253.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3e5ba33674a883b56e20b35ea9ae34990ea838c8.1515766253.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 15, 2018 at 01:53:10PM +0800, Greentime Hu wrote:
> From: Greentime Hu <greentime@andestech.com>
> 
> It will be built failed if commit id: d25ea659 is selected. This patch can fix this
> build error.

Hello,

As I mentioned last time, can you you change this to not mention the commit id?
The ID will probably change when this is actually committed.  You might want to
do something like:

 1. Move this commit before the ioremap_nocache change.  This is because we want
 each commit to result in a buildable kernel.

 2. The text here and other changes could read:

 A future commit for the nds32 architecture bootstrap ("asm-generic/io.h: move
 ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef CONFIG_MMU")
 will move the ioremap_nocache out of the CONFIG_MMU ifdef.  This means that
 in order to suppress re-definition errors we need to setup #define's before
 importing asm-generic/io.h.

 Also, the change adds a prototype for ioremap where size is size_t so fix that
 as well.

I hope that helps. But for the change:

Acked-by: Stafford Horne <shorne@gmail.com>

> Signed-off-by: Greentime Hu <greentime@andestech.com>
> ---
>  arch/openrisc/include/asm/io.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
> index 7c69139..6709b28 100644
> --- a/arch/openrisc/include/asm/io.h
> +++ b/arch/openrisc/include/asm/io.h
> @@ -29,13 +29,14 @@
>  #define PIO_OFFSET		0
>  #define PIO_MASK		0
>  
> +#define ioremap_nocache ioremap_nocache
>  #include <asm-generic/io.h>
>  #include <asm/pgtable.h>
>  
>  extern void __iomem *__ioremap(phys_addr_t offset, unsigned long size,
>  				pgprot_t prot);
>  
> -static inline void __iomem *ioremap(phys_addr_t offset, unsigned long size)
> +static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
>  {
>  	return __ioremap(offset, size, PAGE_KERNEL);
>  }
> -- 
> 1.7.9.5
> 
