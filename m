From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC Patch v1 32/55] ARC: [optim] Cache "current" in Register r25
Date: Mon, 12 Nov 2012 13:50:12 +0000
Message-ID: <201211121350.12810.arnd@arndb.de>
References: <1352720953-24321-1-git-send-email-vgupta@synopsys.com> <1352720953-24321-2-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53735 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804Ab2KLNu0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Nov 2012 08:50:26 -0500
In-Reply-To: <1352720953-24321-2-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet.Gupta1@synopsys.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de

On Monday 12 November 2012, Vineet.Gupta1@synopsys.com wrote:
> 
>  endmenu # "Platform Board Configuration"
>  
> +config ARC_CURR_IN_REG
> +       bool "Dedicate Register r25 for current_task pointer"
> +       default y
> +       help
> +         This reserved Register R25 to point to Current Task in
> +         kernel mode. This saves memory access for each such access
> +

This looks like a useful feature if you have 32 GPRs, but why make it
optional? Are there cases where you would disable it?

Another alternative to caching "current" would be to cache the per-cpu
offset, and calculate current from that one.

	Arnd
