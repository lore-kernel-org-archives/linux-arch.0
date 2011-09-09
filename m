Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56202 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758574Ab1IIIM5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Sep 2011 04:12:57 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v3 14/36] Hexagon: Add signal functions
Date: Fri, 09 Sep 2011 10:12:38 +0200
Message-ID: <3380882.JqAqX4juos@wuerfel>
In-Reply-To: <20110909010916.028280867@codeaurora.org>
References: <20110909010847.294039464@codeaurora.org> <20110909010916.028280867@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Linas Vepstas <linas@codeaurora.org>
Message-ID: <20110909081238.tgTc7a_pcWtj2MF1h7smeVCcuZVZbD2UmRmepK_kszE@z>

On Thursday 08 September 2011 20:09:01 Richard Kuo wrote:
> +/*
> + * Signal context structure - contains all info to do with the state
> + * before the signal handler was invoked.
> + */
> +struct sigcontext {
> +       struct pt_regs sc_regs;
> +};

I've recently discussed this with Martin Schwidefsky for an unrelated reason,
but I think now that you should define the sigcontext independent of pt_regs.
The pt_regs should really be internal 

> +struct sigframe {
> +       unsigned long pad[2]; /* Used to be signal tramp */
> +       struct sigcontext sc;
> +       sigset_t mask;
> +};
> +
> +struct rt_sigframe {
> +       unsigned long pad[2]; /* Used to be signal tramp */
> +       struct siginfo info;
> +       struct ucontext uc;
> +};

I hadn't noticed this earlier, but I think you can remove the struct sigframe
definition. There should be absolutely no need to have both sigframe and
rt_sigframe.

	Arnd
