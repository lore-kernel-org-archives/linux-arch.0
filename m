Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58670 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbeISBx3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 21:53:29 -0400
Date: Tue, 18 Sep 2018 22:19:14 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 03/20] signal/x86: Move MCE error reporting out
 of force_sig_info_fault
In-Reply-To: <20180918000546.12552-3-ebiederm@xmission.com>
Message-ID: <alpine.DEB.2.21.1809182217000.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-3-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Message-ID: <20180918201914.tAjjUTAtT_gpg_R_yNGhVftmSFe0QypmBGwR2NzhLpw@z>

On Tue, 18 Sep 2018, Eric W. Biederman wrote:
>  #ifdef CONFIG_MEMORY_FAILURE
>  	if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
> +		unsigned lsb = 0;

Newline between variable declaration and code please.

>  		printk(KERN_ERR
>  	"MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
>  			tsk->comm, tsk->pid, address);

Can you please convert that to pr_err() while at it?

> -		code = BUS_MCEERR_AR;
> +		if (fault & VM_FAULT_HWPOISON_LARGE)
> +			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
> +		if (fault & VM_FAULT_HWPOISON)
> +			lsb = PAGE_SHIFT;
> +		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb, tsk);
> +		return;
>  	}

With that fixed:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
