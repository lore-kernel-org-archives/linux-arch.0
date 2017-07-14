Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:41867 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753472AbdGNLHO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jul 2017 07:07:14 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <87efu22set.fsf@xmission.com>
        <20170630123906.8865-1-ebiederm@xmission.com>
        <20170702141320.GA32254@ls3530.fritz.box>
Date: Fri, 14 Jul 2017 05:59:06 -0500
In-Reply-To: <20170702141320.GA32254@ls3530.fritz.box> (Helge Deller's message
        of "Sun, 2 Jul 2017 16:13:20 +0200")
Message-ID: <87fudz5lol.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 1/8] signal/alpha: Document a conflict with SI_USER for SIGTRAP
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, Andrei Vagin <avagin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Greg KH <greg@kroah.com>, Andrey Vagin <avagin@openvz.org>, Serge Hallyn <serge@hallyn.com>, Pavel Emelyanov <xemul@virtuozzo.com>, Cyrill Gorcunov <gorcunov@openvz.org>, Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Linux Containers <containers@lists.linux-foundation.org>, Michael Kerrisk <mtk.manpages@gmail.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Message-ID: <20170714105906.0Ee6NxC40XQ376GAtQKYUDAcb3W0SQkWk4t5MjyesVk@z>

Helge Deller <deller@gmx.de> writes:

> * Eric W. Biederman <ebiederm@xmission.com>:
>> Setting si_code to __SI_FAULT results in a userspace seeing
>> an si_code of 0.  This is the same si_code as SI_USER.  Posix
>> and common sense requires that SI_USER not be a signal specific
>> si_code.  As such this use of 0 for the si_code is a pretty
>> horribly broken ABI.
>> 
>> Given that alpha is on it's last legs I don't know that it is worth
>> fixing this, but it is worth documenting what is going on so that
>> no one decides to copy this bad decision.
>
> The ABI was already broken, so IMHO I think it's better to somehow "fix"
> it instead. Agreed, alpha and some other architectures are already aged,
> but nevertheless most of them build in debian-ports.  Below is a
> suggested fix which reuses/misuses other existing trap codes instead.

The conflict with SI_USER is real.  I don't know that we have any actual
applications that are suffering.

I simply don't have the architecture specific references handy to know
in which cases the oddities will happen let alone test them.  Plus at
least for ia64 and alpha those architectures don't appear to be
receiving updates for new syscalls, and no new hardware is being built
so I don't know how much longer they will last.

That is building for alpha gives:
>   CALL    /home/eric/projects/linux/linux-exit-cleanups/scripts/checksyscalls.sh
> <stdin>:1239:2: warning: #warning syscall seccomp not implemented [-Wcpp]
> <stdin>:1248:2: warning: #warning syscall bpf not implemented [-Wcpp]
> <stdin>:1299:2: warning: #warning syscall userfaultfd not implemented [-Wcpp]
> <stdin>:1302:2: warning: #warning syscall membarrier not implemented [-Wcpp]
> <stdin>:1305:2: warning: #warning syscall mlock2 not implemented [-Wcpp]
> <stdin>:1308:2: warning: #warning syscall copy_file_range not implemented [-Wcpp]
> <stdin>:1311:2: warning: #warning syscall preadv2 not implemented [-Wcpp]
> <stdin>:1314:2: warning: #warning syscall pwritev2 not implemented [-Wcpp]
> <stdin>:1317:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
> <stdin>:1320:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
> <stdin>:1323:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
> <stdin>:1326:2: warning: #warning syscall statx not implemented [-Wcpp]

But a real fix like you have shown if you can get it approved by the
alpha architecture maintainers I am more than happy to see, and would
very much prefer.

You certainly noticed that the middle case was SIGFPE when I missed
that.

Unfortunately I don't currently have the competence to judge the
effects of your patch.

Eric

> Helge
>
> Signed-off-by: Helge Deller <deller@gmx.de>
>
> diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
> index 65bb102..2ed37dd 100644
> --- a/arch/alpha/kernel/traps.c
> +++ b/arch/alpha/kernel/traps.c
> @@ -278,7 +278,7 @@ do_entIF(unsigned long type, struct pt_regs *regs)
>  	      case 1: /* bugcheck */
>  		info.si_signo = SIGTRAP;
>  		info.si_errno = 0;
> -		info.si_code = __SI_FAULT;
> +		info.si_code = TRAP_HWBKPT;
>  		info.si_addr = (void __user *) regs->pc;
>  		info.si_trapno = 0;
>  		send_sig_info(SIGTRAP, &info, current);
> @@ -318,7 +318,7 @@ do_entIF(unsigned long type, struct pt_regs *regs)
>  			break;
>  		case GEN_ROPRAND:
>  			signo = SIGFPE;
> -			code = __SI_FAULT;
> +			code = FPE_FLTSUB;
>  			break;
>  
>  		case GEN_DECOVF:
> @@ -340,7 +340,7 @@ do_entIF(unsigned long type, struct pt_regs *regs)
>  		case GEN_SUBRNG7:
>  		default:
>  			signo = SIGTRAP;
> -			code = __SI_FAULT;
> +			code = TRAP_HWBKPT;
>  			break;
>  		}
>  
