From: David Howells <dhowells@redhat.com>
Subject: Re: CONFIG_* symbols in UAPI headers?
Date: Tue, 09 Apr 2019 19:17:25 +0100
Message-ID: <3479.1554833845@warthog.procyon.org.uk>
References: <CAK8P3a13NVbkJzzoZG_7HrDT9qGPR5ptbRUL=xH1oZ1a+5ksHw@mail.gmail.com> <20190408124640.GA607@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a13NVbkJzzoZG_7HrDT9qGPR5ptbRUL=xH1oZ1a+5ksHw@mail.gmail.com>
Content-ID: <3478.1554833845.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: dhowells@redhat.com, Christoph Hellwig <hch@lst.de>, Jie Zhang <jie.zhang@analog.com>, Mike Frysinger <vapier@gentoo.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:

> > I just stumbled over the MAP_UNINITIALIZED defintion, initially
> > added by:
> >
> > commit ea637639591def87a54cea811cbac796980cb30d
> > Author: Jie Zhang <jie.zhang@analog.com>
> > Date:   Mon Dec 14 18:00:02 2009 -0800
> >
> >     nommu: fix malloc performance by adding uninitialized flag
> >
> > The defintion depends on CONFIG_MMAP_ALLOW_UNINITIALIZED, which
> > will never be set by userspace.  How is this supposed to work?
> >
> > Shoudn't we define the symbol unconditionally and just turn it
> > into a no-op in the implementation?

Yes.

> Right, good catch. That should work. It can probably be done
> by adding another check before the conditional, like:
> 
>        /* clear anonymous mappings that don't ask for uninitialized data */
>        if (!vma->vm_file &&
>            !(IS_ENABLED(CONFIG_MMAP_ALLOW_UNINITIALIZED) &&
>              (flags & MAP_UNINITIALIZED))
>                memset((void *)region->vm_start, 0,
>                       region->vm_end - region->vm_start);

Sounds good.

> > There are a few similar issues, like struct elf_prstatus having
> > a different layout depending on CONFIG_BINFMT_ELF_FDPIC, or
> > MAX_SHARED_LIBS defending on CONFIG_BINFMT_SHARED_FLAT.

Because the kernel code uses that header and that struct too, so you'd break
compilation of binfmt_elf_fdpic.c.  There is a way round it - and that's to
copy the struct into the non-UAPI backing header and delete the conditional
section from the UAPI one.  You'd have to stop the non-UAPI header from
#including the UAPI header, though, and you'd have to hope that no one is
trying to set it in userspace (gdb doesn't).

David
