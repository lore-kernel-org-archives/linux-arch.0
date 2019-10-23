Return-Path: <sean.j.christopherson@intel.com>
Date: Wed, 23 Oct 2019 06:43:45 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch V2 01/17] x86/entry/32: Remove unused resume_userspace
 label
Message-ID: <20191023134345.GA329@linux.intel.com>
References: <20191023122705.198339581@linutronix.de>
 <20191023123117.686514045@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023123117.686514045@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191023134345.EG2CbtCEne4gsi7BSvldzAeOqBZSV-jUM0nMJbjazO0@z>

On Wed, Oct 23, 2019 at 02:27:06PM +0200, Thomas Gleixner wrote:
> The C reimplementation of SYSENTER left that unused ENTRY() label
> around. Remove it.
> 
> Fixes: 5f310f739b4c ("x86/entry/32: Re-implement SYSENTER using the new C path")
> Originally-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
