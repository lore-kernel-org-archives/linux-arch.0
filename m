Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35021 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbfEULki (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 May 2019 07:40:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id t1so7045820pgc.2
        for <linux-arch@vger.kernel.org>; Tue, 21 May 2019 04:40:37 -0700 (PDT)
From: Christian Brauner <christian@brauner.io>
Subject: [PATCH 1/2] open: add close_range()
Date: Tue, 21 May 2019 13:34:47 +0200
Message-ID: <20190521113448.20654-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Cc: jannh@google.com, fweimer@redhat.com, oleg@redhat.com, tglx@linutronix.de, torvalds@linux-foundation.org, arnd@arndb.de, shuah@kernel.org, dhowells@redhat.com, tkjos@android.com, ldv@altlinux.org, miklos@szeredi.hu, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, x86@kernel.org, Christian Brauner <christian@brauner.io>
Message-ID: <20190521113447.x45tnCE6hWPql6oyocl2xnmeUD4YM0lFEYb93yX6ylQ@z>

This adds the close_range() syscall. It allows to efficiently close a range
of file descriptors up to all file descriptors of a calling task.

The syscall came up in a recent discussion around the new mount API and
making new file descriptor types cloexec by default. During this
discussion, Al suggested the close_range() syscall (cf. [1]). Note, a
syscall in this manner has been requested by various people over time.

First, it helps to close all file descriptors of an exec()ing task. This
can be done safely via (quoting Al's example from [1] verbatim):

        /* that exec is sensitive */
        unshare(CLONE_FILES);
        /* we don't want anything past stderr here */
        close_range(3, ~0U);
        execve(....);

The code snippet above is one way of working around the problem that file
descriptors are not cloexec by default. This is aggravated by the fact that
we can't just switch them over without massively regressing userspace. For
a whole class of programs having an in-kernel method of closing all file
descriptors is very helpful (e.g. demons, service managers, programming
language standard libraries, container managers etc.).
(Please note, unshare(CLONE_FILES) should only be needed if the calling
 task is multi-threaded and shares the file descriptor table with another
 thread in which case two threads could race with one thread allocating
 file descriptors and the other one closing them via close_range(). For the
 general case close_range() before the execve() is sufficient.)

Second, it allows userspace to avoid implementing closing all file
descriptors by parsing through /proc/<pid>/fd/* and calling close() on each
file descriptor. From looking at various large(ish) userspace code bases
this or similar patterns are very common in:
- service managers (cf. [4])
- libcs (cf. [6])
- container runtimes (cf. [5])
- programming language runtimes/standard libraries
  - Python (cf. [2])
  - Rust (cf. [7], [8])
As Dmitry pointed out there's even a long-standing glibc bug about missing
kernel support for this task (cf. [3]).
In addition, the syscall will also work for tasks that do not have procfs
mounted and on kernels that do not have procfs support compiled in. In such
situations the only way to make sure that all file descriptors are closed
is to call close() on each file descriptor up to UINT_MAX or RLIMIT_NOFILE,
OPEN_MAX trickery (cf. comment [8] on Rust).

The performance is striking. For good measure, comparing the following
simple close_all_fds() userspace implementation that is essentially just
glibc's version in [6]:

static int close_all_fds(void)
{
        DIR *dir;
        struct dirent *direntp;

        dir = opendir("/proc/self/fd");
        if (!dir)
                return -1;

        while ((direntp = readdir(dir))) {
                int fd;
                if (strcmp(direntp->d_name, ".") == 0)
                        continue;
                if (strcmp(direntp->d_name, "..") == 0)
                        continue;
                fd = atoi(direntp->d_name);
                if (fd == 0 || fd == 1 || fd == 2)
                        continue;
                close(fd);
        }

        closedir(dir); /* cannot fail */
        return 0;
}

to close_range() yields:
1. closing 4 open files:
   - close_all_fds(): ~280 us
   - close_range():    ~24 us

2. closing 1000 open files:
   - close_all_fds(): ~5000 us
   - close_range():   ~800 us

close_range() is designed to allow for some flexibility. Specifically, it
does not simply always close all open file descriptors of a task. Instead,
callers can specify an upper bound.
This is e.g. useful for scenarios where specific file descriptors are
created with well-known numbers that are supposed to be excluded from
getting closed.
For extra paranoia close_range() comes with a flags argument. This can e.g.
be used to implement extension. Once can imagine userspace wanting to stop
at the first error instead of ignoring errors under certain circumstances.
There might be other valid ideas in the future. In any case, a flag
argument doesn't hurt and keeps us on the safe side.
