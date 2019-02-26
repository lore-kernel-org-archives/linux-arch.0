From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v10 07/12] fs, arm64: untag user pointers in fs/userfaultfd.c
Date: Tue, 26 Feb 2019 15:39:08 +0100
Message-ID: <CAAeHK+yQU8khtOoyDKqmHterCa16P7oWe9AMiPnrxE+Gyb_7aw@mail.gmail.com>
References: <cover.1550839937.git.andreyknvl@google.com> <8343cd77ca301df15839796f3b446b75ce5ffbbf.1550839937.git.andreyknvl@google.com>
 <73f2f3fe-9a66-22a1-5aae-c282779a75f5@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <73f2f3fe-9a66-22a1-5aae-c282779a75f5@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Sat, Feb 23, 2019 at 12:06 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/22/19 4:53 AM, Andrey Konovalov wrote:
> > userfaultfd_register() and userfaultfd_unregister() use provided user
> > pointers for vma lookups, which can only by done with untagged pointers.
>
> So, we have to patch all these sites before the tagged values get to the
> point of hitting the vma lookup functions.  Dumb question: Why don't we
> just patch the vma lookup functions themselves instead of all of these
> callers?

That might be a working approach as well. We'll still need to fix up
places where the vma fields are accessed directly. Catalin, what do
you think?
