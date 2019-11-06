Return-Path: <alexandre.chartre@oracle.com>
Subject: Re: [patch V2 03/17] x86/traps: Remove pointless irq enable from
 do_spurious_interrupt_bug()
References: <20191023122705.198339581@linutronix.de>
 <20191023123117.871608831@linutronix.de>
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <52673a2a-6e6e-c0f1-9586-70849429e7a0@oracle.com>
Date: Wed, 6 Nov 2019 16:33:16 +0100
MIME-Version: 1.0
In-Reply-To: <20191023123117.871608831@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191106153316.p4hSbdglVkphvHpj125_RHxeZudReBlIQAnE_FTwgV4@z>


On 10/23/19 2:27 PM, Thomas Gleixner wrote:
> That function returns immediately after conditionally reenabling interrupts which
> is more than pointless and requires the ASM code to disable interrupts again.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/kernel/traps.c |    1 -
>   1 file changed, 1 deletion(-)
> 

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.
