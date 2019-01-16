From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCHSET v5] io_uring IO interface
Date: Wed, 16 Jan 2019 10:49:48 -0700
Message-ID: <20190116175003.17880-1-axboe@kernel.dk>
Return-path: <owner-linux-aio@kvack.org>
Sender: owner-linux-aio@kvack.org
To: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc: hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
List-Id: linux-arch.vger.kernel.org

Here's v5 of the io_uring interface. Mostly feels like putting some
finishing touches on top of v4, though we do have a few user interface
tweaks because of that.

Arnd was kind enough to review the code with an eye towards 32-bit
compatability, and that resulted in a few changes. See changelog below.

I also cleaned up the internal ring handling, enabling us to batch
writes to the SQ ring head and CQ ring tail. This reduces the number of
write ordering barriers we need.

I also dumped the io_submit_state intermediate poll list handling. This
drops a patch, and also cleans up the block flush handling since we no
longer have to tie into the deep internal of plug callbacks. The win of
this just wasn't enough to warrant the complexity.

LWN did a great write up of the API and internals, see that here:

https://lwn.net/Articles/776703/

In terms of benchmarks, I ran some numbers comparing io_uring to libaio
and spdk. The tldr is that io_uring is pretty close to spdk, in some
cases faster. Latencies over spdk are generally better. The areas where
we are still missing a bit of performance all lie in the block layer,
and I'll be working on that to close the gap some more.

Latency tests, 3d xpoint, 4k random read

Interface	QD	Polled		Latency		IOPS
--------------------------------------------------------------------------
io_uring	1	0		 9.5usec	 77K
io_uring	2	0		 8.2usec	183K
io_uring	4	0		 8.4usec	383K
io_uring	8	0		13.3usec	449K

libaio		1	0		 9.7usec	 74K
libaio		2	0		 8.5usec	181K
libaio		4	0		 8.5usec	373K
libaio		8	0		15.4usec	402K

io_uring	1	1		 6.1usec	139K
io_uring	2	1		 6.1usec	272K	
io_uring	4	1		 6.3usec	519K
io_uring	8	1		11.5usec	592K

spdk		1	1		 6.1usec	151K
spdk		2	1		 6.2usec	293K
spdk		4	1		 6.7usec	536K
spdk		8	1		12.6usec	586K

io_uring vs libaio, non polled, io_uring has a slight lead. spdk
slightly faster over io_uring polled, especially a lower queue depths.
At QD=8, io_uring is faster.


Peak IOPS, 512b random read

Interface	QD	Polled		Latency		IOPS
--------------------------------------------------------------------------
io_uring	4	1		 6.8usec	 513K
io_uring	8	1		 8.7usec	 829K
io_uring	16	1		13.1usec	1019K
io_uring	32	1		20.6usec	1161K
io_uring	64	1		32.4usec	1244K

spdk		4	1		 6.8usec	 549K
spdk		8	1		 8.6usec	 865K
spdk		16	1		14.0usec	1105K
spdk		32	1		25.0usec	1227K
spdk		64	1		47.3usec	1251K

io_uring lags spdk about 7% at lower queue depths, getting to within 1%
of spdk at higher queue depths.


Peak per-core, multiple devices, 4k random read

Interface	QD	Polled		IOPS
--------------------------------------------------------------------------
io_uring	128	1		1620K

libaio		128	0		 608K

spdk		128	1		1739K

This is using multiple devices, all running on the same core, meant to
test how much performance we can eke out out a single CPU core. spdk has
a slight edge over io_uring, with libaio not able to compete at all.

As usual, patches are against 5.0-rc2, and can also be found in my
io_uring branch here:


git://git.kernel.dk/linux-block io_uring


Since v4:
- Update some commit messages
- Update some stale comments
- Tweak polling efficiency
- Avoid multiple SQ/CQ ring inc+barriers for batches of IO
- Cache SQ head and CQ tail in the kernel
- Fix buffered rw/work union issue for punted IO
- Drop submit state request issue cache
- Rework io_uring_register() for buffers and files to be more 32-bit
  friendly
- Make sqe->addr an __u64 instead of playing padding tricks
- Add compat conditional syscall entry for io_uring_setup()


 Documentation/filesystems/vfs.txt      |    3 +
 arch/x86/entry/syscalls/syscall_32.tbl |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    3 +
 block/bio.c                            |   59 +-
 fs/Makefile                            |    1 +
 fs/block_dev.c                         |   19 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |    9 +-
 fs/gfs2/file.c                         |    2 +
 fs/io_uring.c                          | 2017 ++++++++++++++++++++++++
 fs/iomap.c                             |   48 +-
 fs/xfs/xfs_file.c                      |    1 +
 include/linux/bio.h                    |   14 +
 include/linux/blk_types.h              |    1 +
 include/linux/file.h                   |    2 +
 include/linux/fs.h                     |    6 +-
 include/linux/iomap.h                  |    1 +
 include/linux/sched/user.h             |    2 +-
 include/linux/syscalls.h               |    7 +
 include/uapi/linux/io_uring.h          |  136 ++
 init/Kconfig                           |    9 +
 kernel/sys_ni.c                        |    4 +
 22 files changed, 2322 insertions(+), 40 deletions(-)

-- 
Jens Axboe


--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
