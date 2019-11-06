Return-Path: <alexandre.chartre@oracle.com>
Subject: Re: [patch V2 04/17] x86/entry: Make DEBUG_ENTRY_ASSERT_IRQS_OFF
 available for 32bit
References: <20191023122705.198339581@linutronix.de>
 <20191023123117.976831752@linutronix.de>
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <9a1170f8-819b-9d30-9d77-66c60cd4cafb@oracle.com>
Date: Wed, 6 Nov 2019 16:50:41 +0100
MIME-Version: 1.0
In-Reply-To: <20191023123117.976831752@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191106155041.HmWd0vKceE5rIWpX5ZQmJWi3UEuMsoGraqjPZdHHOh0@z>


On 10/23/19 2:27 PM, Thomas Gleixner wrote:
> Move the interrupt state verification debug macro to common code and fixup
> the irqflags and paravirt components so it can be used in 32bit code later.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/calling.h        |   12 ++++++++++++
>   arch/x86/entry/entry_64.S       |   12 ------------
>   arch/x86/include/asm/irqflags.h |    8 ++++++--
>   arch/x86/include/asm/paravirt.h |    9 +++++----
>   4 files changed, 23 insertions(+), 18 deletions(-)
> 

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.
