From: James Bottomley <jejb@linux.ibm.com>
Subject: Re: [PATCH 3/6] mm: introduce secretmemfd system call to create
 "secret" memory areas
Date: Mon, 20 Jul 2020 08:51:45 -0700
Message-ID: <1595260305.4554.9.camel@linux.ibm.com>
References: <20200720092435.17469-1-rppt@kernel.org>
         <20200720092435.17469-4-rppt@kernel.org>
         <CAK8P3a0NyvRMqH7X0YNO5E6DGtvZXD5ZcD6Y6n7AkocufkMnHA@mail.gmail.com>
Reply-To: jejb@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0NyvRMqH7X0YNO5E6DGtvZXD5ZcD6Y6n7AkocufkMnHA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Mon, 2020-07-20 at 13:30 +0200, Arnd Bergmann wrote:
> On Mon, Jul 20, 2020 at 11:25 AM Mike Rapoport <rppt@kernel.org>
> wrote:
> > 
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Introduce "secretmemfd" system call with the ability to create
> > memory areas visible only in the context of the owning process and
> > not mapped not only to other processes but in the kernel page
> > tables as well.
> > 
> > The user will create a file descriptor using the secretmemfd system
> > call where flags supplied as a parameter to this system call will
> > define the desired protection mode for the memory associated with
> > that file descriptor. Currently there are two protection modes:
> > 
> > * exclusive - the memory area is unmapped from the kernel direct
> > map and it
> >               is present only in the page tables of the owning mm.
> > * uncached  - the memory area is present only in the page tables of
> > the
> >               owning mm and it is mapped there as uncached.
> > 
> > For instance, the following example will create an uncached mapping
> > (error handling is omitted):
> > 
> >         fd = secretmemfd(SECRETMEM_UNCACHED);
> >         ftruncate(fd, MAP_SIZE);
> >         ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE,
> > MAP_SHARED,
> >                    fd, 0);
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> I wonder if this should be more closely related to dmabuf file
> descriptors, which are already used for a similar purpose: sharing
> access to secret memory areas that are not visible to the OS but can
> be shared with hardware through device drivers that can import a
> dmabuf file descriptor.

I'll assume you mean the dmabuf userspace API?  Because the kernel API
is completely device exchange specific and wholly inappropriate for
this use case.

The user space API of dmabuf uses a pseudo-filesystem.  So you mount
the dmabuf file type (and by "you" I mean root because an ordinary user
doesn't have sufficient privilege).  This is basically because every
dmabuf is usable by any user who has permissions.  This really isn't
the initial interface we want for secret memory because secret regions
are supposed to be per process and not shared (at least we don't want
other tenants to see who's using what).

Once you have the fd, you can seek to find the size, mmap, poll and
ioctl it.  The ioctls are all to do with memory synchronization (as
you'd expect from a device backed region) and the mmap is handled by
the dma_buf_ops, which is device specific.  Sizing is missing because
that's reported by the device not settable by the user.

What we want is the ability to get an fd, set the properties and the
size and mmap it.  This is pretty much a 100% overlap with the memfd
API and not much overlap with the dmabuf one, which is why I don't
think the interface is very well suited.

James
