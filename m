From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 4/4] misc: sram: Allow ARM64 to select SRAM_EXEC
Date: Wed, 28 Jun 2017 15:55:59 +0100
Message-ID: <20170628145558.GA8252@leverpostej>
References: <20170617000744.22158-1-f.fainelli@gmail.com>
 <20170617000744.22158-5-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170617000744.22158-5-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Keerthy J <j-keerthy@ti.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Jun 16, 2017 at 05:07:44PM -0700, Florian Fainelli wrote:
> Now that ARM64 also has a fncpy() implementation, allow selection
> SRAM_EXEC for ARM64 as well.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/misc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 07bbd4cc1852..ac8779278c0c 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -464,7 +464,7 @@ config SRAM
>  	bool "Generic on-chip SRAM driver"
>  	depends on HAS_IOMEM
>  	select GENERIC_ALLOCATOR
> -	select SRAM_EXEC if ARM
> +	select SRAM_EXEC if ARM || ARM64
>  	help
>  	  This driver allows you to declare a memory region to be managed by
>  	  the genalloc API. It is supposed to be used for small on-chip SRAM

As stated in another thread [1], NAK to this patch.

Currently there are no users of this interface that we wish to enable
for arm64, and this is liable to be abused to add platform-specific
stuff that we expect to live in PSCI or other secure FW.

Until we have a user that does not fall into that bucket, I see no
reason to enable this for arm64.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-June/516161.html
