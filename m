From: Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 00/11] prctl: Modernise wiring for optional prctl() calls
Date: Mon, 14 May 2018 11:28:11 -0700
Message-ID: <CAGXu5j+5n278z-+V3yOPyqyqqwRGGf4zkXzbGjhq9FQ6JgqZRQ@mail.gmail.com>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Fenghua Yu <fenghua.yu@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, James Hogan <jhogan@kernel.org>, Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Henderson <rth@twiddle.net>, Rich Felker <dalias@libc.org>, Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>, X86 ML <x86@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, May 14, 2018 at 10:14 AM, Dave Martin <Dave.Martin@arm.com> wrote:
> [Reviewer note: this is a cross-arch series.  To reduce spam, I have
> tried not to Cc people on patches they aren't likely to care about.
> The complete series can be found in the LKML or linux-arch archives.]
>
> The core framework for the prctl() syscall is unloved and looking
> rather crusty these days.  It also relies on defining ancillary
> boilerplate macros for each prctl() in order to control conditional
> compilation of the different prctl calls.  We have better ways to
> do this now.

This is a nice clean-up series, thanks! Some thoughts/comments below...

> This series attempts to modernise the code by defining a couple of new
> Kconfig variables HAVE_PRCTL_ARCH and HAVE_ARCH_PR_SET_GET_UNALIGN to
> allow architectures to provide hooks for arch-dependent prctls.
>
>
> For now this series has had minimal testing: some basic testing of
> arch-specific prctls using PR_SVE_SET_VL on arm64; build-tested on
> x86; otherwise untested.
>
> This is not polished yet... but I'm interested to know what people
> think about the approach.

I'm not entirely convinced the removal of the "task not current"
interface is very useful as I've found myself needing to adjust other
interfaces like this to _add_ the "task not current" logic, but ... I
can't really argue very hard for keeping the task args since nothing
is using them... meh.

I dislike this being named "prctl_arch" when everything else like this
is "arch_foo...", but I do see the collision with the x86-specific
"arch_prctl" syscall. Perhaps it might be better to wire things up
differently, since x86's arch_prctl is actually "sys_arch_prctl" so I
don't think there would be a symbol collision, and maybe the 9 options
could be added to the global prctl list, with the x86 syscall getting
called at the end of the new "arch_prctl"? Then the syscall could get
deprecated in favor of just using prctl directly?

Your new x86 arch_prctl (ne=C3=A9 prctl_arch) could be something like:

int arch_prctl(int option, unsigned long arg2, unsigned long arg3,
                     unsigned long arg4, unsigned long arg5)
{
... existing stuff in your series ...
    case ARCH_SET_GS:
    case ARCH_SET_FS:
    case ARCH_GET_GS:
    case ARCH_GET_FS:
    case ARCH_MAP_VDSO_X32:
    case ARCH_MAP_VDSO_32:
    case ARCH_MAP_VDSO_64:
        if (arg3 || arg4 || arg5)
            return -EINVAL;
        return do_arch_prctl_64(current, option, arg2);
    case ARCH_GET_CPUID:
    case ARCH_SET_CPUID:
        if (arg3 || arg4 || arg5)
            return -EINVAL;
        return do_arch_prctl_common(current, option, arg2);
    default:
        return -EINVAL;
    }
}

Or maybe all the logic could get ripped out of
arch/x86/kernel/process*.c and put in arch/x86/kernel/sys.c directly?

Perhaps this is all overkill, but I find it rather annoying that one
arch's weird syscall would block "expected" naming of a cross-arch
interface...

-Kees

--=20
Kees Cook
Pixel Security
