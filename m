Return-Path: <sean.j.christopherson@intel.com>
Date: Wed, 23 Oct 2019 06:45:06 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch V2 02/17] x86/entry/64: Remove pointless jump in
 paranoid_exit
Message-ID: <20191023134505.GB329@linux.intel.com>
References: <20191023122705.198339581@linutronix.de>
 <20191023123117.779277679@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023123117.779277679@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191023134506.uqNwRNx2TzSzTfDgMqgp3SLTwImvb0ZXC1jTR_w-n3Y@z>

On Wed, Oct 23, 2019 at 02:27:07PM +0200, Thomas Gleixner wrote:
> Jump directly to restore_regs_and_return_to_kernel instead of making
> a pointless extra jump through .Lparanoid_exit_restore
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
