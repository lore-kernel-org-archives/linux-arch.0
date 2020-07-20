From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/6] mm: introduce secretmemfd system call to create
 "secret" memory areas
Date: Mon, 20 Jul 2020 16:34:12 +0200
Message-ID: <CAK8P3a07jAec4hKyNMcha032TT6OXjYHaZZ4Za9ncDsvapeg8Q@mail.gmail.com>
References: <20200720092435.17469-1-rppt@kernel.org> <20200720092435.17469-4-rppt@kernel.org>
 <CAK8P3a0NyvRMqH7X0YNO5E6DGtvZXD5ZcD6Y6n7AkocufkMnHA@mail.gmail.com> <20200720142053.GC8593@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200720142053.GC8593@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Rapoport <rppt@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 20, 2020 at 4:21 PM Mike Rapoport <rppt@kernel.org> wrote:
> On Mon, Jul 20, 2020 at 01:30:13PM +0200, Arnd Bergmann wrote:
> > On Mon, Jul 20, 2020 at 11:25 AM Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > >
> > > Introduce "secretmemfd" system call with the ability to create memory areas
> > > visible only in the context of the owning process and not mapped not only
> > > to other processes but in the kernel page tables as well.
> > >
> > > The user will create a file descriptor using the secretmemfd system call
> > > where flags supplied as a parameter to this system call will define the
> > > desired protection mode for the memory associated with that file
> > > descriptor. Currently there are two protection modes:
> > >
> > > * exclusive - the memory area is unmapped from the kernel direct map and it
> > >               is present only in the page tables of the owning mm.
> > > * uncached  - the memory area is present only in the page tables of the
> > >               owning mm and it is mapped there as uncached.
> > >
> > > For instance, the following example will create an uncached mapping (error
> > > handling is omitted):
> > >
> > >         fd = secretmemfd(SECRETMEM_UNCACHED);
> > >         ftruncate(fd, MAP_SIZE);
> > >         ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
> > >                    fd, 0);
> > >
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >
> > I wonder if this should be more closely related to dmabuf file
> > descriptors, which
> > are already used for a similar purpose: sharing access to secret memory areas
> > that are not visible to the OS but can be shared with hardware through device
> > drivers that can import a dmabuf file descriptor.
>
> TBH, I didn't think about dmabuf, but my undestanding is that is this
> case memory areas are not visible to the OS because they are on device
> memory rather than normal RAM and when dmabuf is backed by the normal
> RAM, the memory is visible to the OS.

No, dmabuf is normally about normal RAM that is shared between multiple
devices, the idea is that you can have one driver allocate a buffer in RAM
and export it to user space through a file descriptor. The application can then
go and mmap() it or pass it into one or more other drivers.

This can be used e.g. for sharing a buffer between a video codec and the
gpu, or between a crypto engine and another device that accesses
unencrypted data while software can only observe the encrypted version.

       Arnd
