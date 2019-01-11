From: Roman Penyaev <rpenyaev@suse.de>
Subject: Re: [PATCHSET v2] io_uring IO interface
Date: Fri, 11 Jan 2019 10:46:01 +0100
Message-ID: <fe686e4316f9746c46b91fd58c984531@suse.de>
References: <20190110024404.25372-1-axboe@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190110024404.25372-1-axboe@kernel.dk>
Sender: owner-linux-aio@kvack.org
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, linux-block-owner@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Jens,

That is interesting.  Recently I sent an rfc related to epoll uring:

https://lore.kernel.org/lkml/20190109164025.24554-1-rpenyaev@suse.de

which can be mapped to userspace and all ready events can be consumed
from it directly.  I am wondering, is it possible to make some common
API for all kind of ready events / urings, or it doesn't make any
sense?

--
Roman


On 2019-01-10 03:43, Jens Axboe wrote:
> Here's v2 of the io_uring interface. See the v1 posting for some more 
> info:
> 
> https://lore.kernel.org/linux-block/20190108165645.19311-1-axboe@kernel.dk/
> 
> The data structures changed, to improve the symmetry of the submission
> and completion side. The io_uring_iocb is now io_uring_sqe, but it
> otherwise remains the same as before. Ditto on the completion side,
> where io_uring_event is now io_uring_cqe.
> 
> I've updated the fio io_uring test app, and the io_uring engine. The
> liburing git repo has also been adapted to the various changes since 
> the
> v1 posting. As a reminder, the liburing git repo contains some helpers
> for doing IO without having to muck with the ring directly, setting up
> an io_uring context, etc. Clone that here:
> 
> git://git.kernel.dk/liburing
> 
> In terms of usage, there's also a small test app here:
> 
> http://git.kernel.dk/cgit/fio/plain/t/io_uring.c
> 
> and the liburing repo has a few test apps in test/ as well.
> 
> Patches are aginst 5.0-rc1, but can also be found here:
> 
> git://git.kernel.dk/linux-block io_uring
> 
> Changes since v1:
> 
> - Fail IORING_OP_{READ,WRITE}_FIXED if not configured
> - Fix ctx drop ref issue on failure to close ring_fd when sq thread/wq
>   are in use
> - Move to separate Kconfig entry (CONFIG_IO_URING)
> - Add SPDX headers
> - Drop gcc ism of zero sized arrays
> - Rename io_uring_iocb -> io_uring_sqe
> - Rename io_uring_event -> io_uring_cqe
> - Drop needless io_event_ring and io_iocb_ring structures
> - Drop ctx->max_reqs, use ->sq_entries
> - Drop unused ->ring_lock
> - Drop io_ring_ctx slab cache
> - Fix state batched kiocb alloc failure to put ctx
> - Fix missing write ordering barrier when filling in the cqe
> - Drop io_req_init()
> - Various renames
> - Fix a few lines that were too long
> - Address other minor review comments
> - Fix IORING_SETUP_SQPOLL being set without IORING_SETUP_SQTHREAD
> - Drop IORING_SETUP_FIXEDBUFS, iovecs being non-NULL is enough
> - Fix error handling free of ctx in setup path
> - Change standard read/write commands to be iov based READV/WRITEV
> - Pass in struct sqe_submit instead of separate sqe/index everywhere
> - Fix reap of polled events on fops->release()
> - Lock uring for sq thread polling
> - Don't grab ->completion_lock for polled IO cqe filling
> - Fix ev_flags vs flags typo
> - Consolidate parts of the io_ring_ctx alignment
> 
>  Documentation/filesystems/vfs.txt      |    3 +
>  arch/x86/entry/syscalls/syscall_64.tbl |    2 +
>  block/bio.c                            |   59 +-
>  fs/Makefile                            |    1 +
>  fs/block_dev.c                         |   19 +-
>  fs/file.c                              |   15 +-
>  fs/file_table.c                        |    9 +-
>  fs/gfs2/file.c                         |    2 +
>  fs/io_uring.c                          | 1890 ++++++++++++++++++++++++
>  fs/iomap.c                             |   48 +-
>  fs/xfs/xfs_file.c                      |    1 +
>  include/linux/bio.h                    |   14 +
>  include/linux/blk_types.h              |    1 +
>  include/linux/file.h                   |    2 +
>  include/linux/fs.h                     |    6 +-
>  include/linux/iomap.h                  |    1 +
>  include/linux/syscalls.h               |    5 +
>  include/uapi/linux/io_uring.h          |  114 ++
>  init/Kconfig                           |    8 +
>  kernel/sys_ni.c                        |    2 +
>  20 files changed, 2163 insertions(+), 39 deletions(-)

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
