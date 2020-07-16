From: Kees Cook <keescook@chromium.org>
Subject: Re: [patch V3 07/13] x86/ptrace: Provide pt_regs helpers for
 entry/exit
Date: Thu, 16 Jul 2020 13:57:54 -0700
Message-ID: <202007161357.70EF223F@keescook>
References: <20200716182208.180916541@linutronix.de>
 <20200716185424.658427667@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200716185424.658427667@linutronix.de>
Sender: kvm-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 16, 2020 at 08:22:15PM +0200, Thomas Gleixner wrote:
> As a preparatory step for moving the syscall and interrupt entry/exit
> handling into generic code, provide pt_regs helpers which allow to:
> 
>   - Retrieve the syscall number from pt_regs
>   - Retrieve the syscall return value from pt_regs
>   - Retrieve the interrupt state from pt_regs to check whether interrupts
>     are reenabled by return from interrupt/exception.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
