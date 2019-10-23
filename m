Return-Path: <sean.j.christopherson@intel.com>
Date: Wed, 23 Oct 2019 07:20:52 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch V2 07/17] x86/entry/64: Remove redundant interrupt disable
Message-ID: <20191023142052.GG329@linux.intel.com>
References: <20191023122705.198339581@linutronix.de>
 <20191023123118.296135499@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023123118.296135499@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191023142052.H3Tsb21aqbffxi5VSft8tjtEaISVQQyCMvImSdRZWMY@z>

On Wed, Oct 23, 2019 at 02:27:12PM +0200, Thomas Gleixner wrote:
> Now that the trap handlers return with interrupts disabled, the
> unconditional disabling of interrupts in the low level entry code can be
> removed along with the trace calls.
> 
> Add debug checks where appropriate.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
