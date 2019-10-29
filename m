Return-Path: <will@kernel.org>
Date: Tue, 29 Oct 2019 11:28:07 +0000
From: Will Deacon <will@kernel.org>
Subject: Re: [patch V2 00/17] entry: Provide generic implementation for host
 and guest entry/exit work
Message-ID: <20191029112806.GA12103@willie-the-truck>
References: <20191023122705.198339581@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023122705.198339581@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191029112807.NXBTI1_k5h7S0Lt4TVDk60vD3WXeiqOzlYIrZOFC4ho@z>

Hi Thomas,

On Wed, Oct 23, 2019 at 02:27:05PM +0200, Thomas Gleixner wrote:
> When working on a way to move out the posix cpu timer expiry out of the
> timer interrupt context, I noticed that KVM is not handling pending task
> work before entering a guest. A quick hack was to add that to the x86 KVM
> handling loop. The discussion ended with a request to make this a generic
> infrastructure possible with also moving the per arch implementations of
> the enter from and return to user space handling generic.
> 
>   https://lore.kernel.org/r/89E42BCC-47A8-458B-B06A-D6A20D20512C@amacapital.net
> 
> The series implements the syscall enter/exit and the general exit to
> userspace work handling along with the pre guest enter functionality.
> 
> Changes vs. RFC version:
> 
>   - Dropped ARM64 conversion as requested by ARM64 folks

If you fancy another crack at arm64 on your way back from Lyon, we've now
got more of the asm->C conversion queued up here:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/entry-s-to-c

No worries if not, but figured it was worth letting you know anyway.

Will
