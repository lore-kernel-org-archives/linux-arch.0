Return-Path: <sean.j.christopherson@intel.com>
Date: Wed, 23 Oct 2019 07:16:04 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch V2 04/17] x86/entry: Make DEBUG_ENTRY_ASSERT_IRQS_OFF
 available for 32bit
Message-ID: <20191023141603.GD329@linux.intel.com>
References: <20191023122705.198339581@linutronix.de>
 <20191023123117.976831752@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023123117.976831752@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191023141604.A6ATMEgsm-_CapbWSyf8JT6ROmKYzE7VXUfrcZjfUWY@z>

On Wed, Oct 23, 2019 at 02:27:09PM +0200, Thomas Gleixner wrote:
> Move the interrupt state verification debug macro to common code and fixup
> the irqflags and paravirt components so it can be used in 32bit code later.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
