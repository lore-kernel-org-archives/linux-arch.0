From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 3/6] mm: introduce secretmemfd system call to create
 "secret" memory areas
Date: Mon, 20 Jul 2020 22:05:39 +0200
Message-ID: <CAK8P3a0ExFSSw-SCL=dSXzyv4jnp=yQs=ZooKDrL_tQogazrjg@mail.gmail.com>
References: <20200720092435.17469-1-rppt@kernel.org> <20200720092435.17469-4-rppt@kernel.org>
 <CAK8P3a0NyvRMqH7X0YNO5E6DGtvZXD5ZcD6Y6n7AkocufkMnHA@mail.gmail.com>
 <1595260305.4554.9.camel@linux.ibm.com> <CAK8P3a34kx4aAFY=-SBHX3suCLwxeZY7+YSRzct93YM_OFbSWA@mail.gmail.com>
 <1595272585.4554.28.camel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1595272585.4554.28.camel-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "James E.J. Bottomley" <jejb-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Cc: Mike Rapoport <rppt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexander Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Christopher Lameter <cl-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Elena Reshetova <elena.reshetova-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Idan Yaniv <idan.yaniv-qyM6JfAXOaQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Kirill A. Shutemov" <kirill-oKw7cIdHH8eLwutG50LtGA@public.gmane.org>, Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Palmer Dabbelt <palmer-96lFi9zoCfxBDgjK7y7TUQ@public.gmane.org>, Paul Walmsley <paul.walmsley-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 20, 2020 at 9:16 PM James Bottomley <jejb-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org> wrote:
> On Mon, 2020-07-20 at 20:08 +0200, Arnd Bergmann wrote:
> > On Mon, Jul 20, 2020 at 5:52 PM James Bottomley <jejb-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
> >
> > If there is no way the data stored in this new secret memory area
> > would relate to secret data in a TEE or some other hardware
> > device, then I agree that dma-buf has no value.
>
> Never say never, but current TEE designs tend to require full
> confidentiality for the entire execution.  What we're probing is
> whether we can improve security by doing an API that requires less than
> full confidentiality for the process.  I think if the API proves useful
> then we will get HW support for it, but it likely won't be in the
> current TEE of today form.

As I understand it, you normally have two kinds of buffers for the TEE:
one that may be allocated by Linux but is owned by the TEE itself
and not accessible by any process, and one that is used for
communication between the TEE and a user process.

The sharing would clearly work only for the second type: data that
a process wants to share with the TEE but as little else as possible.

A hypothetical example might be a process that passes encrypted
data to the TEE (which holds the key) for decryption, receives
decrypted data and then consumes that data in its own address
space. An electronic voting system (I know, evil example) might
receive encrypted ballots and sum them up this way without itself
having the secret key or anything else being able to observe
intermediate results.

> > > What we want is the ability to get an fd, set the properties and
> > > the size and mmap it.  This is pretty much a 100% overlap with the
> > > memfd API and not much overlap with the dmabuf one, which is why I
> > > don't think the interface is very well suited.
> >
> > Does that mean you are suggesting to use additional flags on
> > memfd_create() instead of a new system call?
>
> Well, that was what the previous patch did.  I'm agnostic on the
> mechanism for obtaining the fd: new syscall as this patch does or
> extension to memfd like the old one did.  All I was saying is that once
> you have the fd, the API you use on it is the same as the memfd API.

Ok.

I suppose we could even retrofit dma-buf underneath the
secretmemfd implementation if it ends up being useful later on,

      Arnd
