From: Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: io_uring vs in_compat_syscall()
Date: Tue, 21 Jul 2020 10:25:24 -0700
Message-ID: <CALCETrWMQpKe7jqw2t39yn4HgGhGTSEFGK6MPR4wPs=tBBhjbg@mail.gmail.com>
References: <b754dad5-ee85-8a2f-f41a-8bdc56de42e8@kernel.dk>
 <8987E376-6B13-4798-BDBA-616A457447CF@amacapital.net> <20200721070709.GB11432@lst.de>
 <CALCETrXWZBXZuCeRYvYY8AWG51e_P3bOeNeqc8zXPLOTDTHY0g@mail.gmail.com> <20200721143412.GA8099@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200721143412.GA8099-jcswGhMUV9g@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux API <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, io-uring-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 21, 2020 at 7:34 AM Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
>
> On Tue, Jul 21, 2020 at 07:31:02AM -0700, Andy Lutomirski wrote:
> > > What do you mean with "properly wired up".  Do you really want to spread
> > > ->compat_foo methods everywhere, including read and write?  I found
> > > in_compat_syscall() a lot small and easier to maintain than all the
> > > separate compat cruft.
> >
> > I was imagining using a flag.  Some of the net code uses
> > MSG_CMSG_COMPAT for this purpose.
>
> Killing that nightmarish monster is what actually got me into looking
> io_uring and starting this thread.

I agree that MSG_CMSG_COMPAT is nasty, but I think the concept is
sound -- rather than tracking whether we're compat by using a
different function or a per-thread variable, actually explicitly
tracking the mode seems sensible.

If we're going to play in_compat_syscall() games, let's please make
io_uring_enter() return -EINVAL if in_compat_syscall() != ctx->compat.

--Andy
