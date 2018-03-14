From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH 3/6] mm, arm64: untag user addresses in memory
 syscalls
Date: Wed, 14 Mar 2018 17:44:43 +0000
Message-ID: <20180314174442.lclslnqc3egfjg4c@armageddon.cambridge.arm.com>
References: <cover.1520600533.git.andreyknvl@google.com>
 <beea8ac394bfae3c7c949645fb887ceacc3f3bb3.1520600533.git.andreyknvl@google.com>
 <20180309155315.4x44sbp3darractt@armageddon.cambridge.arm.com>
 <CAAeHK+xF0X-SQuPVmZF--VnmvYrbpDkznSwYTh_3LHq1H2V=9Q@mail.gmail.com>
 <CAFKCwrgPEhBEbXn95ugxVuxHw7UTiQWuo3+HJ_t7UBG69fbUcw@mail.gmail.com>
 <CAAeHK+y3hJ4jAByvfGDYyNb_RZ3_As4r-FCyZL9u69Vv_HS2AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAeHK+y3hJ4jAByvfGDYyNb_RZ3_As4r-FCyZL9u69Vv_HS2AA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Evgenii Stepanov <eugenis@google.com>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Jacob Bramley <Jacob.Bramley@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>, Lee Smith <Lee.Smith@arm.com>, Robin Murphy <robin.murphy@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 14, 2018 at 04:45:20PM +0100, Andrey Konovalov wrote:
> On Fri, Mar 9, 2018 at 6:42 PM, Evgenii Stepanov <eugenis@google.com> wrote:
> > On Fri, Mar 9, 2018 at 9:31 AM, Andrey Konovalov <andreyknvl@google.com> wrote:
> >> On Fri, Mar 9, 2018 at 4:53 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >>> I'm not yet convinced these functions need to allow tagged pointers.
> >>> They are not doing memory accesses but rather dealing with the memory
> >>> range, hence an untagged pointer is better suited. There is probably a
> >>> reason why the "start" argument is "unsigned long" vs "void __user *"
> >>> (in the kernel, not the man page).
> >>
> >> So that would make the user to untag pointers before passing to these syscalls.
> >>
> >> Evgeniy, would that be possible to untag pointers in HWASan before
> >> using memory subsystem syscalls? Is there a reason for untagging them
> >> in the kernel?
> >
> > Generally, no. It's possible to intercept a libc call using symbol
> > interposition, but I don't know how to rewrite arguments of a raw
> > system call other than through ptrace, and that creates more problems
> > than it solves.

With these patches, we are trying to relax the user/kernel ABI so that
tagged pointers can be passed into the kernel. Since this is a new ABI
(or an extension to the existing one), it might be ok to change the libc
so that the top byte is zeroed on specific syscalls before issuing the
SVC.

I agree that it is problematic for HWASan if it only relies on
overriding malloc/free.

> > AFAIU, it's valid for a program to pass an address obtained from
> > malloc or, better, posix_memalign to an mm syscall like mprotect().
> > These arguments are pointers from the userspace point of view.
> 
> Catalin, do you think this is a good reason to have the untagging done
> in the kernel?

malloc() or posix_memalign() are C library implementations and it's the
C library (or overridden functions) setting a tag on the returned
pointers. Since the TBI hardware feature allows memory accesses with a
non-zero tag, we could allow them in the kernel for syscalls performing
such accesses on behalf of the user (e.g. get_user/put_user would not
need to clear the tag).

madvise(), OTOH, does not perform a memory access on behalf of the user,
it's just advising the kernel about a range of virtual addresses. That's
where I think, from an ABI perspective, it doesn't make much sense to
allow tags into the kernel for these syscalls (even if it's simpler from
a user space perspective).

(but I don't have a very strong opinion on this ;))

-- 
Catalin
