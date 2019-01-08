From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCHSET v1] io_uring IO interface
Date: Tue,  8 Jan 2019 09:56:29 -0700
Message-ID: <20190108165645.19311-1-axboe@kernel.dk>
Return-path: <owner-linux-aio@kvack.org>
Sender: owner-linux-aio@kvack.org
To: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc: hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
List-Id: linux-arch.vger.kernel.org

After some arm twisting from Christoph, I finally caved and divorced the
aio-poll patches from aio/libaio itself. The io_uring interface itself
is useful and efficient, and after rebasing all the new goodies on top
of that, there was little reason to retail the aio connection.

Hence io_uring was born. This is what I previously called scqring for
aio, but now as a standalone entity. Patch #5 adds the core of this
interface, but in short, it has two main data structures:

struct io_uring_iocb {
	__u8	opcode;
	__u8	flags;
	__u16	ioprio;
	__s32	fd;
	__u64	off;
	union {
		void	*addr;
		__u64	__pad;
	};
	__u32	len;
	union {
		__kernel_rwf_t	rw_flags;
		__u32		__resv;
	};
};

struct io_uring_event {
	__u64	index;		/* what iocb this event came from */
	__s32	res;		/* result code for this event */
	__u32	flags;
};

The SQ ring is an array of indexes into an array of io_uring_iocbs,
which describe the IO to be done. The SQ ring is an array of
io_uring_events, which describe a completion event. Both of these rings
are mapped into the application through mmap(2), at special magic
offsets. The application manipulates the ring directly, and then
communicates with the kernel through these two system calls:

io_uring_setup(entries, iovecs, params)
	Sets up a context for doing async IO. On success, returns a file
	descriptor that the application can mmap to gain access to the
	SQ ring, CQ ring, and io_uring_iocbs.

io_uring_enter(fd, to_submit, min_complete, flags)
	Initiates IO against the rings mapped to this fd, or waits for
	them to complete, or both The behavior is controlled by the
	parameters passed in. If 'min_complete' is non-zero, then we'll
	try and submit new IO. If IORING_ENTER_GETEVENTS is set, the
	kernel will wait for 'min_complete' events, if they aren't
	already available.

I've started a liburing git repo for this, which contains some helpers
for doing IO without having to muck with the ring directly, setting up
an io_uring context, etc. Clone that here:

git://git.kernel.dk/liburing

In terms of usage, there's also a small test app here:

http://git.kernel.dk/cgit/fio/plain/t/io_uring.c

and if you're into fio, there's a io_uring engine included with that as
well for test purposes.

In terms of features, this has everything that the prior aio-poll
postings did. Later patches add support for polled IO, fixed buffers,
kernel side submission and polling, buffered aio, etc. Also a number of
bug fixes in here from previous postings.

Series is against 5.0-rc1, and can also be found in my io_uring branch.
For now just x86-64 has the system calls wired up, and liburing also
only supports x86-64. The latter just needs system call numbers and
reasonable read/write barrier defines to work, however.

 Documentation/filesystems/vfs.txt      |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    2 +
 block/bio.c                            |   59 +-
 fs/Makefile                            |    2 +-
 fs/block_dev.c                         |   19 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |    9 +-
 fs/gfs2/file.c                         |    2 +
 fs/io_uring.c                          | 1907 ++++++++++++++++++++++++
 fs/iomap.c                             |   48 +-
 fs/xfs/xfs_file.c                      |    1 +
 include/linux/bio.h                    |   14 +
 include/linux/blk_types.h              |    1 +
 include/linux/file.h                   |    2 +
 include/linux/fs.h                     |    6 +-
 include/linux/iomap.h                  |    1 +
 include/linux/syscalls.h               |    5 +
 include/uapi/linux/io_uring.h          |  115 ++
 kernel/sys_ni.c                        |    2 +
 19 files changed, 2173 insertions(+), 40 deletions(-)

-- 
Jens Axboe


--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
