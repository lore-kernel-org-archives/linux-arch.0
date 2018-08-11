From: Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH 3/6] alpha: Unify the not-implemented system call entry
 name
Date: Fri, 10 Aug 2018 19:31:55 -0700
Message-ID: <98937991-cefa-b7f3-11c3-12727b3159b1@twiddle.net>
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
 <1531736638-15294-4-git-send-email-firoz.khan@linaro.org>
 <20180811000455.GC6515@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180811000455.GC6515@ZenIV.linux.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>, Firoz Khan <firoz.khan@linaro.org>
Cc: linux-alpha@vger.kernel.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com
List-Id: linux-arch.vger.kernel.org

On 08/10/2018 05:04 PM, Al Viro wrote:
> Once upon a time it used to have a C part that printed a warning
> about unimplemented OSF syscalls.  That's what it's been doing
> all over the OSF syscall range, while the native Linux syscall
> range uses sys_ni_syscall().
> 
> With those warnings about unimplemented OSF syscalls gone (circa 2.4),
> alpha_ni_syscall() has shrunk to that little bit of asm and the
> only reason it hasn't been replaced with sys_ni_syscall() everywhere
> is that extra twist needed in case of syscall #0.
> 
> Let's keep it only for syscall #0 and replace the rest with sys_ni_syscall.
> And use sys_ni_syscall for "number out range" in ptraced-call case, as
> we'd been doing for normal codepath since 2.1.86...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Richard Henderson <rth@twiddle.net>


> +++ b/arch/alpha/kernel/entry.S
> @@ -473,7 +473,7 @@ entSys:
>  	bne     $3, strace
>  	beq	$4, 1f
>  	ldq	$27, 0($5)
> -1:	jsr	$26, ($27), alpha_ni_syscall
> +1:	jsr	$26, ($27), sys_ni_syscall
>  	ldgp	$gp, 0($26)
>  	blt	$0, $syscall_error	/* the call failed */
>  	stq	$0, 0($sp)

Once upon a time I had a patch to make the hint
be sys_gettimeofday, as the most common syscall.
Dunno what happened to that.

But I must guess that an unimplemented syscall has got
to be the anti-hint of the ... long-ass-time-frame.


r~
