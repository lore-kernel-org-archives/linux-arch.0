From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/6] amba: use the new linux/sizes.h
Date: Sat, 26 May 2012 09:33:56 +0100
Message-ID: <20120526083356.GD24149@n2100.arm.linux.org.uk>
References: <cover.1337959750.git.rubini@gnudd.com> <0e1b40d651ffbc654616173f2c3bf89888db21a5.1337959750.git.rubini@gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0e1b40d651ffbc654616173f2c3bf89888db21a5.1337959750.git.rubini@gnudd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alessandro Rubini <rubini@gnudd.com>
Cc: linux-kernel@vger.kernel.org, Giancarlo Asnaghi <giancarlo.asnaghi@st.com>, Alan Cox <alan@linux.intel.com>, x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, May 25, 2012 at 05:48:12PM +0200, Alessandro Rubini wrote:
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> ---
>  drivers/amba/bus.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index b7e7285..e29bfa7 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -18,7 +18,7 @@
>  #include <linux/amba/bus.h>
>  
>  #include <asm/irq.h>
> -#include <asm/sizes.h>
> +#include <linux/sizes.h>

Please move this up alongside the other linux/ includes.
