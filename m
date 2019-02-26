From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v10 04/12] mm, arm64: untag user pointers passed to memory syscalls
Date: Tue, 26 Feb 2019 15:41:26 +0100
Message-ID: <CAAeHK+z2qw__Kpeih2mEyhVJ-gbor1vYsOZddT5E71JDiSg7pg@mail.gmail.com>
References: <cover.1550839937.git.andreyknvl@google.com> <3875fa863b755d8cb43afa7bb0fe543e5fd05a5d.1550839937.git.andreyknvl@google.com>
 <81ea4e77-90a4-4fd9-2bc8-135e0da30044@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <81ea4e77-90a4-4fd9-2bc8-135e0da30044@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Sat, Feb 23, 2019 at 12:07 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/22/19 4:53 AM, Andrey Konovalov wrote:
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -578,6 +578,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
> >  SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
> >               unsigned long, prot)
> >  {
> > +     start = untagged_addr(start);
> >       return do_mprotect_pkey(start, len, prot, -1);
> >  }
> >
> > @@ -586,6 +587,7 @@ SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
> >  SYSCALL_DEFINE4(pkey_mprotect, unsigned long, start, size_t, len,
> >               unsigned long, prot, int, pkey)
> >  {
> > +     start = untagged_addr(start);
> >       return do_mprotect_pkey(start, len, prot, pkey);
> >  }
>
> This seems to have taken the approach of going as close as possible to
> the syscall boundary and untagging the pointer there.  I guess that's
> OK, but it does lead to more churn than necessary.  For instance, why
> not just do the untagging in do_mprotect_pkey()?

I think that makes more sense, will do in the next version, thanks!

>
> I think that's an overall design question.  I kinda asked the same thing
> about patching call sites vs. VMA lookup functions.

Replied in the other thread.
