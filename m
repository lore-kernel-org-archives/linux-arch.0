From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCHSET v3] io_uring IO interface
Date: Sat, 12 Jan 2019 14:29:55 -0700
Message-ID: <20190112213011.1439-1-axboe@kernel.dk>
Return-path: <owner-linux-aio@kvack.org>
Sender: owner-linux-aio@kvack.org
To: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc: hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
List-Id: linux-arch.vger.kernel.org

Here's v3 of the io_uring interface. Since data structures etc have
changed since the v1 posting, here's a refresher of what io_uring
is and how it works.

io_uring is a submission queue (SQ) and completion queue (CQ) pair that
an application can use to communicate with the kernel for doing IO. This
isn't aio/libaio, but it provides a similar set of features, as well as
some new ones:

- io_uring is a lot more efficient than aio. A lot, and in many ways.

- io_uring supports buffered aio. Not just that, but efficiently as
  well. Cached data isn't punted to an async context.

- io_uring supports polled IO, it takes advantage of the blk-mq polling
  work that went into 5.0-rc.

- io_uring supports kernel side submissions for polled IO. This enables
  IO without ever having to do a system call.

- io_uring supports fixed buffers for O_DIRECT. Buffers can be
  registered after an io_uring context has been setup, which eliminates
  the need to do get_user_pages() / put_pages() for each and every IO.

To use io_uring, you must first setup an io_uring context. This is done
through the first of three new system calls:

io_uring_setup(entries, params)
	Sets up a context for doing async IO. On success, returns a file
	descriptor that the application can mmap to gain access to the
	SQ ring, CQ ring, and io_uring_sqe's.

Once the rings are setup, the application then mmap's these rings to
communicate with the kernel. See a sample application I wrote that
natively does this:

http://git.kernel.dk/cgit/fio/plain/t/io_uring.c

IO is done by filling out an io_uring_sqe, and updating the SQ ring. The
format of the sqe is as follows:

struct io_uring_sqe {
	__u8	opcode;		/* type of operation for this sqe */
	__u8	flags;		/* IOSQE_ flags */
	__u16	ioprio;		/* ioprio for the request */
	__s32	fd;		/* file descriptor to do IO on */
	__u64	off;		/* offset into file */
	union {
		void	*addr;	/* buffer or iovecs */
		__u64	__pad;
	};
	__u32	len;		/* buffer size or number of iovecs */
	union {
		__kernel_rwf_t	rw_flags;
		__u32		fsync_flags;
	};
	__u16	buf_index;	/* index into fixed buffers, if used */
	__u16	__pad2;
	__u32	__pad3;
	__u64	user_data;	/* data to be passed back at completion time */
};

Most of this is self explanatory. The ->user_data field is passed back
through a completion event, so the application can track IOs
individually.

Completions are posted on the CQ ring when an sqe completes, they are a
struct io_uring_cqe and the format is as follows:

struct io_uring_cqe {
	__u64	user_data;	/* sqe->data submission passed back */
	__s32	res;		/* result code for this event */
	__u32	flags;
};

To either submit IO or reap completions, there's a 2nd new system call:

io_uring_enter(fd, to_submit, min_complete, flags)
	Initiates IO against the rings mapped to this fd, or waits for
	them to complete, or both The behavior is controlled by the
	parameters passed in. If 'min_complete' is non-zero, then we'll
	try and submit new IO. If IORING_ENTER_GETEVENTS is set, the
	kernel will wait for 'min_complete' events, if they aren't
	already available.

The sample application mentioned above uses the rings directly, but for
most uses cases, I intend to have the necessary support in a liburing
library that abstracts it enough for application to use in a performant
way, without having to deal with the intricacies of the ring. There's
already some basic support there and a few test applications, but that
side definitely needs some work. Find that repo here:

git://git.kernel.dk/liburing

io_uring is designed to be fast and scalable. I've demonstrated 1.6M 4k
IOPS from a single core on my aging test box, and on the latency front,
we're also doing extremely well. It's designed to both be async and
batching, if you wish, the application gets to control how to use that
side.

If you want to play with io_uring, see the sample app above, the
liburing repo, or the fio io_uring engine as well.

Patches are against 5.0-rc1 (ish), and can also be found in my
'io_uring' git branch:

git://git.kernel.dk/linux-block io_uring


Since v2
- Separate fixed buffers from sqe entries. register/unregister them
  through the new io_uring_register(2) system call
- sqe->index is now sqe->buf_index to make it clearer
- fixed buffers require sqe->flags to have IOSQE_FIXED_BUFFER set
- Add sqe field that is passed back at completion through the cqe, instead
  of passing back the original sqe index. This is more useful as it allows
  per-life of IO data, ->index did not.
- Cleanup async IO punting
- Don't punt O_DIRECT writes to async handling
- Make sq thread just for polling (submissions and completions)
- Always enable sq workqueue for async offload
- Use GFP_ATOMIC for req allocation
- Fix bio_vec being an unknown type on some kconfigs
- New IORING_OP_FSYNC implementation
- Add fixed fileset support through io_uring_register(2)
- Integrate workqueue support into main patchset
- Fix io_sq_thread() logic for when to grab current->mm
- Fix io_sq_thread() off-by-one
- Improve polling performance for multiple files in an io_uring context
- Have CONFIG_IO_URING select ANON_INODES
- Don't make io_kiocb->ki_flags atomic
- Be fully consistent in naming, for some reason we used the same
  mess that aio.c is, where io_kiocb,kiocb,iocb are used interchangably.
  'req' is now always io_kiocb, 'kiocb' is always kiocb.
- Rename KIOCB_F_* flags as they are req flags, REQ_F_*.


 Documentation/filesystems/vfs.txt      |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    3 +
 block/bio.c                            |   59 +-
 fs/Makefile                            |    1 +
 fs/block_dev.c                         |   19 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |    9 +-
 fs/gfs2/file.c                         |    2 +
 fs/io_uring.c                          | 2023 ++++++++++++++++++++++++
 fs/iomap.c                             |   48 +-
 fs/xfs/xfs_file.c                      |    1 +
 include/linux/bio.h                    |   14 +
 include/linux/blk_types.h              |    1 +
 include/linux/file.h                   |    2 +
 include/linux/fs.h                     |    6 +-
 include/linux/iomap.h                  |    1 +
 include/linux/syscalls.h               |    7 +
 include/uapi/linux/io_uring.h          |  147 ++
 init/Kconfig                           |    9 +
 kernel/sys_ni.c                        |    3 +
 20 files changed, 2334 insertions(+), 39 deletions(-)

-- 
Jens Axboe


--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
