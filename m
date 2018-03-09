From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [RFC PATCH 3/6] mm, arm64: untag user addresses in memory syscalls
Date: Fri, 9 Mar 2018 18:31:36 +0100
Message-ID: <CAAeHK+xF0X-SQuPVmZF--VnmvYrbpDkznSwYTh_3LHq1H2V=9Q@mail.gmail.com>
References: <cover.1520600533.git.andreyknvl@google.com> <beea8ac394bfae3c7c949645fb887ceacc3f3bb3.1520600533.git.andreyknvl@google.com>
 <20180309155315.4x44sbp3darractt@armageddon.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180309155315.4x44sbp3darractt@armageddon.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Evgeniy Stepanov <eugenis@google.com>
Cc: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 9, 2018 at 4:53 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Mar 09, 2018 at 03:02:01PM +0100, Andrey Konovalov wrote:
>> Memory subsystem syscalls accept user addresses as arguments, but don't use
>> copy_from_user and other similar functions, so we need to handle this case
>> separately.
>>
>> Untag user pointers passed to madvise, mbind, get_mempolicy, mincore,
>> mlock, mlock2, brk, mmap_pgoff, old_mmap, munmap, remap_file_pages,
>> mprotect, pkey_mprotect, mremap and msync.
>>
>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Please keep the cc list small (maybe linux-arch, linux-arm-kernel) as
> I'm sure some lists would consider this spam.

OK.

>
>>  mm/madvise.c   | 2 ++
>>  mm/mempolicy.c | 6 ++++++
>>  mm/mincore.c   | 2 ++
>>  mm/mlock.c     | 5 +++++
>>  mm/mmap.c      | 9 +++++++++
>>  mm/mprotect.c  | 2 ++
>>  mm/mremap.c    | 2 ++
>>  mm/msync.c     | 3 +++
>
> I'm not yet convinced these functions need to allow tagged pointers.
> They are not doing memory accesses but rather dealing with the memory
> range, hence an untagged pointer is better suited. There is probably a
> reason why the "start" argument is "unsigned long" vs "void __user *"
> (in the kernel, not the man page).

So that would make the user to untag pointers before passing to these syscalls.

Evgeniy, would that be possible to untag pointers in HWASan before
using memory subsystem syscalls? Is there a reason for untagging them
in the kernel?

>
> --
> Catalin
