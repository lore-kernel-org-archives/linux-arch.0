From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
Date: Mon, 16 Jul 2018 13:25:59 +0200
Message-ID: <CAAeHK+yWF05XoU+0iuJoXAL3cWgdtxbeLoBz169yP12W4LkcQw@mail.gmail.com>
References: <cover.1529507994.git.andreyknvl@google.com> <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com> <CAAeHK+wJbbCZd+-X=9oeJgsqQJiq8h+Aagz3SQMPaAzCD+pvFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAeHK+wJbbCZd+-X=9oeJgsqQJiq8h+Aagz3SQMPaAzCD+pvFw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-doc@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Chintan Pandya <cpandya@codeaurora.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 28, 2018 at 9:30 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> On Wed, Jun 27, 2018 at 5:05 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
>> On Tue, Jun 26, 2018 at 7:29 PM, Catalin Marinas
>> <catalin.marinas@arm.com> wrote:
>>> While I support this work, as a maintainer I'd like to understand
>>> whether we'd be in a continuous chase of ABI breaks with every kernel
>>> release or we have a better way to identify potential issues. Is there
>>> any way to statically analyse conversions from __user ptr to long for
>>> example? Or, could we get the compiler to do this for us?
>>
>>
>> OK, got it, I'll try to figure out a way to find these conversions.
>
> I've prototyped a checker on top of clang static analyzer (initially
> looked at sparse, but couldn't find any documentation or examples).
> The results are here [1], search for "warning: user pointer cast".
> Sharing in case anybody wants to take a look, will look at them myself
> tomorrow.
>
> [1] https://gist.github.com/xairy/433edd5c86456a64026247cb2fef2115

So the checker reports ~100 different places where a __user pointer
being casted. I've looked through them and found 3 places where we
need to add untagging. Source code lines below come from 4.18-rc2+
(6f0d349d).

Place 1:

arch/arm64/mm/fault.c:302:34: warning: user pointer cast
current->thread.fault_address = (unsigned long)info->si_addr;

Compare a pointer with TASK_SIZE (1 << 48) to check whether it lies in
the kernel or in user space. Need to untag the address before
performing a comparison.

Place 2:

fs/namespace.c:2736:21: warning: user pointer cast
size = TASK_SIZE - (unsigned long)data;

A similar check performed by subtracting a pointer from TASK_SIZE.
Need to untag before subtracting.

Place 3:

drivers/usb/core/devio.c:1407:29: warning: user pointer cast
unsigned long uurb_start = (unsigned long)uurb->buffer;
drivers/usb/core/devio.c:1636:31: warning: user pointer cast
unsigned long uurb_start = (unsigned long)uurb->buffer;
drivers/usb/core/devio.c:1715:30: warning: user pointer cast
unsigned long uurb_start = (unsigned long)uurb->buffer;

The device keeps list of mmapped areas and searches them for provided
__user pointer. Need to untag before searching.

There are also a few cases of memory syscalls operating on __user
pointers instead of unsigned longs like mmap:

ipc/shm.c:1355:23: warning: user pointer cast
unsigned long addr = (unsigned long)shmaddr;
ipc/shm.c:1566:23: warning: user pointer cast
unsigned long addr = (unsigned long)shmaddr;
mm/migrate.c:1586:10: warning: user pointer cast
addr = (unsigned long)p;
mm/migrate.c:1660:24: warning: user pointer cast
unsigned long addr = (unsigned long)(*pages);

If we don't add untagging to mmap, we probably don't need it here.

The rest of reported places look fine as is. Full annotated results of
running the checker are here [2].

I'll add the 3 patches with fixes to v5 of this patchset.

Catalin, WDYT?

[2] https://gist.github.com/xairy/aabda57741919df67d79895356ba9b58
