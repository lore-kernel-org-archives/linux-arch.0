From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH 06/10] signal: Helpers for faults with specialized
 siginfo layouts
Date: Wed, 24 Jan 2018 11:26:32 -0800
Message-ID: <20180124192632.GA6671@ram.oc3035372033.ibm.com>
References: <87607s5lra.fsf_-_@xmission.com>
 <20180123210719.10456-6-ebiederm@xmission.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180123210719.10456-6-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 23, 2018 at 03:07:15PM -0600, Eric W. Biederman wrote:
> The helpers added are:
> send_sig_mceerr
> force_sig_mceerr
> force_sig_bnderr
> force_sig_pkuerr
> 
> Filling out siginfo properly can ge tricky.  Especially for these
> specialized cases where the temptation is to share code with other
> cases which use a different subset of siginfo fields.  Unfortunately
> that code sharing frequently results in bugs with the wrong siginfo
> fields filled in, and makes it harder to verify that the siginfo
> structure was properly initialized.
> 
> Provide these helpers instead that get all of the details right, and
> guarantee that siginfo is properly initialized.
> 
> send_sig_mceerr and force_sig_mceer are a little special as two si
> codes BUS_MCEERR_AO and BUS_MCEER_AR both use the same extended
> signinfo layout.

nice. i can make use of these helpers in the memory-key implementation.

One small nit-pick below though...

> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  include/linux/sched/signal.h |  6 +++++
>  kernel/signal.c              | 61 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h

...snip..

> +
> +#ifdef SEGV_PKUERR

Should this really be under SEGV_PKUERR ?  that macro is defined
unconditionally anyway.

> +int force_sig_pkuerr(void __user *addr, u32 pkey)
> +{
> +	struct siginfo info;
> +
> +	clear_siginfo(&info);
> +	info.si_signo = SIGSEGV;
> +	info.si_errno = 0;
> +	info.si_code  = SEGV_PKUERR;
> +	info.si_addr  = addr;
> +	info.si_pkey  = pkey;
> +	return force_sig_info(info.si_signo, &info, current);
> +}
> +#endif
