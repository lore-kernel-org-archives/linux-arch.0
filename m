Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50014 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730790AbfEWQPN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 May 2019 12:15:13 -0400
Date: Thu, 23 May 2019 17:15:09 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [REVIEW][PATCHv2 03/26] signal/arm64: Use force_sig not
 force_sig_fault for SIGKILL
Message-ID: <20190523161509.GE31896@fuggles.cambridge.arm.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
 <20190523003916.20726-4-ebiederm@xmission.com>
 <20190523101702.GG26646@fuggles.cambridge.arm.com>
 <875zq1gnh4.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zq1gnh4.fsf_-_@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>
Message-ID: <20190523161509.dBPUZPuxPCUiriG8v7xN4GjMkgsg4jJTURW5XwKzpO0@z>

On Thu, May 23, 2019 at 11:11:19AM -0500, Eric W. Biederman wrote:
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index ade32046f3fe..e45d5b440fb1 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -256,7 +256,10 @@ void arm64_force_sig_fault(int signo, int code, void __user *addr,
>  			   const char *str)
>  {
>  	arm64_show_signal(signo, str);
> -	force_sig_fault(signo, code, addr, current);
> +	if (signo == SIGKILL)
> +		force_sig(SIGKILL, current);
> +	else
> +		force_sig_fault(signo, code, addr, current);
>  }

Acked-by: Will Deacon <will.deacon@arm.com>

Are you planning to send this series on, or would you like me to pick this
into the arm64 tree?

Will
