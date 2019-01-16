From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 05/16] Add io_uring IO interface
Date: Wed, 16 Jan 2019 12:00:40 +0100
Message-ID: <CAK8P3a1=-=8YZ+9wsCGJ+gS3G5axHAKXA4XVcEQnyzwHD6fO6A@mail.gmail.com>
References: <20190115025531.13985-1-axboe@kernel.dk> <20190115025531.13985-6-axboe@kernel.dk>
 <CAK8P3a19ie7wcndDW7oxmUGh5c9aaarJycKBVOQ2F9+eHj=nsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <CAK8P3a19ie7wcndDW7oxmUGh5c9aaarJycKBVOQ2F9+eHj=nsg@mail.gmail.com>
Sender: owner-linux-aio@kvack.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-aio <linux-aio@kvack.org>, linux-block <linux-block@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 16, 2019 at 11:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > +/*
> > + * IO submission data structure (Submission Queue Entry)
> > + */
> > +struct io_uring_sqe {
> > +       __u8    opcode;         /* type of operation for this sqe */
> > +       __u8    flags;          /* as of now unused */
> > +       __u16   ioprio;         /* ioprio for the request */
> > +       __s32   fd;             /* file descriptor to do IO on */
> > +       __u64   off;            /* offset into file */
> > +       union {
> > +               void    *addr;  /* buffer or iovecs */
> > +               __u64   __pad;
> > +       };
>
> It seems a bit unfortunate to keep the pointer field only
> almost compatible between 32-bit and 64-bit big-endian
> architectures, as that requires an in_compat_syscall()
> check whenever we access the pointer from the kernel.
>
> Could you use a __u64 field to store the pointer itself
> instead?

To clarify: Using the u64_to_user_ptr() helper function,
you can interpret a __u64 field in a uapi data structure
directly as a pointer. The user space side needs a similar
wrapper though.

     Arnd

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
