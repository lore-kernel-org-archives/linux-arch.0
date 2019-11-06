Return-Path: <alexandre.chartre@oracle.com>
Subject: Re: [patch V2 05/17] x86/traps: Make interrupt enable/disable
 symmetric in C code
References: <20191023122705.198339581@linutronix.de>
 <20191023123118.084086112@linutronix.de>
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <1c6ad81c-9518-909a-03d2-e2a2cf53240d@oracle.com>
Date: Wed, 6 Nov 2019 17:19:44 +0100
MIME-Version: 1.0
In-Reply-To: <20191023123118.084086112@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191106161944.HqrScEzS3Fg8J-WlFooXnJxq2p34m2Z6xXRn3OENbmY@z>


On 10/23/19 2:27 PM, Thomas Gleixner wrote:
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
>   arch/x86/kernel/traps.c |   32 +++++++++++++++++++++-----------
>   arch/x86/mm/fault.c     |    7 +++++--
>   2 files changed, 26 insertions(+), 13 deletions(-)
> 

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.
