Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34866 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732720AbfBRQw2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2019 11:52:28 -0500
Received: by mail-qk1-f195.google.com with SMTP id w204so10367944qka.2
        for <linux-arch@vger.kernel.org>; Mon, 18 Feb 2019 08:52:28 -0800 (PST)
MIME-Version: 1.0
References: <201902190052.bZjV0Dgp%fengguang.wu@intel.com> <20190218114242-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190218114242-mutt-send-email-mst@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 17:52:09 +0100
Message-ID: <CAK8P3a0TELB9XN5xM7yXRE0RJCGkF1b9YFshY7dzeTcFttKGVg@mail.gmail.com>
Subject: Re: [asm-generic:master 2/6] arch/x86//mm/mpx.c:57:26: error:
 'MAP_PRIVATE' undeclared; did you mean 'DQF_PRIVATE'?
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, linux-arch <linux-arch@vger.kernel.org>

On Mon, Feb 18, 2019 at 5:44 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Feb 19, 2019 at 12:28:55AM +0800, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
> > head:   3c4fcc2648569c3fe573849f9254c8c3499ec648
> > commit: 9ac483109d19095e22414e46d38a6817520883b9 [2/6] arch: move common mmap flags to linux/mman.h
> > config: x86_64-kexec (attached as .config)
> > compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> > reproduce:
> >         git checkout 9ac483109d19095e22414e46d38a6817520883b9
> >         # save the attached .config to linux build tree
> >         make ARCH=x86_64
> >
> > All errors (new ones prefixed by >>):
> >
> >    arch/x86//mm/mpx.c: In function 'mpx_mmap':
> > >> arch/x86//mm/mpx.c:57:26: error: 'MAP_PRIVATE' undeclared (first use in this function); did you mean 'DQF_PRIVATE'?
> >              MAP_ANONYMOUS | MAP_PRIVATE, VM_MPX, 0, &populate, NULL);
> >                              ^~~~~~~~~~~
> >                              DQF_PRIVATE
> >    arch/x86//mm/mpx.c:57:26: note: each undeclared identifier is reported only once for each function it appears in
>
> Arnd I think you are missing:
>     x86/mpx: tweak header name
>
> The whole file is going away eventually:
> https://lkml.kernel.org/r/7de5232f-4bc1-5c85-00d5-cb646462577f@intel.com
>
> but to avoid breaking bisect I think it's needed.

Right, I misunderstood the earlier mails and assumed it wasn't really
needed even for building the current tree. Added it in now as well. I see that
there are various other files including asm/mman.h:

arch/arm/mm/hugetlbpage.c:#include <asm/mman.h>
arch/arm64/mm/hugetlbpage.c:#include <asm/mman.h>
arch/c6x/include/asm/cacheflush.h:#include <asm/mman.h>
arch/ia64/include/asm/pgtable.h:#include <asm/mman.h>
arch/ia64/mm/hugetlbpage.c:#include <asm/mman.h>
arch/mips/kernel/linux32.c:#include <asm/mman.h>
arch/mips/mm/hugetlbpage.c:#include <asm/mman.h>
arch/parisc/mm/hugetlbpage.c:#include <asm/mman.h>
arch/powerpc/include/asm/mman.h:#include <uapi/asm/mman.h>
arch/powerpc/mm/hugetlbpage-radix.c:#include <asm/mman.h>
arch/powerpc/mm/pkeys.c:#include <asm/mman.h>
arch/powerpc/mm/slice.c:#include <asm/mman.h>
arch/sh/mm/hugetlbpage.c:#include <asm/mman.h>
arch/sparc/include/asm/mman.h:#include <uapi/asm/mman.h>
arch/sparc/mm/hugetlbpage.c:#include <asm/mman.h>
arch/um/kernel/syscall.c:#include <asm/mman.h>
arch/x86/ia32/sys_ia32.c:#include <asm/mman.h>
arch/x86/mm/hugetlbpage.c:#include <asm/mman.h>
arch/x86/um/shared/sysdep/kernel-offsets.h:#include <asm/mman.h>
fs/eventpoll.c:#include <asm/mman.h>
include/uapi/linux/mman.h:#include <asm/mman.h>
mm/filemap.c:#include <asm/mman.h>
tools/include/uapi/linux/mman.h:#include <asm/mman.h>
virt/kvm/arm/arm.c:#include <asm/mman.h>

Did you check if we need to do the same change on any of the
other files? A lot of them are architecture specific and might not be
caught by the regular build testing.

      Arnd
