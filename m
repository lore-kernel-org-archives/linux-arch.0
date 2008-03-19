From: Roland McGrath <roland-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 5/8] sparc64 ptrace: forced_successful_syscall_return()
Date: Wed, 19 Mar 2008 14:36:10 -0700 (PDT)
Message-ID: <20080319213610.244FC26F995@magilla.localdomain>
References: <20080319211714.8B14226F995@magilla.localdomain>
	<20080319212001.2DB8526F995@magilla.localdomain>
	<20080319.143037.180042261.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: David Miller's message of  Wednesday, 19 March 2008 14:30:37 -0700 <20080319.143037.180042261.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

> Acked-by: David S. Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>

Thanks!  Please follow up by taking the 7/8 and 8/8 patches as a model and
doing that one-line change to your arch_ptrace/compat_arch_ptrace functions
once the 6/8 generic patch has gone in.  I didn't send those patches for other
arch's than the ones I test myself, but it's just that one line in each
function (replace {compat_,}ptrace_request call with -ENOSYS), plus the
sanity-check testing that ptrace still works.

I sent the forced_successful_syscall_return() change for the affected
arch's I don't build because the 6/8 generic patch would break your arch
without it.


Thanks,
Roland
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
