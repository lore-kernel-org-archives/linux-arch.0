From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 51/73] drivers/i2c: delete non-required instances of
 include <linux/init.h>
Date: Fri, 24 Jan 2014 18:09:39 +0100
Message-ID: <20140124180939.167e31a4@endymion.delvare>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
	<1390339396-3479-52-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390339396-3479-52-git-send-email-paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hi Paul,

On Tue, 21 Jan 2014 16:22:54 -0500, Paul Gortmaker wrote:
> None of these files are actually using any __init type directives
> and hence don't need to include <linux/init.h>.  Most are just a
> left over from __devinit and __cpuinit removal, or simply due to
> code getting copied from one driver to the next.
> 
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
> ---
>  drivers/i2c/algos/i2c-algo-bit.c           | 1 -
>  drivers/i2c/algos/i2c-algo-pca.c           | 1 -
>  drivers/i2c/algos/i2c-algo-pcf.c           | 1 -
>  drivers/i2c/busses/i2c-ali1535.c           | 1 -
>  drivers/i2c/busses/i2c-ali1563.c           | 1 -
>  drivers/i2c/busses/i2c-ali15x3.c           | 1 -
>  drivers/i2c/busses/i2c-amd756.c            | 1 -
>  drivers/i2c/busses/i2c-amd8111.c           | 1 -
>  drivers/i2c/busses/i2c-au1550.c            | 1 -
>  drivers/i2c/busses/i2c-cbus-gpio.c         | 1 -
>  drivers/i2c/busses/i2c-cpm.c               | 1 -
>  drivers/i2c/busses/i2c-eg20t.c             | 1 -
>  drivers/i2c/busses/i2c-exynos5.c           | 1 -
>  drivers/i2c/busses/i2c-highlander.c        | 1 -
>  drivers/i2c/busses/i2c-hydra.c             | 1 -
>  drivers/i2c/busses/i2c-ibm_iic.c           | 1 -
>  drivers/i2c/busses/i2c-iop3xx.c            | 1 -
>  drivers/i2c/busses/i2c-isch.c              | 1 -
>  drivers/i2c/busses/i2c-ismt.c              | 1 -
>  drivers/i2c/busses/i2c-mpc.c               | 1 -
>  drivers/i2c/busses/i2c-nforce2.c           | 1 -
>  drivers/i2c/busses/i2c-ocores.c            | 1 -
>  drivers/i2c/busses/i2c-octeon.c            | 1 -
>  drivers/i2c/busses/i2c-pca-platform.c      | 1 -
>  drivers/i2c/busses/i2c-piix4.c             | 1 -
>  drivers/i2c/busses/i2c-pmcmsp.c            | 1 -
>  drivers/i2c/busses/i2c-powermac.c          | 1 -
>  drivers/i2c/busses/i2c-puv3.c              | 1 -
>  drivers/i2c/busses/i2c-rcar.c              | 1 -
>  drivers/i2c/busses/i2c-scmi.c              | 1 -
>  drivers/i2c/busses/i2c-sh7760.c            | 1 -
>  drivers/i2c/busses/i2c-simtec.c            | 1 -
>  drivers/i2c/busses/i2c-sis630.c            | 1 -
>  drivers/i2c/busses/i2c-sis96x.c            | 1 -
>  drivers/i2c/busses/i2c-via.c               | 1 -
>  drivers/i2c/busses/i2c-xiic.c              | 1 -
>  drivers/i2c/busses/i2c-xlr.c               | 1 -
>  drivers/i2c/busses/scx200_i2c.c            | 1 -
>  drivers/i2c/muxes/i2c-arb-gpio-challenge.c | 1 -
>  drivers/i2c/muxes/i2c-mux-gpio.c           | 1 -
>  drivers/i2c/muxes/i2c-mux-pca9541.c        | 1 -
>  drivers/i2c/muxes/i2c-mux-pca954x.c        | 1 -
>  drivers/i2c/muxes/i2c-mux-pinctrl.c        | 1 -
>  43 files changed, 43 deletions(-)
> (...)

Looks good to me, thanks for doing this.

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

-- 
Jean Delvare
