From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 3/6] mm: introduce secretmemfd system call to create
 "secret" memory areas
Date: Mon, 20 Jul 2020 13:30:13 +0200
Message-ID: <CAK8P3a0NyvRMqH7X0YNO5E6DGtvZXD5ZcD6Y6n7AkocufkMnHA@mail.gmail.com>
References: <20200720092435.17469-1-rppt@kernel.org> <20200720092435.17469-4-rppt@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200720092435.17469-4-rppt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Rapoport <rppt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexander Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Christopher Lameter <cl-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Elena Reshetova <elena.reshetova-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Idan Yaniv <idan.yaniv-qyM6JfAXOaQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, James Bottomley <jejb-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, "Kirill A. Shutemov" <kirill-oKw7cIdHH8eLwutG50LtGA@public.gmane.org>, Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Palmer Dabbelt <palmer-96lFi9zoCfxBDgjK7y7TUQ@public.gmane.org>, Paul Walmsley <paul.walmsley-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 20, 2020 at 11:25 AM Mike Rapoport <rppt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> From: Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
>
> Introduce "secretmemfd" system call with the ability to create memory areas
> visible only in the context of the owning process and not mapped not only
> to other processes but in the kernel page tables as well.
>
> The user will create a file descriptor using the secretmemfd system call
> where flags supplied as a parameter to this system call will define the
> desired protection mode for the memory associated with that file
> descriptor. Currently there are two protection modes:
>
> * exclusive - the memory area is unmapped from the kernel direct map and it
>               is present only in the page tables of the owning mm.
> * uncached  - the memory area is present only in the page tables of the
>               owning mm and it is mapped there as uncached.
>
> For instance, the following example will create an uncached mapping (error
> handling is omitted):
>
>         fd = secretmemfd(SECRETMEM_UNCACHED);
>         ftruncate(fd, MAP_SIZE);
>         ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
>                    fd, 0);
>
> Signed-off-by: Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>

I wonder if this should be more closely related to dmabuf file
descriptors, which
are already used for a similar purpose: sharing access to secret memory areas
that are not visible to the OS but can be shared with hardware through device
drivers that can import a dmabuf file descriptor.

      Arnd
