From: Jens Axboe <axboe@kernel.dk>
Subject: (unknown)
Date: Mon, 14 Jan 2019 19:55:15 -0700
Message-ID: <20190115025531.13985-1-axboe@kernel.dk>
Return-path: <owner-linux-aio@kvack.org>
Subject: 
Sender: owner-linux-aio@kvack.org
To: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc: hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
List-Id: linux-arch.vger.kernel.org

Here's v4 of the io_uring interface. No user visible changes this
time, outside of bumping the io_uring_sqe submission entry to a
full 64-bytes. This aligns better with caches, and leaves us some
room to grow for future features. See the v3 posting for full
details on the API:

https://lore.kernel.org/linux-block/20190112213011.1439-1-axboe@kernel.dk/

What I neglected to mention in the v3 posting, is that the fixed
buffer and fixed file interfaces are available through the
io_uring_register() system call. This means they can be registered
(and unregistered) independently of the io_uring context setup.

Patches are against 5.0-rc2 and can also be found in my 'io_uring'
git branch:

git://git.kernel.dk/linux-block io_uring

Changes since v3:

- Clean up fixed buffer index validation
- Add IORING_OP_NOP for ring perf testing
- Drop struct io_kiocb ki_* variable prefix, it clashes with struct
  kiocb for no reason except to cause confusement
- Bump io_uring_sqe to 64 bytes. Cacheline sized and aligned
  (on x86-64), and more future proof
- Use kmalloc_array()
- Make the page mlock rlimit incremental and not for root / CAP_IPC_LOCK
- Ensure io_uring_register() can't race with fops->release()
- Simplify and improve iopoll implementation
- Use FOLL_WRITE instead of open-coding it
- Fix 32-bit vs 64-bit sizing for the io_uring_register() structs
- Added x86 32-bit system calls
- Added 32-bit compat mode
- Rebased on 5.0-rc2


 Documentation/filesystems/vfs.txt      |    3 +
 arch/x86/entry/syscalls/syscall_32.tbl |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    3 +
 block/bio.c                            |   59 +-
 fs/Makefile                            |    1 +
 fs/block_dev.c                         |   19 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |    9 +-
 fs/gfs2/file.c                         |    2 +
 fs/io_uring.c                          | 2072 ++++++++++++++++++++++++
 fs/iomap.c                             |   48 +-
 fs/xfs/xfs_file.c                      |    1 +
 include/linux/bio.h                    |   14 +
 include/linux/blk_types.h              |    1 +
 include/linux/file.h                   |    2 +
 include/linux/fs.h                     |    6 +-
 include/linux/iomap.h                  |    1 +
 include/linux/sched/user.h             |    2 +-
 include/linux/syscalls.h               |    7 +
 include/uapi/linux/io_uring.h          |  155 ++
 init/Kconfig                           |    9 +
 kernel/sys_ni.c                        |    3 +
 22 files changed, 2395 insertions(+), 40 deletions(-)

-- 
Jens Axboe


--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
