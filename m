From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v8 0/8] arm64: untag user pointers passed to the kernel
Date: Thu, 8 Nov 2018 15:48:10 +0100
Message-ID: <CAAeHK+w1Qv6owkdWfjbXMFqOA8BURDN5gviw8vpgi3eon1dWmA@mail.gmail.com>
References: <cover.1541687720.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1541687720.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 8, 2018 at 3:36 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

[...]

> Changes in v8:
> - Rebased onto 65102238 (4.20-rc1).
> - Added a note to the cover letter on why syscall wrappers/shims that untag
>   user pointers won't work.
> - Added a note to the cover letter that this patchset has been merged into
>   the Pixel 2 kernel tree.
> - Documentation fixes, in particular added a list of syscalls that don't
>   support tagged user pointers.

Hi Catalin,

I've changed the documentation to be more specific, please take a look.

I haven't done anything about adding a way for the user to find out
that the kernel supports this ABI extension. I don't know what would
the the preferred way to do this, and we haven't received any comments
on that from anybody else. Probing "on some innocuous syscall
currently returning -EFAULT on tagged pointer arguments" works though,
as you mentioned.

As mentioned in the cover letter, this patchset has been merged into
the Pixel 2 kernel tree.

Thanks!
