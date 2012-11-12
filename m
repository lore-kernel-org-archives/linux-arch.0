From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC Patch v1 52/55] ARC: Support for single cycle Close Coupled Mem (CCM)
Date: Mon, 12 Nov 2012 14:10:02 +0000
Message-ID: <201211121410.02682.arnd@arndb.de>
References: <1352720953-24321-1-git-send-email-vgupta@synopsys.com> <1352720953-24321-22-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57830 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab2KLOKM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Nov 2012 09:10:12 -0500
In-Reply-To: <1352720953-24321-22-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet.Gupta1@synopsys.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de

On Monday 12 November 2012, Vineet.Gupta1@synopsys.com wrote:
> +config ARC_DCCM_SZ
> +       int "DCCM Size in KB"
> +       default "64"
> +       depends on ARC_HAS_DCCM
> +
> +config ARC_DCCM_BASE
> +       hex "DCCM map address"
> +       default "0xA0000000"
> +       depends on ARC_HAS_DCCM
> +

I suppose these should be configured from the device tree at boot time, not
during the build process.

I also wonder if the interface should be unified with what we use for
accessing the sram on some of the ARM platforms.

	Arnd
