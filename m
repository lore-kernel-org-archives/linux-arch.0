Return-Path: <luto@kernel.org>
MIME-Version: 1.0
References: <20191023122705.198339581@linutronix.de> <20191023123118.978254388@linutronix.de>
In-Reply-To: <20191023123118.978254388@linutronix.de>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 23 Oct 2019 14:34:12 -0700
Message-ID: <CALCETrVArVWH2-ew4+WVxhX-3kzrspv2x8yw3RH3PyVGeAMudA@mail.gmail.com>
Subject: Re: [patch V2 14/17] entry: Provide generic exit to usermode functionality
Content-Type: text/plain; charset="UTF-8"
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191023213412.s5tDkuguzxnZEXiCmairhJzzprqOfNFY7QSruVMz9Pg@z>

On Wed, Oct 23, 2019 at 5:31 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Provide a generic facility to handle the exit to usermode work. That's
> aimed to replace the pointlessly different copies in each architecture.


>  /**
> + * local_irq_enable_exit_to_user - Exit to user variant of local_irq_enable()
> + * @ti_work:   Cached TIF flags gathered with interrupts disabled
> + *
> + * Defaults to local_irq_enable(). Can be supplied by architecture specific
> + * code.

What did you have in mind here?
