From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [RFC PATCH 3/6] mm, arm64: untag user addresses in memory syscalls
Date: Wed, 14 Mar 2018 16:45:20 +0100
Message-ID: <CAAeHK+y3hJ4jAByvfGDYyNb_RZ3_As4r-FCyZL9u69Vv_HS2AA@mail.gmail.com>
References: <cover.1520600533.git.andreyknvl@google.com> <beea8ac394bfae3c7c949645fb887ceacc3f3bb3.1520600533.git.andreyknvl@google.com>
 <20180309155315.4x44sbp3darractt@armageddon.cambridge.arm.com>
 <CAAeHK+xF0X-SQuPVmZF--VnmvYrbpDkznSwYTh_3LHq1H2V=9Q@mail.gmail.com> <CAFKCwrgPEhBEbXn95ugxVuxHw7UTiQWuo3+HJ_t7UBG69fbUcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFKCwrgPEhBEbXn95ugxVuxHw7UTiQWuo3+HJ_t7UBG69fbUcw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Evgenii Stepanov <eugenis@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 9, 2018 at 6:42 PM, Evgenii Stepanov <eugenis@google.com> wrote:
> On Fri, Mar 9, 2018 at 9:31 AM, Andrey Konovalov <andreyknvl@google.com> wrote:
>> On Fri, Mar 9, 2018 at 4:53 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>>> I'm not yet convinced these functions need to allow tagged pointers.
>>> They are not doing memory accesses but rather dealing with the memory
>>> range, hence an untagged pointer is better suited. There is probably a
>>> reason why the "start" argument is "unsigned long" vs "void __user *"
>>> (in the kernel, not the man page).
>>
>> So that would make the user to untag pointers before passing to these syscalls.
>>
>> Evgeniy, would that be possible to untag pointers in HWASan before
>> using memory subsystem syscalls? Is there a reason for untagging them
>> in the kernel?
>
> Generally, no. It's possible to intercept a libc call using symbol
> interposition, but I don't know how to rewrite arguments of a raw
> system call other than through ptrace, and that creates more problems
> than it solves.
>
> AFAIU, it's valid for a program to pass an address obtained from
> malloc or, better, posix_memalign to an mm syscall like mprotect().
> These arguments are pointers from the userspace point of view.

Catalin, do you think this is a good reason to have the untagging done
in the kernel?
