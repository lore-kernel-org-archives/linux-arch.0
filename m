From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 11/11] arm64: annotate user pointers casts detected by sparse
Date: Thu, 6 Sep 2018 14:16:19 -0700
Message-ID: <CA+55aFy2t_MHgr_CgwbhtFkL+djaCq2qMM1G+f2DwJ0qEr1URQ@mail.gmail.com>
References: <cover.1535629099.git.andreyknvl@google.com> <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
 <CA+55aFyW9N2tSb2bQvkthbVVyY6nt5yFeWQRLHp1zruBmb5ocw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFyW9N2tSb2bQvkthbVVyY6nt5yFeWQRLHp1zruBmb5ocw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Linux
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 6, 2018 at 2:13 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So for example:
>
> >  static inline compat_uptr_t ptr_to_compat(void __user *uptr)
> >  {
> > -       return (u32)(unsigned long)uptr;
> > +       return (u32)(__force unsigned long)uptr;
> >  }
>
> this actually looks correct.

Side note: I do think that while the above is correct, the rest of the
patch shows that we might be better off simply not havign the warning
for address space changes at all for the "cast a pointer to an integer
type" case.

When you cast to a non-pointer type, the address space issue simply
doesn't exist at all, so the warning makes less sense.

It's really just he "pointer to one address space" being cast to
"pointer to another address space" that should really warn, and that
might need that "__force" thing.

Hmm? So maybe a sparse change is better for most of that patch.

             Linus
