From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/6] mm: introduce secretmemfd system call to create
 "secret" memory areas
Date: Mon, 20 Jul 2020 20:08:43 +0200
Message-ID: <CAK8P3a34kx4aAFY=-SBHX3suCLwxeZY7+YSRzct93YM_OFbSWA@mail.gmail.com>
References: <20200720092435.17469-1-rppt@kernel.org> <20200720092435.17469-4-rppt@kernel.org>
 <CAK8P3a0NyvRMqH7X0YNO5E6DGtvZXD5ZcD6Y6n7AkocufkMnHA@mail.gmail.com> <1595260305.4554.9.camel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:58215 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbgGTSJF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2020 14:09:05 -0400
In-Reply-To: <1595260305.4554.9.camel@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: Mike Rapoport <rppt@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>

On Mon, Jul 20, 2020 at 5:52 PM James Bottomley <jejb@linux.ibm.com> wrote:
> On Mon, 2020-07-20 at 13:30 +0200, Arnd Bergmann wrote:
>
> I'll assume you mean the dmabuf userspace API?  Because the kernel API
> is completely device exchange specific and wholly inappropriate for
> this use case.
>
> The user space API of dmabuf uses a pseudo-filesystem.  So you mount
> the dmabuf file type (and by "you" I mean root because an ordinary user
> doesn't have sufficient privilege).  This is basically because every
> dmabuf is usable by any user who has permissions.  This really isn't
> the initial interface we want for secret memory because secret regions
> are supposed to be per process and not shared (at least we don't want
> other tenants to see who's using what).
>
> Once you have the fd, you can seek to find the size, mmap, poll and
> ioctl it.  The ioctls are all to do with memory synchronization (as
> you'd expect from a device backed region) and the mmap is handled by
> the dma_buf_ops, which is device specific.  Sizing is missing because
> that's reported by the device not settable by the user.

I was mainly talking about the in-kernel interface that is used for
sharing a buffer with hardware. Aside from the limited ioctls, anything
in the kernel can decide on how it wants to export a dma_buf by
calling dma_buf_export()/dma_buf_fd(), which is roughly what the
new syscall does as well. Using dma_buf vs the proposed
implementation for this is not a big difference in complexity.

The one thing that a dma_buf does is that it allows devices to
do DMA on it. This is either something that can turn out to be
useful later, or it is not. From the description, it sounded like
the sharing might be useful, since we already have known use
cases in which "secret" data is exchanged with a trusted execution
environment using the dma-buf interface.

If there is no way the data stored in this new secret memory area
would relate to secret data in a TEE or some other hardware
device, then I agree that dma-buf has no value.

> What we want is the ability to get an fd, set the properties and the
> size and mmap it.  This is pretty much a 100% overlap with the memfd
> API and not much overlap with the dmabuf one, which is why I don't
> think the interface is very well suited.

Does that mean you are suggesting to use additional flags on
memfd_create() instead of a new system call?

      Arnd
