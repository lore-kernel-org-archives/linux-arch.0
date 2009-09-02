From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 8/9] KEYS: Extend TIF_NOTIFY_RESUME to (almost) all
	architectures [try #5]
Date: Wed, 2 Sep 2009 09:05:43 +0100
Message-ID: <20090902080542.GA29221@flint.arm.linux.org.uk>
References: <20090902072053.3578.69125.stgit@warthog.procyon.org.uk> <20090902072129.3578.81364.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-security-module-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090902072129.3578.81364.stgit@warthog.procyon.org.uk>
Sender: linux-security-module-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: jmorris@namei.org, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 02, 2009 at 08:21:29AM +0100, David Howells wrote:
> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> index f6bc5d4..6759f45 100644
> --- a/arch/arm/kernel/signal.c
> +++ b/arch/arm/kernel/signal.c
> @@ -707,4 +707,9 @@ do_notify_resume(struct pt_regs *regs, unsigned int thread_flags, int syscall)
>  {
>  	if (thread_flags & _TIF_SIGPENDING)
>  		do_signal(&current->blocked, regs, syscall);
> +
> +	if (thread_info_flags & _TIF_NOTIFY_RESUME) {

This still has the same error - is this just a repost of the previous
patch?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
