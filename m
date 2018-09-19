Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:47844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeISLXL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Sep 2018 07:23:11 -0400
Date: Tue, 18 Sep 2018 22:46:53 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [REVIEW][PATCH 02/20] signal/x86: Inline fill_sigtrap_info in
 it's only caller send_sigtrap
Message-ID: <20180919054653.GA32263@infradead.org>
References: <87y3bzk6yv.fsf@xmission.com>
 <20180918000546.12552-2-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918000546.12552-2-ebiederm@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Message-ID: <20180919054653.T8Go-UkjnDasyX7Y-J6kz0tozVcbyw33Lm04lg9YTws@z>

>  
>  	clear_siginfo(&info);
> -	fill_sigtrap_info(tsk, regs, error_code, si_code, &info);
> +	tsk->thread.trap_nr = X86_TRAP_DB;
> +	tsk->thread.error_code = error_code;
> +
> +	info.si_signo = SIGTRAP;
> +	info.si_code = si_code;
> +	info.si_addr = user_mode(regs) ? (void __user *)regs->ip : NULL;

clear_siginfo already zeroes the whole structure, so this could be
written more clearly as:

	if (user_mode(regs)
		info.si_addr = (void __user *)regs->ip;
