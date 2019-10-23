Return-Path: <sean.j.christopherson@intel.com>
Date: Wed, 23 Oct 2019 07:16:16 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch V2 05/17] x86/traps: Make interrupt enable/disable
 symmetric in C code
Message-ID: <20191023141616.GE329@linux.intel.com>
References: <20191023122705.198339581@linutronix.de>
 <20191023123118.084086112@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023123118.084086112@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191023141616.Fqwn9JiEvp1suEwmcnRw8tCX4eUBM8aLis4vpFW17ns@z>

On Wed, Oct 23, 2019 at 02:27:10PM +0200, Thomas Gleixner wrote:
> Traps enable interrupts conditionally but rely on the ASM return code to
> disable them again. That results in redundant interrupt disable and trace
> calls.
> 
> Make the trap handlers disable interrupts before returning to avoid that,
> which allows simplification of the ASM entry code.
> 
> Originally-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
