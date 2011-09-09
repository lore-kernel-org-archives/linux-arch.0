From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch v3 17/36] Hexagon: Add interrupts
Date: Fri, 9 Sep 2011 15:04:58 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1109091502571.2723@ionos>
References: <20110909010847.294039464@codeaurora.org> <20110909010916.327107063@codeaurora.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53798 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758772Ab1IINFA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Sep 2011 09:05:00 -0400
In-Reply-To: <20110909010916.327107063@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Thu, 8 Sep 2011, Richard Kuo wrote:

> Removed init_IRQ wrapper and fixed up some comments.

> +int show_interrupts(struct seq_file *p, void *v)

Please use the generic version of show_interrupts.

Otherwise please add:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
