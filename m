From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 21/36] Hexagon: Add SMP support
Date: Mon, 19 Sep 2011 16:05:59 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1109191601380.2723@ionos>
References: <093448$3hstu8@wolverine01.qualcomm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <093448$3hstu8@wolverine01.qualcomm.com>
Sender: linux-hexagon-owner@vger.kernel.org
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
