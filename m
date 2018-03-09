From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH 3/6] mm, arm64: untag user addresses in memory
 syscalls
Date: Fri, 9 Mar 2018 15:53:16 +0000
Message-ID: <20180309155315.4x44sbp3darractt@armageddon.cambridge.arm.com>
References: <cover.1520600533.git.andreyknvl@google.com>
 <beea8ac394bfae3c7c949645fb887ceacc3f3bb3.1520600533.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <beea8ac394bfae3c7c949645fb887ceacc3f3bb3.1520600533.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 09, 2018 at 03:02:01PM +0100, Andrey Konovalov wrote:
> Memory subsystem syscalls accept user addresses as arguments, but don't use
> copy_from_user and other similar functions, so we need to handle this case
> separately.
> 
> Untag user pointers passed to madvise, mbind, get_mempolicy, mincore,
> mlock, mlock2, brk, mmap_pgoff, old_mmap, munmap, remap_file_pages,
> mprotect, pkey_mprotect, mremap and msync.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Please keep the cc list small (maybe linux-arch, linux-arm-kernel) as
I'm sure some lists would consider this spam.

>  mm/madvise.c   | 2 ++
>  mm/mempolicy.c | 6 ++++++
>  mm/mincore.c   | 2 ++
>  mm/mlock.c     | 5 +++++
>  mm/mmap.c      | 9 +++++++++
>  mm/mprotect.c  | 2 ++
>  mm/mremap.c    | 2 ++
>  mm/msync.c     | 3 +++

I'm not yet convinced these functions need to allow tagged pointers.
They are not doing memory accesses but rather dealing with the memory
range, hence an untagged pointer is better suited. There is probably a
reason why the "start" argument is "unsigned long" vs "void __user *"
(in the kernel, not the man page).

-- 
Catalin
