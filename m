Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:57671 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756669AbcCUPil (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2016 11:38:41 -0400
Date: Mon, 21 Mar 2016 16:38:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
Message-ID: <20160321153836.GZ6344@twins.programming.kicks-ass.net>
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-5-git-send-email-cmetcalf@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458147733-29338-5-git-send-email-cmetcalf@mellanox.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20160321153836.LZRHMiQJ5TrT67eGtq7kqnClxAepr3V6pVBvozkBYFo@z>

On Wed, Mar 16, 2016 at 01:02:13PM -0400, Chris Metcalf wrote:
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 48958d3cec9e..37afd721ec99 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -887,8 +887,8 @@ static void check_section(const char *modname, struct elf_info *elf,
>  #define ALL_EXIT_SECTIONS EXIT_SECTIONS, ALL_XXXEXIT_SECTIONS
>  
>  #define DATA_SECTIONS ".data", ".data.rel"
> -#define TEXT_SECTIONS ".text", ".text.unlikely", ".sched.text", \
> -		".kprobes.text"
> +#define TEXT_SECTIONS ".text", ".text.unlikely", \
> +		".kprobes.text", ".cpuidle.text"

Where did .sched.text go?

>  #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
>  		".fixup", ".entry.text", ".exception.text", ".text.*", \
>  		".coldtext"
