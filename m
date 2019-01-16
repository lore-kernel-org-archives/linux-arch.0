Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35615 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbfAPKx6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jan 2019 05:53:58 -0500
MIME-Version: 1.0
References: <20190115025531.13985-1-axboe@kernel.dk> <20190115025531.13985-14-axboe@kernel.dk>
In-Reply-To: <20190115025531.13985-14-axboe@kernel.dk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 16 Jan 2019 11:53:40 +0100
Message-ID: <CAK8P3a3aTZ-VEc=uvOeYov4DiaBN1iNuhR41BfP0Qdf3AXx74w@mail.gmail.com>
Subject: Re: [PATCH 13/16] io_uring: add support for pre-mapped user IO buffers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-aio <linux-aio@kvack.org>, linux-block <linux-block@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>

On Tue, Jan 15, 2019 at 3:56 AM Jens Axboe <axboe@kernel.dk> wrote:

> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 542757a4c898..e36c264d74e8 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -314,6 +314,8 @@ asmlinkage long sys_io_uring_setup(u32 entries,
>                                 struct io_uring_params __user *p);
>  asmlinkage long sys_io_uring_enter(unsigned int fd, u32 to_submit,
>                                 u32 min_complete, u32 flags);
> +asmlinkage long sys_io_uring_register(unsigned int fd, unsigned op,
> +                               void __user *arg);
>

Would it be possible to make this a typed pointer instead? If this needs to
be extended later to pass a different structure, a new system call may
be better for consistency than overloading the argument in various
ways.

> + * io_uring_register(2) opcodes and arguments
> + */
> +#define IORING_REGISTER_BUFFERS                0
> +#define IORING_UNREGISTER_BUFFERS      1
> +
> +struct io_uring_register_buffers {
> +       union {
> +               struct iovec *iovecs;
> +               __u64 pad;
> +       };
> +       __u32 nr_iovecs;
> +};

As before, I'd suggest making this structure compatible between 32-bit
and 64-bit architectectures, by avoiding pointer and implied padding
fields.

      Arnd
