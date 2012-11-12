From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC Patch v1 48/55] ARC: [plat-arfpga] BVCI Latency Unit setup
Date: Mon, 12 Nov 2012 14:02:44 +0000
Message-ID: <201211121402.45019.arnd@arndb.de>
References: <1352720953-24321-1-git-send-email-vgupta@synopsys.com> <1352720953-24321-18-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:50907 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab2KLOCy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Nov 2012 09:02:54 -0500
In-Reply-To: <1352720953-24321-18-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet.Gupta1@synopsys.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de

On Monday 12 November 2012, Vineet.Gupta1@synopsys.com wrote:
> +       /* TBD: rewrite this using I/O macros */
> +       volatile unsigned int *base = (unsigned int *)BVCI_LAT_UNIT_BASE;
> +       volatile unsigned int *lat_unit = (unsigned int *)base + 21;
> +       volatile unsigned int *lat_val = (unsigned int *)base + 22;

Yes, you should do as the comment says.

	Arnd
