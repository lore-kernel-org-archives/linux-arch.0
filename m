From: Kevin Easton <kevin@guarana.org>
Subject: Re: [PATCHv1, RFC 0/8] Boot-time switching between 4- and 5-level
 paging
Date: Fri, 26 May 2017 00:18:53 -0400
Message-ID: <20170526041853.GA27213@la.guarana.org>
References: <20170525203334.867-1-kirill.shutemov@linux.intel.com>
 <CA+55aFznnXPDxYy5CN6qVU7QJ3Y9hbSf-s2-w0QkaNJuTspGcQ@mail.gmail.com>
 <CALCETrWACTFPDrpuZgoPqeRLU4ZooDjHOpQaNCFmCfVCHM-sHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <CALCETrWACTFPDrpuZgoPqeRLU4ZooDjHOpQaNCFmCfVCHM-sHQ@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, May 25, 2017 at 05:40:16PM -0700, Andy Lutomirski wrote:
> On Thu, May 25, 2017 at 4:24 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Thu, May 25, 2017 at 1:33 PM, Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> >> Here' my first attempt to bring boot-time between 4- and 5-level paging.
> >> It looks not too terrible to me. I've expected it to be worse.
> >
> > If I read this right, you just made it a global on/off thing.
> >
> > May I suggest possibly a different model entirely? Can you make it a
> > per-mm flag instead?
> >
> > And then we
> >
> >  (a) make all kthreads use the 4-level page tables
> >
> >  (b) which means that all the init code uses the 4-level page tables
> >
> >  (c) which means that all those checks for "start_secondary" etc can
> > just go away, because those all run with 4-level page tables.
> >
> > Or is it just much too expensive to switch between 4-level and 5-level
> > paging at run-time?
> >
> 
> Even ignoring expensiveness, I'm not convinced it's practical.  AFAICT
> you can't atomically switch the paging mode and CR3, so either you
> need some magic page table with trampoline that works in both modes
> (which is presumably doable with some trickery) or you need to flip
> paging off.  Good luck if an NMI hits in the mean time.  There was
> code like that once upon a time for EFI mixed mode, but it got deleted
> due to triple-faults.

According to Intel's documentation you pretty much have to disable
paging anyway:

"The processor allows software to modify CR4.LA57 only outside of IA-32e
mode. In IA-32e mode, an attempt to modify CR4.LA57 using the MOV CR
instruction causes a general-protection exception (#GP)."

(If it weren't for that, maybe you could point the last entry in the PML4
at the PML4 itself, so it also works as a PML5 for accessing kernel
addresses? And of course make sure nothing gets loaded above 
0xffffff8000000000).

    - Kevin

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
