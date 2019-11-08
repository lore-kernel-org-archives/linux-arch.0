Return-Path: <alexandre.chartre@oracle.com>
Subject: Re: [patch V2 06/17] x86/entry/32: Remove redundant interrupt disable
References: <20191023122705.198339581@linutronix.de>
 <20191023123118.191230255@linutronix.de>
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <f8ba6ab8-c42d-f90f-f296-de270d1a7e21@oracle.com>
Date: Fri, 8 Nov 2019 11:41:45 +0100
MIME-Version: 1.0
In-Reply-To: <20191023123118.191230255@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191108104145.7QigZs8tpw-Rat9mXr-4TuzH6UJOpKWz04FfBM7vUNU@z>


On 10/23/19 2:27 PM, Thomas Gleixner wrote:
> Now that the trap handlers return with interrupts disabled, the
> unconditional disabling of interrupts in the low level entry code can be
> removed along with the trace calls and the misnomed preempt_stop macro.
> As a consequence ret_from_exception and ret_from_intr collapse.
> 
> Add a debug check to verify that interrupts are disabled depending on
> CONFIG_DEBUG_ENTRY.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/entry_32.S |   21 ++++++---------------
>   1 file changed, 6 insertions(+), 15 deletions(-)
> 

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.
