From: Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH] Kconfig cleanup (PARPORT_PC dependencies)
Date: Thu, 12 Sep 2013 12:13:51 -0700
Message-ID: <5232126F.90907@twiddle.net>
References: <1379012038-31764-1-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:60827 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321Ab3ILTN7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Sep 2013 15:13:59 -0400
In-Reply-To: <1379012038-31764-1-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, vgupta@synopsys.com, linux@arm.linux.org.uk, tony.luck@intel.com, geert@linux-m68k.org, monstr@monstr.eu, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, lethal@linux-sh.org, davem@davemloft.net, cmetcalf@tilera.com, gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com

On 09/12/2013 11:53 AM, Mark Salter wrote:
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index 082d9b4..0f8fa2c 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -520,6 +520,9 @@ config EISA
>  config ARCH_MAY_HAVE_PC_FDC
>  	def_bool y
>  
> +config ARCH_MAY_HAVE_PC_PARPORT
> +	def_bool y
> +

Acked-by: Richard Henderson <rth@twiddle.net>


r~
