From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 2/2] arm: apply more __ro_after_init
Date: Wed, 10 Aug 2016 10:43:39 +0100
Message-ID: <20160810094339.GK1041@n2100.armlinux.org.uk>
References: <1464979224-2085-1-git-send-email-keescook@chromium.org>
 <1464979224-2085-3-git-send-email-keescook@chromium.org>
Reply-To: kernel-hardening@lists.openwall.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-hardening-return-4316-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Content-Disposition: inline
In-Reply-To: <1464979224-2085-3-git-send-email-keescook@chromium.org>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Kees Cook <keescook@chromium.org>
Cc: kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Mathias Krause <minipli@googlemail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Fri, Jun 03, 2016 at 11:40:24AM -0700, Kees Cook wrote:
> @@ -1309,16 +1309,11 @@ void __init arm_mm_memblock_reserve(void)
>   * Any other function or debugging method which may touch any device _will_
>   * crash the kernel.
>   */
> +static char vectors[PAGE_SIZE * 2] __ro_after_init __aligned(PAGE_SIZE);
>  static void __init devicemaps_init(const struct machine_desc *mdesc)
>  {
>  	struct map_desc map;
>  	unsigned long addr;
> -	void *vectors;
> -
> -	/*
> -	 * Allocate the vector page early.
> -	 */
> -	vectors = early_alloc(PAGE_SIZE * 2);

This one is not appropriate.  We _do_ write to these pages after init
for FIQ handler updates.  See set_fiq_handler().

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
