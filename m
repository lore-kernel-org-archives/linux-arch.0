From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [RFC PATCH 0/3] Documentation/features: Provide and apply
 "features-refresh.sh"
Date: Wed, 4 Apr 2018 15:03:57 +0200
Message-ID: <20180404130357.GA9125@andrea>
References: <1522774551-9503-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20180404045632.uniwfrl32bjmsn5g@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180404045632.uniwfrl32bjmsn5g@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Apr 04, 2018 at 06:56:32AM +0200, Ingo Molnar wrote:
> 
> * Andrea Parri <andrea.parri@amarulasolutions.com> wrote:
> 
> > In Ingo's words [1]:
> > 
> >   "[...]  what should be done instead is to write a script that refreshes
> >    all the arch-support.txt files in-place. [...]
> > 
> >    It's OK for the script to have various quirks for weirdly implemented
> >    features and exceptions: i.e. basically whenever it gets a feature wrong,
> >    we can just tweak the script with quirks to make it all work out of box.
> > 
> >    [...]  But in the end there should only be a single new script:
> > 
> >      Documentation/features/scripts/features-refresh.sh
> > 
> >    ... which operates on the arch-support.txt files and refreshes them in
> >    place, and which, after all the refreshes have been committed, should
> >    produce an empty 'git diff' result."
> > 
> >   "[...]  New features can then be added by basically just creating a
> >    header-only arch-support.txt file, such as:
> > 
> >      triton:~/tip/Documentation/features> cat foo/bar/arch-support.txt
> >      #
> >      # Feature name:          shiny new fubar kernel feature
> >      #         Kconfig:       ARCH_USE_FUBAR
> >      #         description:   arch supports the fubar feature
> >      #
> > 
> >    And running Documentation/features/scripts/features-refresh.sh would
> >    auto-generate the arch support matrix. [...]
> >  
> >    This way we soft- decouple the refreshing of the entries from the
> >    introduction of the features, while still making it all easy to keep
> >    sync and to extend."
> > 
> > This RFC presents a first attempt to implement such a feature/script, and
> > applies it script on top of Arnd's:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git arch-removal
> > 
> > Patch 1/3 provides the "features-refresh.sh" script.  Patch 2/3 removes the
> > "BPF-JIT" feature file and it creates header-only files for "cBPF-JIT" and
> > "eBPF-JIT".  Patch 3/3 presents the results of running the script; this run
> > also printed to standard output the following warnings:
> > 
> >   WARNING: '__HAVE_ARCH_STRNCASECMP' is not a valid Kconfig
> >   WARNING: 'Optimized asm/rwsem.h' is not a valid Kconfig
> >   WARNING: '!ARCH_USES_GETTIMEOFFSET' is not a valid Kconfig
> >   WARNING: '__HAVE_ARCH_PTE_SPECIAL' is not a valid Kconfig
> > 
> > (I'm sending these patches with empty commit messagges, for early feedback:
> >  I'll fill in these messages in subsequent versions if this makes sense...)
> > 
> > Cheers,
> >   Andrea
> > 
> > Andrea Parri (3):
> >   Documentation/features: Add script that refreshes the arch support status files in place
> >   Documentation/features/core: Add arch support status files for 'cBPF-JIT' and 'eBPF-JIT'
> >   Documentation/features: Refresh and auto-generate the arch support status files in place
> 
> Ok, this series is really impressive at its RFC stage already!
> 
> Beyond fixing those warnings, I'd also suggest another change: please make the 
> new BPF features patch the last one, so that the 'refresh' patch shows how much 
> original bit-rot we gathered recently.
> 
> The 'new features' patch should then also include the result of also running the 
> script, i.e. a single patch adding the base fields and the generated parts as 
> well. That will be the usual development flow anyway - people won't do two-part 
> patches just to show which bits are by hand and which are auto-generated.

Yes, I'll do.

Let me ask some hints about the warnings, as I'm not sure how to 'fix' them;
we have:

  a) __HAVE_ARCH_STRNCASECMP
     __HAVE_ARCH_PTE_SPECIAL

  b) Optimized asm/rwsem.h

  c) !ARCH_USES_GETTIMEOFFSET  

For (c), I see two options:

  1. replace that with 'ARCH_USES_GETTIMEOFFSET' (and update the status
     matrix accordingly)

  2. add logics/code to the script to handle simple boolean expressions
     (mmh, this could get nasty really soon... let's say: limiting to a
     leading '!', to start with ;)

For (a), I realize that 'grep-ing' the macros in arch-specific _sources_
does serve the purpose of producing the hard-coded status matrices; but
is this a reasonable approach? (e.g., can produce 'false-positives'?)

What could it be a suitable solution for (b)? are there Kconfig options
which I could in place of that expression? some other suggestion?

Thanks,
  Andrea


> 
> Thanks,
> 
> 	Ingo
