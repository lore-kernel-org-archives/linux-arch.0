Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr10097.outbound.protection.outlook.com ([40.107.1.97]:36208
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752652AbdGLWge (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Jul 2017 18:36:34 -0400
Date: Wed, 12 Jul 2017 15:36:04 -0700
From: Andrei Vagin <avagin@virtuozzo.com>
Subject: Re: [PATCH 8/8] signal: Remove kernel interal si_code magic
Message-ID: <20170712223557.GA21885@outlook.office365.com>
References: <87efu22set.fsf@xmission.com>
 <20170630123906.8865-8-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20170630123906.8865-8-ebiederm@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Greg KH <greg@kroah.com>, Andrey Vagin <avagin@openvz.org>, Serge Hallyn <serge@hallyn.com>, Pavel Emelyanov <xemul@virtuozzo.com>, Cyrill Gorcunov <gorcunov@openvz.org>, Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Linux Containers <containers@lists.linux-foundation.org>, Michael Kerrisk <mtk.manpages@gmail.com>
Message-ID: <20170712223604.c3l0ByDN8luVr0zw2nrbvbuMMx6DXjPm5VIscqjUuWI@z>

On Fri, Jun 30, 2017 at 07:39:06AM -0500, Eric W. Biederman wrote:
> struct siginfo is a union and the kernel since 2.4 has been hiding a union
> tag in the high 16bits of si_code using the values:
> __SI_KILL
> __SI_TIMER
> __SI_POLL
> __SI_FAULT
> __SI_CHLD
> __SI_RT
> __SI_MESGQ
> __SI_SYS
> 
> While this looks plausible on the surface, in practice this situation has
> not worked well.
> 
> - Injected positive signals are not copied to user space properly
>   unless they have these magic high bits set.
> 
> - Injected positive signals are not reported properly by signalfd
>   unless they have these magic high bits set.
> 
> - These kernel internal values leaked to userspace via ptrace_peek_siginfo
> 
> - It was possible to inject these kernel internal values and cause the
>   the kernel to misbehave.
> 
> - Kernel developers got confused and expected these kernel internal values
>   in userspace in kernel self tests.
> 
> - Kernel developers got confused and set si_code to __SI_FAULT which
>   is SI_USER in userspace which causes userspace to think an ordinary user
>   sent the signal and that it was not kernel generated.
> 
> - The values make it impossible to reorganize the code to transform
>   siginfo_copy_to_user into a plain copy_to_user.  As si_code must
>   be massaged before being passed to userspace.
> 
> So remove these kernel internal si codes and make the kernel code simpler
> and more maintainable.
> 
> To replace these kernel internal magic si_codes introduce the helper
> function siginfo_layout, that takes a signal number and an si_code and
> computes which union member of siginfo is being used.  Have
> siginfo_layout return an enumeration so that gcc will have enough
> information to warn if a switch statement does not handle all of union
> members.
> 
> A couple of architectures have a messed up ABI that defines signal
> specific duplications of SI_USER which causes more special cases in
> siginfo_layout than I would like.  The good news is only problem
> architectures pay the cost.
> 
> Update all of the code that used the previous magic __SI_ values to
> use the new SIL_ values and to call siginfo_layout to get those
> values.  Escept where not all of the cases are handled remove the
> defaults in the switch statements so that if a new case is missed in
> the future the lack will show up at compile time.
> 
> Modify the code that copies siginfo si_code to userspace to just copy
> the value and not cast si_code to a short first.  The high bits are no
> longer used to hold a magic union member.
> 
> Fixup the siginfo header files to stop including the __SI_ values in
> their constants and for the headers that were missing it to properly
> update the number of si_codes for each signal type.
> 
> The fixes to copy_siginfo_from_user32 implementations has the
> interesting property that several of them perviously should never have
> worked as the __SI_ values they depended up where kernel internal.
> With that dependency gone those implementations should work much
> better.
> 
> The idea of not passing the __SI_ values out to userspace and then
> not reinserting them has been tested with criu and criu worked without
> changes.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/alpha/include/uapi/asm/siginfo.h    |   2 +-
>  arch/arm64/kernel/signal32.c             |  23 +++----
>  arch/blackfin/include/uapi/asm/siginfo.h |  30 +++++----
>  arch/frv/include/uapi/asm/siginfo.h      |   2 +-
>  arch/ia64/include/uapi/asm/siginfo.h     |  20 +++---
>  arch/ia64/kernel/signal.c                |  17 +++---
>  arch/mips/include/uapi/asm/siginfo.h     |   6 +-
>  arch/mips/kernel/signal32.c              |  19 +++---
>  arch/parisc/kernel/signal32.c            |  31 +++++-----
>  arch/powerpc/kernel/signal_32.c          |  20 +++---
>  arch/s390/kernel/compat_signal.c         |  32 +++++-----
>  arch/sparc/include/uapi/asm/siginfo.h    |   4 +-
>  arch/sparc/kernel/signal32.c             |  16 ++---
>  arch/tile/include/uapi/asm/siginfo.h     |   4 +-
>  arch/tile/kernel/compat_signal.c         |  18 +++---
>  arch/tile/kernel/traps.c                 |   1 -
>  arch/x86/kernel/signal_compat.c          |  21 +++----
>  fs/fcntl.c                               |   2 +-
>  fs/signalfd.c                            |  22 +++----
>  include/asm-generic/siginfo.h            |  22 ++++---
>  include/uapi/asm-generic/siginfo.h       | 102 ++++++++++++++-----------------
>  kernel/compat.c                          |   2 -
>  kernel/exit.c                            |   6 +-
>  kernel/ptrace.c                          |   6 +-
>  kernel/signal.c                          |  72 ++++++++++++++++------
>  25 files changed, 254 insertions(+), 246 deletions(-)
> 
<...>
> diff --git a/arch/tile/kernel/traps.c b/arch/tile/kernel/traps.c
> index 54804866f238..4433d1dc28e6 100644
> --- a/arch/tile/kernel/traps.c
> +++ b/arch/tile/kernel/traps.c
> @@ -188,7 +188,6 @@ static int special_ill(tile_bundle_bits bundle, int *sigp, int *codep)
>  
>  	/* Make it the requested signal. */
>  	*sigp = sig;
> -	*codep = code | __SI_FAULT;

Are you sure that we don't need to set codep here?

>  	return 1;
>  }
>  
