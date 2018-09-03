From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v6 11/11] arm64: annotate user pointers casts detected by
 sparse
Date: Mon, 3 Sep 2018 17:10:27 +0200
Message-ID: <20180903151026.n2jak3e4yqusnogt@ltop.local>
References: <cover.1535629099.git.andreyknvl@google.com>
 <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
 <20180831081123.6mo62xnk54pvlxmc@ltop.local>
 <20180831134244.GB19965@ZenIV.linux.org.uk>
 <CAAeHK+w86m6YztnTGhuZPKRczb-+znZ1hiJskPXeQok4SgcaOw@mail.gmail.com>
 <01cadefd-c929-cb45-500d-7043cf3943f6@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <01cadefd-c929-cb45-500d-7043cf3943f6@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Andrey Konovalov <andreyknvl@google.com>, Al Viro <viro@zeniv.linux.org.uk>, Mark Rutland <mark.rutland@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kostya Serebryany <kcc@google.com>, linux-kselftest@vger.kernel.org, Chintan Pandya <cpandya@codeaurora.org>, Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, Jacob Bramley <Jacob.Bramley@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Evgeniy Stepanov <eugenis@google.com>, Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Dmitry Vyukov <dvyukov@google.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Sep 03, 2018 at 02:49:38PM +0100, Vincenzo Frascino wrote:
> On 03/09/18 13:34, Andrey Konovalov wrote:
> > On Fri, Aug 31, 2018 at 3:42 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >> On Fri, Aug 31, 2018 at 10:11:24AM +0200, Luc Van Oostenryck wrote:
> >>> On Thu, Aug 30, 2018 at 01:41:16PM +0200, Andrey Konovalov wrote:
> >>>> This patch adds __force annotations for __user pointers casts detected by
> >>>> sparse with the -Wcast-from-as flag enabled (added in [1]).
> >>>>
> >>>> [1] https://github.com/lucvoo/sparse-dev/commit/5f960cb10f56ec2017c128ef9d16060e0145f292
> >>>
> >>> Hi,
> >>>
> >>> It would be nice to have some explanation for why these added __force
> >>> are useful.
> > 
> > I'll add this in the next version, thanks!
> > 
> >>         It would be even more useful if that series would either deal with
> >> the noise for real ("that's what we intend here, that's what we intend there,
> >> here's a primitive for such-and-such kind of cases, here we actually
> >> ought to pass __user pointer instead of unsigned long", etc.) or left it
> >> unmasked.
> >>
> >>         As it is, __force says only one thing: "I know the code is doing
> >> the right thing here".  That belongs in primitives, and I do *not* mean the
> >> #define cast_to_ulong(x) ((__force unsigned long)(x))
> >> kind.
> >>
> >>         Folks, if you don't want to deal with that - leave the warnings be.
> >> They do carry more information than "someone has slapped __force in that place".
> >>
> >> Al, very annoyed by that kind of information-hiding crap...
> > 
> > This patch only adds __force to hide the reports I've looked at and
> > decided that the code does the right thing. The cases where this is
> > not the case are handled by the previous patches in the patchset. I'll
> > this to the patch description as well. Is that OK?
> > 
> I think as well that we should make explicit the information that
> __force is hiding.
> A possible solution could be defining some new address spaces and use
> them where it is relevant in the kernel. Something like:
> 
> # define __compat_ptr __attribute__((noderef, address_space(5)))
> # define __tagged_ptr __attribute__((noderef, address_space(6)))
> 
> In this way sparse can still identify the casting and trigger a warning.
> 
> We could at that point modify sparse to ignore these conversions when a
> specific flag is passed (i.e. -Wignore-compat-ptr, -Wignore-tagged-ptr)
> to exclude from the generated warnings the ones we have already dealt
> with.
> 
> What do you think about this approach?

I'll be happy to add such warnings to sparse if it is useful to detect
(and correct!) problems. I'm also thinking to other possiblities, like
having some weaker form of __force (maybe simply __force_as (which will
'only' force the address space) or even __force_as(TO, FROM) (with TO
and FROM being a mask of the address space allowed).

However, for the specific situation here, I'm not sure that using
address spaces is the right choice because I suspect that the concept
of tagged pointer is orthogonal to the one of (the usual) address space
(it won't be possible for a pointer to be __tagged_ptr *and* __user).

OTOH, when I see already the tons of warnings for concepts established
since many years (I'm thinking especially at __bitwise, see [1]) I'm a
bit affraid of adding new, more specialized ones that people will
understand even less how/when they need to use them.


-- Luc

[1] Here are the warnings reported on v18-rc1 x86-64 with defconfig:
    469 symbol was not declared. Should it be static?
    241 incorrect type in argument (different address spaces)
    186 context imbalance - unexpected unlock
    147 restricted type degrades to integer
    122 incompatible types in comparison expression (different address spaces)
    117 context imbalance - different lock contexts for basic block
    102 incorrect type in assignment (different address spaces)
    101 incorrect type in initializer (different address spaces)
     82 dereference of noderef expression
     79 cast to restricted type
     74 incorrect type in argument (different base types)
     72 bad integer constant expression
     68 context imbalance - wrong count at exit
     65 incorrect type in assignment (different base types)
     44 cast removes address space of expression
     38 Using plain integer as NULL pointer
     20 Variable length array is used.
     14 symbol redeclared with different type - different modifiers
     14 cast from restricted type
     13 function with external linkage has definition
     12 subtraction of functions? Share your drugs
     11 directive in argument list
      8 incorrect type in return expression (different address spaces)
      6 cast truncates bits from constant value
      5 invalid assignement
      5 incorrect type in return expression (different base types)
      5 incorrect type in initializer (different base types)
      4 "Sparse checking disabled for this file"
      3 memset with byte count of ...
      3 incorrect type in initializer (different modifiers)
      2 Initializer entry defined twice
      2 incorrect type in assignment (different modifiers)
      2 incorrect type in argument (different modifiers)
      2 arithmetics on pointers to functions
      1 trying to concatenate long character string (8191 bytes max)
      1 too long token expansion
      1 symbol redeclared with different type - incompatible argument (different address spaces)
      1 memcpy with byte count of ...
      1 marked inline, but without a definition
      1 invalid initializer
      1 incorrect type in argument (incompatible argument (different signedness))
      1 incompatible types in comparison expression (different base types)
      1 dubious: !x | y
      1 constant is so big it is ...
