From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH v5 02/39] openrisc: add ioremap_nocache declaration
 before include asm-generic/io.h and sync ioremap prototype with it.
Date: Wed, 3 Jan 2018 23:38:03 +0900
Message-ID: <20180103143803.GI32243@lianli.shorne-pla.net>
References: <cover.1514874857.git.green.hu@gmail.com>
 <3e5ba33674a883b56e20b35ea9ae34990ea838c8.1514874857.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3e5ba33674a883b56e20b35ea9ae34990ea838c8.1514874857.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi
List-Id: linux-arch.vger.kernel.org

Hello,

On Tue, Jan 02, 2018 at 04:24:34PM +0800, Greentime Hu wrote:
> From: Greentime Hu <greentime@andestech.com>
> 
> It will be built failed if commit id: d25ea659 is selected. This patch can fix this
> build error.

Ideally you would mention the commit description since the id is not yet
usptream.  I found it here (its 1 in this series):

  https://github.com/andestech/linux/commit/d25ea659
  asm-generic/io.h: move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_...

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

Ideally we could move <asm-generic/io.h> include down to the bottom of the file
and not have to do the defines like like this, it seems clumsy to me.  In
'cris', 'nios2' and other architectures I can see they have the generic include
at the bottom of the file and not need for #define's.

I tried that but I get a lot of errors.  Does your patch to asm-generic/io.h
cause build issues for those architectures as well?

-Stafford

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
