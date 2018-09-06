Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44122 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeIGDqv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Sep 2018 23:46:51 -0400
Date: Fri, 7 Sep 2018 01:08:59 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v6 11/11] arm64: annotate user pointers casts detected by
 sparse
Message-ID: <20180906230858.psedqdai3dw2cvvl@ltop.local>
References: <cover.1535629099.git.andreyknvl@google.com>
 <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
 <CA+55aFyW9N2tSb2bQvkthbVVyY6nt5yFeWQRLHp1zruBmb5ocw@mail.gmail.com>
 <CA+55aFy2t_MHgr_CgwbhtFkL+djaCq2qMM1G+f2DwJ0qEr1URQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFy2t_MHgr_CgwbhtFkL+djaCq2qMM1G+f2DwJ0qEr1URQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, eugenis@google.com, Lee.Smith@arm.com, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob.Bramley@arm.com, Ruben.Ayrapetyan@arm.com, cpandya@codeaurora.org
Message-ID: <20180906230859.rNr0TeEJCZ5gnY5CM695jeSskb1jpYJtvQrIpHm2Gn4@z>

On Thu, Sep 06, 2018 at 02:16:19PM -0700, Linus Torvalds wrote:
> On Thu, Sep 6, 2018 at 2:13 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So for example:
> >
> > >  static inline compat_uptr_t ptr_to_compat(void __user *uptr)
> > >  {
> > > -       return (u32)(unsigned long)uptr;
> > > +       return (u32)(__force unsigned long)uptr;
> > >  }
> >
> > this actually looks correct.
> 
> Side note: I do think that while the above is correct, the rest of the
> patch shows that we might be better off simply not havign the warning
> for address space changes at all for the "cast a pointer to an integer
> type" case.
> 
> When you cast to a non-pointer type, the address space issue simply
> doesn't exist at all, so the warning makes less sense.
> 
> It's really just he "pointer to one address space" being cast to
> "pointer to another address space" that should really warn, and that
> might need that "__force" thing.
> 
> Hmm? So maybe a sparse change is better for most of that patch.

Unless I'm misunderstanding something, I don't think there is
anything to change for this specific point. Sparse don't warn
(by default) on "cast from pointer with address space to integer",
as it always been the case, I think. I think it's the good choice.

It's just that recently, I've added a new flag -Wcast-from-as [1],
defaulting to 'no', specifically to *detect* these cast because of
these tagged pointers.

Note: I tend to think more and more that __force is simply too
      strong and weaker form, like __force_as and __force_bitwise
      would be more appropriate.


-- Luc Van Oostenryck

[1] d96da358c ("stricter warning for explicit cast to ulong")
