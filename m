From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 31/31] ARC: [plat-arcfpga] defconfig
Date: Wed, 7 Nov 2012 14:06:58 +0000
Message-ID: <201211071406.58304.arnd@arndb.de>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com> <1352281674-2186-32-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:62774 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab2KGOHA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Nov 2012 09:07:00 -0500
In-Reply-To: <1352281674-2186-32-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de

On Wednesday 07 November 2012, Vineet Gupta wrote:
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> ---
>  arch/arc/configs/fpga_defconfig |  607 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 607 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arc/configs/fpga_defconfig
> 
> diff --git a/arch/arc/configs/fpga_defconfig b/arch/arc/configs/fpga_defconfig
> new file mode 100644
> index 0000000..cfdca3c
> --- /dev/null
> +++ b/arch/arc/configs/fpga_defconfig
> @@ -0,0 +1,607 @@
> +#
> +# Automatically generated file; DO NOT EDIT.
> +# Linux/arc 3.7.0-rc3 Kernel Configuration
> +#

Please use "make defconfig" to generate minimal defconfig files, instead of
copying the entire file here.

	Arnd
