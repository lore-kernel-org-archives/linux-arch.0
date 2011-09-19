Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55942 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab1ISOGC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2011 10:06:02 -0400
Date: Mon, 19 Sep 2011 16:05:59 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 21/36] Hexagon: Add SMP support
In-Reply-To: <093448$3hstu8@wolverine01.qualcomm.com>
Message-ID: <alpine.LFD.2.02.1109191601380.2723@ionos>
References: <093448$3hstu8@wolverine01.qualcomm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20110919140559.E_H6sxlL4LZ-pJrsbmpYWpSRb7sIgSpL2v6LHG2VbN8@z>

On Wed, 14 Sep 2011, Richard Kuo wrote:
> +		case IPI_RESCHEDULE:
> +			/*
> +			 * need to revisit our exit path; see comments for
> +			 * scheduler_ipi()
> +			 */

  You mean the irqe_enter/exit() comment there? Your implementation
  should be fine as your IPIs come over the regular irq path which has
  the irq_enter/exit pair already.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
