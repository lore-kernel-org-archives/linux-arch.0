Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35955 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfBVPlC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Feb 2019 10:41:02 -0500
Received: by mail-pg1-f193.google.com with SMTP id r124so1302934pgr.3
        for <linux-arch@vger.kernel.org>; Fri, 22 Feb 2019 07:41:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550839937.git.andreyknvl@google.com> <464111f3-e255-ad45-8964-58462d889e6f@arm.com>
In-Reply-To: <464111f3-e255-ad45-8964-58462d889e6f@arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Fri, 22 Feb 2019 16:40:49 +0100
Message-ID: <CAAeHK+wCZK7F7T1k+Kg_HkK47J8R9ugtH1g1ciLYH_KJ22ZVjg@mail.gmail.com>
Subject: Re: [PATCH v10 00/12] arm64: untag user pointers passed to the kernel
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>nd <nd@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave P Martin <Dave.Martin@arm.com>, Kevin Brodsky <Kevin.Brodsky@arm.com>
Message-ID: <20190222154049.lb6Y2D3H8r9Sru7Kz3SRDGJHgdBxSnasibB0NNT6DWw@z>

On Fri, Feb 22, 2019 at 4:35 PM Szabolcs Nagy <Szabolcs.Nagy@arm.com> wrote:
>
> On 22/02/2019 12:53, Andrey Konovalov wrote:
> > This patchset is meant to be merged together with "arm64 relaxed ABI" [1].
> >
> > arm64 has a feature called Top Byte Ignore, which allows to embed pointer
> > tags into the top byte of each pointer. Userspace programs (such as
> > HWASan, a memory debugging tool [2]) might use this feature and pass
> > tagged user pointers to the kernel through syscalls or other interfaces.
> >
> > Right now the kernel is already able to handle user faults with tagged
> > pointers, due to these patches:
> >
> > 1. 81cddd65 ("arm64: traps: fix userspace cache maintenance emulation on a
> >              tagged pointer")
> > 2. 7dcd9dd8 ("arm64: hw_breakpoint: fix watchpoint matching for tagged
> >             pointers")
> > 3. 276e9327 ("arm64: entry: improve data abort handling of tagged
> >             pointers")
> >
> > This patchset extends tagged pointer support to syscall arguments.
> >
> > For non-memory syscalls this is done by untaging user pointers when the
> > kernel performs pointer checking to find out whether the pointer comes
> > from userspace (most notably in access_ok). The untagging is done only
> > when the pointer is being checked, the tag is preserved as the pointer
> > makes its way through the kernel.
> >
> > Since memory syscalls (mmap, mprotect, etc.) don't do memory accesses but
> > rather deal with memory ranges, untagged pointers are better suited to
> > describe memory ranges internally. Thus for memory syscalls we untag
> > pointers completely when they enter the kernel.
>
> i think the same is true when user pointers are compared.
>
> e.g. i suspect there may be issues with tagged robust mutex
> list pointers because the kernel does
>
> futex.c:3541:   while (entry != &head->list) {
>
> where entry is a user pointer that may be tagged, and
> &head->list is probably not tagged.

You're right. I'll expand the cover letter in the next version to
describe this more accurately. The patchset however contains "mm,
arm64: untag user pointers in mm/gup.c" that should take care of futex
pointers.

Thanks!

>
> > One of the alternative approaches to untagging that was considered is to
> > completely strip the pointer tag as the pointer enters the kernel with
> > some kind of a syscall wrapper, but that won't work with the countless
> > number of different ioctl calls. With this approach we would need a custom
> > wrapper for each ioctl variation, which doesn't seem practical.
> >
> > The following testing approaches has been taken to find potential issues
> > with user pointer untagging:
> >
> > 1. Static testing (with sparse [3] and separately with a custom static
> >    analyzer based on Clang) to track casts of __user pointers to integer
> >    types to find places where untagging needs to be done.
> >
> > 2. Static testing with grep to find parts of the kernel that call
> >    find_vma() (and other similar functions) or directly compare against
> >    vm_start/vm_end fields of vma.
> >
> > 3. Static testing with grep to find parts of the kernel that compare
> >    user pointers with TASK_SIZE or other similar consts and macros.
> >
> > 4. Dynamic testing: adding BUG_ON(has_tag(addr)) to find_vma() and running
> >    a modified syzkaller version that passes tagged pointers to the kernel.
> >
> > Based on the results of the testing the requried patches have been added
> > to the patchset.
> >
> > This patchset has been merged into the Pixel 2 kernel tree and is now
> > being used to enable testing of Pixel 2 phones with HWASan.
> >
> > This patchset is a prerequisite for ARM's memory tagging hardware feature
> > support [4].
> >
> > Thanks!
> >
> > [1] https://lkml.org/lkml/2018/12/10/402
> >
> > [2] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html
> >
> > [3] https://github.com/lucvoo/sparse-dev/commit/5f960cb10f56ec2017c128ef9d16060e0145f292
> >
> > [4] https://community.arm.com/processors/b/blog/posts/arm-a-profile-architecture-2018-developments-armv85a
> >
> > Changes in v10:
> > - Added "mm, arm64: untag user pointers passed to memory syscalls" back.
> > - New patch "fs, arm64: untag user pointers in fs/userfaultfd.c".
> > - New patch "net, arm64: untag user pointers in tcp_zerocopy_receive".
> > - New patch "kernel, arm64: untag user pointers in prctl_set_mm*".
> > - New patch "tracing, arm64: untag user pointers in seq_print_user_ip".
> >
> > Changes in v9:
> > - Rebased onto 4.20-rc6.
> > - Used u64 instead of __u64 in type casts in the untagged_addr macro for
> >   arm64.
> > - Added braces around (addr) in the untagged_addr macro for other arches.
> >
> > Changes in v8:
> > - Rebased onto 65102238 (4.20-rc1).
> > - Added a note to the cover letter on why syscall wrappers/shims that untag
> >   user pointers won't work.
> > - Added a note to the cover letter that this patchset has been merged into
> >   the Pixel 2 kernel tree.
> > - Documentation fixes, in particular added a list of syscalls that don't
> >   support tagged user pointers.
> >
> > Changes in v7:
> > - Rebased onto 17b57b18 (4.19-rc6).
> > - Dropped the "arm64: untag user address in __do_user_fault" patch, since
> >   the existing patches already handle user faults properly.
> > - Dropped the "usb, arm64: untag user addresses in devio" patch, since the
> >   passed pointer must come from a vma and therefore be untagged.
> > - Dropped the "arm64: annotate user pointers casts detected by sparse"
> >   patch (see the discussion to the replies of the v6 of this patchset).
> > - Added more context to the cover letter.
> > - Updated Documentation/arm64/tagged-pointers.txt.
> >
> > Changes in v6:
> > - Added annotations for user pointer casts found by sparse.
> > - Rebased onto 050cdc6c (4.19-rc1+).
> >
> > Changes in v5:
> > - Added 3 new patches that add untagging to places found with static
> >   analysis.
> > - Rebased onto 44c929e1 (4.18-rc8).
> >
> > Changes in v4:
> > - Added a selftest for checking that passing tagged pointers to the
> >   kernel succeeds.
> > - Rebased onto 81e97f013 (4.18-rc1+).
> >
> > Changes in v3:
> > - Rebased onto e5c51f30 (4.17-rc6+).
> > - Added linux-arch@ to the list of recipients.
> >
> > Changes in v2:
> > - Rebased onto 2d618bdf (4.17-rc3+).
> > - Removed excessive untagging in gup.c.
> > - Removed untagging pointers returned from __uaccess_mask_ptr.
> >
> > Changes in v1:
> > - Rebased onto 4.17-rc1.
> >
> > Changes in RFC v2:
> > - Added "#ifndef untagged_addr..." fallback in linux/uaccess.h instead of
> >   defining it for each arch individually.
> > - Updated Documentation/arm64/tagged-pointers.txt.
> > - Dropped "mm, arm64: untag user addresses in memory syscalls".
> > - Rebased onto 3eb2ce82 (4.16-rc7).
> >
> > Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >
> > Andrey Konovalov (12):
> >   uaccess: add untagged_addr definition for other arches
> >   arm64: untag user pointers in access_ok and __uaccess_mask_ptr
> >   lib, arm64: untag user pointers in strn*_user
> >   mm, arm64: untag user pointers passed to memory syscalls
> >   mm, arm64: untag user pointers in mm/gup.c
> >   fs, arm64: untag user pointers in copy_mount_options
> >   fs, arm64: untag user pointers in fs/userfaultfd.c
> >   net, arm64: untag user pointers in tcp_zerocopy_receive
> >   kernel, arm64: untag user pointers in prctl_set_mm*
> >   tracing, arm64: untag user pointers in seq_print_user_ip
> >   arm64: update Documentation/arm64/tagged-pointers.txt
> >   selftests, arm64: add a selftest for passing tagged pointers to kernel
> >
> >  Documentation/arm64/tagged-pointers.txt       | 25 +++++++++++--------
> >  arch/arm64/include/asm/uaccess.h              | 10 +++++---
> >  fs/namespace.c                                |  2 +-
> >  fs/userfaultfd.c                              |  5 ++++
> >  include/linux/memory.h                        |  4 +++
> >  ipc/shm.c                                     |  2 ++
> >  kernel/sys.c                                  | 14 +++++++++++
> >  kernel/trace/trace_output.c                   |  2 +-
> >  lib/strncpy_from_user.c                       |  2 ++
> >  lib/strnlen_user.c                            |  2 ++
> >  mm/gup.c                                      |  4 +++
> >  mm/madvise.c                                  |  2 ++
> >  mm/mempolicy.c                                |  5 ++++
> >  mm/migrate.c                                  |  1 +
> >  mm/mincore.c                                  |  2 ++
> >  mm/mlock.c                                    |  5 ++++
> >  mm/mmap.c                                     |  7 ++++++
> >  mm/mprotect.c                                 |  2 ++
> >  mm/mremap.c                                   |  2 ++
> >  mm/msync.c                                    |  2 ++
> >  net/ipv4/tcp.c                                |  2 ++
> >  tools/testing/selftests/arm64/.gitignore      |  1 +
> >  tools/testing/selftests/arm64/Makefile        | 11 ++++++++
> >  .../testing/selftests/arm64/run_tags_test.sh  | 12 +++++++++
> >  tools/testing/selftests/arm64/tags_test.c     | 19 ++++++++++++++
> >  25 files changed, 129 insertions(+), 16 deletions(-)
> >  create mode 100644 tools/testing/selftests/arm64/.gitignore
> >  create mode 100644 tools/testing/selftests/arm64/Makefile
> >  create mode 100755 tools/testing/selftests/arm64/run_tags_test.sh
> >  create mode 100644 tools/testing/selftests/arm64/tags_test.c
> >
>
