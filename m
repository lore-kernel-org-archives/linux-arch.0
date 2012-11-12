From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC Patch v1 38/55] ARC: Low level event capture/logging
Date: Mon, 12 Nov 2012 13:55:23 +0000
Message-ID: <201211121355.23947.arnd@arndb.de>
References: <1352720953-24321-1-git-send-email-vgupta@synopsys.com> <1352720953-24321-8-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:49764 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545Ab2KLNzc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Nov 2012 08:55:32 -0500
In-Reply-To: <1352720953-24321-8-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet.Gupta1@synopsys.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de

On Monday 12 November 2012, Vineet.Gupta1@synopsys.com wrote:
> +EXPORT_SYMBOL(take_snap);
> +
> ...
> +EXPORT_SYMBOL(take_snap2);

Where are these functions called?

Shouldn't this all just be part of the perf module?

If not, can you make the exports GPL-only?

	Arnd
