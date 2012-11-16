From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC PATCH v1 30/31] ARC: switch to generic kernel_execve() and
 sys_execve()
Date: Fri, 16 Nov 2012 04:08:47 +0000
Message-ID: <20121116040847.GA22671@ZenIV.linux.org.uk>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com>
 <1352281674-2186-31-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1352281674-2186-31-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, arnd@arndb.de
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 07, 2012 at 10:47:53AM +0100, Vineet Gupta wrote:
> +; When we land here, pt_regs have already been updated in-place correctly
> +; A pointer to them is also passed by kernel_execve, we just need to make sure
> +; that SP is set to point to them.
> +ARC_ENTRY ret_from_kernel_execve
> +	; Force SP to "normal" pt_regs just populated.
> +	b.d   ret_from_system_call
> +	mov   sp, r0

won't that splatter crap into regs->r0?  IOW, why not branch to
ret_from_exception here?

> +ARC_EXIT ret_from_kernel_execve

Another thing: why not fold that branch to ret_from_exception into the end of
ret_from_kernel_thread() (instead of calling sys_exit()), select
GENERIC_KERNEL_EXECVE and lose __ARCH_WANT_KERNEL_EXECVE.

Actually, now that I look at your ret_from_kernel_thread...  How the hell
will it cope with kernel_thread() payload trying to return?  AFAICS, this
j.d [r1] will lose the return address, won't it?  And while we are at it,
I would suggest passing callback and its argument via callee-saved registers -
makes for simpler life in ret_from_kernel_thread(), since switch_to() itself
will take care of loading those...
