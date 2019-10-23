Return-Path: <tglx@linutronix.de>
Date: Thu, 24 Oct 2019 01:20:50 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 14/17] entry: Provide generic exit to usermode
 functionality
In-Reply-To: <CALCETrVArVWH2-ew4+WVxhX-3kzrspv2x8yw3RH3PyVGeAMudA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1910240119090.1852@nanos.tec.linutronix.de>
References: <20191023122705.198339581@linutronix.de> <20191023123118.978254388@linutronix.de> <CALCETrVArVWH2-ew4+WVxhX-3kzrspv2x8yw3RH3PyVGeAMudA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andy Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191023232050.SVEsNEc8bDYynVfWQog5r75dBjBdVrqqmT_ABxl2Ai4@z>

On Wed, 23 Oct 2019, Andy Lutomirski wrote:

> On Wed, Oct 23, 2019 at 5:31 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > From: Thomas Gleixner <tglx@linutronix.de>
> >
> > Provide a generic facility to handle the exit to usermode work. That's
> > aimed to replace the pointlessly different copies in each architecture.
> 
> 
> >  /**
> > + * local_irq_enable_exit_to_user - Exit to user variant of local_irq_enable()
> > + * @ti_work:   Cached TIF flags gathered with interrupts disabled
> > + *
> > + * Defaults to local_irq_enable(). Can be supplied by architecture specific
> > + * code.
> 
> What did you have in mind here?

Look at the previous version which had the ARM64 conversion. ARM64 does
magic different stuff vs. local_irq_enable() in the exit path. It's not
using the regular one. I'm happy to ditch that :)

Thanks,

	tglx
