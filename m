Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:59784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1Wkn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Sep 2018 18:40:43 -0400
Date: Fri, 28 Sep 2018 09:16:09 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V6 05/33] csky: System Call
Message-ID: <20180928161609.GD19827@infradead.org>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <c98f0fc0103196e839bdc016f50f227fce8c54b1.1538058840.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c98f0fc0103196e839bdc016f50f227fce8c54b1.1538058840.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com
Message-ID: <20180928161609.Ed80Ciy3NYFQ0FrcZ5-Y7p_kLdzhm6DgkrF5MIFJiQ4@z>

> +
> +static inline void
> +syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
> +		      unsigned int i, unsigned int n, const unsigned long *args)
> +{
> +	BUG_ON(i + n > 6);
> +        if (i == 0) {

Please fix your indentation - again checkpatch.pl will be helpful (even
if it sometimes is a littler overzealous).
