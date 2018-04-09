From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 0/3] syscalls: clean up stub naming convention
Date: Mon, 9 Apr 2018 08:54:54 +0200
Message-ID: <20180409065454.GB6676@light.dominikbrodowski.net>
References: <20180407074651.29014-1-linux@dominikbrodowski.net>
 <20180408083550.32d65b6ra6yca5p7@gmail.com>
 <20180408091536.GA10120@light.dominikbrodowski.net>
 <20180408195952.GA27462@light.dominikbrodowski.net>
 <20180409064945.wpj4knmalpb4fm2t@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180409064945.wpj4knmalpb4fm2t@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Maninder Singh <maninder1.s@samsung.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 09, 2018 at 08:49:45AM +0200, Ingo Molnar wrote:
> 
> * Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> 
> > +emit_stub() {
> > +    entry="$1"
> > +    if [ "${entry}" != "${entry#__ia32_sys_}" ]; then
> > +	# We need a stub named __ia32_sys which is common to 64-bit
> > +	# except for a different pt_regs layout.
> > +	stubname=${entry#__ia32_sys_}
> > +	echo "#define __IA32_SYS_STUBx_${stubname} __IA32_SYS_STUBx"
> > +	echo "#define ASM_X86_HAS__ia32_sys_${stubname} 1"
> > +    elif [ "$entry" != "${entry#__x32_compat_sys}" ]; then
> > +	# We need a stub named __x32_compat_sys_ which decodes a
> > +	# 64-bit pt_regs and then calls the real syscall function 
> > +	stubname="${entry%%/*}" # handle qualifier
> > +	stubname=${stubname#__x32_compat_sys_} # handle prefix
> > +	echo "#define __X32_COMPAT_SYS_STUBx_${stubname} __X32_COMPAT_SYS_STUBx"
> > +	echo "#define ASM_X86_HAS__x32_compat_sys_${stubname} 1"
> > +    elif [ "$entry" != "${entry#__ia32_compat_sys_x86}" ]; then
> > +	# The compat entry starts with __ia32_compat_sys_x86, so it
> > +	# is a specific x86 compat syscall; no need for __ia32_sys_*()
> > +	stubname=${entry#__ia32_compat_sys_x86_}
> > +	echo "#define __IA32_SYS_STUBx_${stubname} __SYSCALL_STUBx_UNUSED"
> > +	echo "#define ASM_X86_HAS__ia32_sys_${stubname} 1"
> > +    elif [ "$entry" != "${entry#__ia32_compat_sys_}" ]; then
> > +	# The compat entry starts with __ia32_compat_sys, so it is
> > +	# is a generic x86 compat syscall; no need for __ia32_sys_*()
> > +	stubname=${entry#__ia32_compat_sys_}
> > +	echo "#define __IA32_SYS_STUBx_${stubname} __SYSCALL_STUBx_UNUSED"
> > +	echo "#define ASM_X86_HAS__ia32_sys_${stubname} 1"
> > +    fi;
> > +}
> 
> I only have a bikeshed painting comment, even in shell scripts please try to 
> follow the kernel comment style visually, i.e. something like:
> 
> > +    if [ "${entry}" != "${entry#__ia32_sys_}" ]; then
> > +
> > +	#
> > +	# We need a stub named __ia32_sys which is common to 64-bit
> > +	# except for a different pt_regs layout.
> > +	#
> > +	stubname=${entry#__ia32_sys_}
> > +	echo "#define __IA32_SYS_STUBx_${stubname} __IA32_SYS_STUBx"
> > +	echo "#define ASM_X86_HAS__ia32_sys_${stubname} 1"
> > +
> > +    elif [ "$entry" != "${entry#__x32_compat_sys}" ]; then
> > +
> > +	#
> > +	# We need a stub named __x32_compat_sys_ which decodes a
> > +	# 64-bit pt_regs and then calls the real syscall function 
> > +     #
> > +	stubname="${entry%%/*}" # handle qualifier
> > +	stubname=${stubname#__x32_compat_sys_} # handle prefix
> > +	echo "#define __X32_COMPAT_SYS_STUBx_${stubname} __X32_COMPAT_SYS_STUBx"
> > +	echo "#define ASM_X86_HAS__x32_compat_sys_${stubname} 1"
> > +
> > +    elif [ "$entry" != "${entry#__ia32_compat_sys_x86}" ]; then
> > +
> > +     #
> > +	# The compat entry starts with __ia32_compat_sys_x86, so it
> > +	# is a specific x86 compat syscall; no need for __ia32_sys_*()
> > +     #
> > +	stubname=${entry#__ia32_compat_sys_x86_}
> > +	echo "#define __IA32_SYS_STUBx_${stubname} __SYSCALL_STUBx_UNUSED"
> > +	echo "#define ASM_X86_HAS__ia32_sys_${stubname} 1"
> > +
> > +    elif [ "$entry" != "${entry#__ia32_compat_sys_}" ]; then
> > +
> > +     #
> > +	# The compat entry starts with __ia32_compat_sys, so it is
> > +	# is a generic x86 compat syscall; no need for __ia32_sys_*()
> > +     #
> > +	stubname=${entry#__ia32_compat_sys_}
> > +	echo "#define __IA32_SYS_STUBx_${stubname} __SYSCALL_STUBx_UNUSED"
> > +	echo "#define ASM_X86_HAS__ia32_sys_${stubname} 1"
> > +
> > +    fi;
> 
> ( Also note the vertical separation that helps see the overall structure a bit 
>   better. )
> 
> But more fundamentally, that's an awful lot of complex scripting to save 4K 
> (unused) kernel text, not sure it's worth it.

Yes. I just wanted to see myself whether it's worthwile, and it indeed
doesn't seem so. That's exactly why I didn't sign off on it so far...

Thanks,
	Dominik
