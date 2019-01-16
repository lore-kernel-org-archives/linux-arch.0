From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 15/16] io_uring: add file registration
Date: Wed, 16 Jan 2019 11:45:17 +0100
Message-ID: <CAK8P3a2oHO-q6Nes3uakjFVcwYOAPHvLMyQW_qQg1_47PfH8Ng@mail.gmail.com>
References: <20190115025531.13985-1-axboe@kernel.dk> <20190115025531.13985-16-axboe@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190115025531.13985-16-axboe@kernel.dk>
Sender: owner-linux-aio@kvack.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-aio <linux-aio@kvack.org>, linux-block <linux-block@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 15, 2019 at 3:56 AM Jens Axboe <axboe@kernel.dk> wrote:

> @@ -132,4 +139,12 @@ struct io_uring_register_buffers {
>         __u32 nr_iovecs;
>  };
>
> +struct io_uring_register_files {
> +       union {
> +               __s32 *fds;
> +               __u64 pad;
> +       };
> +       __u32 nr_fds;
> +};

I think you should either remove the pad field here, or pass the pointer
using a __u64 argument itself. With the current definition, the ioctl
command code is the same between 32-bit and 64-bit architectures
(since the length is the same on anything other than x86), but the
structures are incompatible.

I would also suggest adding an explicit 32-bit pad field at the end
of the structure, to avoid the implicit padding on non-i386 machines.

     Arnd

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
