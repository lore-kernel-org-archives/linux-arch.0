From: Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: io_uring vs in_compat_syscall()
Date: Tue, 21 Jul 2020 07:31:02 -0700
Message-ID: <CALCETrXWZBXZuCeRYvYY8AWG51e_P3bOeNeqc8zXPLOTDTHY0g@mail.gmail.com>
References: <b754dad5-ee85-8a2f-f41a-8bdc56de42e8@kernel.dk>
 <8987E376-6B13-4798-BDBA-616A457447CF@amacapital.net> <20200721070709.GB11432@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200721070709.GB11432-jcswGhMUV9g@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux API <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, io-uring-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 21, 2020 at 12:07 AM Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
>
> On Mon, Jul 20, 2020 at 10:28:55AM -0700, Andy Lutomirski wrote:
> > > Sure, I'd consider that implementation detail for the actual patch(es=
)
> > > for this issue.
> >
> > There=E2=80=99s a corner case, though: doesn=E2=80=99t io_uring submiss=
ion frequently do the work synchronously in the context of the calling thre=
ad?
>
> Yes.
>
> > If so, can a thread do a 64-bit submit with 32-bit work or vice versa?
>
> In theory you could share an fd created in a 32-bit thread to a 64-bit
> thread or vice versa, but I think at that point you absolutely are in
> "you get to keep the pieces" land.

That seems potentially okay as long as these are pieces of userspace
and not pieces of the kernel.  If the kernel freaks out, we have a
problem.

>
> > Sometimes I think that in_compat_syscall() should have a mode in which =
calling it warns (e.g. not actually in a syscall when doing things in io_ur=
ing).  And the relevant operations should be properly wired up to avoid glo=
bal state like this.
>
> What do you mean with "properly wired up".  Do you really want to spread
> ->compat_foo methods everywhere, including read and write?  I found
> in_compat_syscall() a lot small and easier to maintain than all the
> separate compat cruft.

I was imagining using a flag.  Some of the net code uses
MSG_CMSG_COMPAT for this purpose.

--Andy
