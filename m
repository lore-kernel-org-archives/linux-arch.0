From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 44/55] power_supply:irq: Remove IRQF_DISABLED
Date: Sat, 26 Nov 2011 00:35:40 +0400
Message-ID: <20111125203540.GA21345@oksana.dev.rtsoft.ru>
References: <1316681962-8217-1-git-send-email-yong.zhang0@gmail.com>
 <1316681962-8217-45-git-send-email-yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58823 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092Ab1KYUfq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 Nov 2011 15:35:46 -0500
Content-Disposition: inline
In-Reply-To: <1316681962-8217-45-git-send-email-yong.zhang0@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yong Zhang <yong.zhang0@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tglx@linutronix.de, Tejun Heo <tj@kernel.org>, Marek Vasut <marek.vasut@gmail.com>, Axel Lin <axel.lin@gmail.com>

On Thu, Sep 22, 2011 at 04:59:11PM +0800, Yong Zhang wrote:
> Since commit [e58aa3d2: genirq: Run irq handlers with interrupts disabled],
> We run all interrupt handlers with interrupts disabled
> and we even check and yell when an interrupt handler
> returns with interrupts enabled (see commit [b738a50a:
> genirq: Warn when handler enables interrupts]).
> 
> So now this flag is a NOOP and can be removed.
> 
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> ---

Applied, thanks!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
