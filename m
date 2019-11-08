Return-Path: <alexandre.chartre@oracle.com>
Subject: Re: [patch V2 07/17] x86/entry/64: Remove redundant interrupt disable
References: <20191023122705.198339581@linutronix.de>
 <20191023123118.296135499@linutronix.de>
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <86bf1670-dd35-f310-dab9-106897cc3921@oracle.com>
Date: Fri, 8 Nov 2019 12:07:27 +0100
MIME-Version: 1.0
In-Reply-To: <20191023123118.296135499@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191108110727.Uf2gvHbLa8gkQSP_LflX3V7ZZE77SxdHEafrkFxw2VU@z>


On 10/23/19 2:27 PM, Thomas Gleixner wrote:
> Now that the trap handlers return with interrupts disabled, the
> unconditional disabling of interrupts in the low level entry code can be
> removed along with the trace calls.
> 
> Add debug checks where appropriate.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/entry_64.S |    9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.
