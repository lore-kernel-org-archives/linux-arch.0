Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ADABA3D;
	Sat, 20 Jun 2026 03:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781924736; cv=none; b=dkMcBLlt4ly2MCldMWUhQccDvf67/Hfvx+aROUaTK0ubQiIfRWtGQp0vC4J08kSP3RO7368DVddwe/w8KZqUFMpOum1Q3ORF4Ic5m/oat2r4dd/uxBsHF7yP2WQjA+y/2mnORx62tLK3oAZiU9MGU69YdfTpsw2n0PH/hS2NZ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781924736; c=relaxed/simple;
	bh=t4raIeO8bUulaw+gjqzav7MK1qnu8Ublgh34VdjjrS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TiSJHhui6FZibT7jNZTp7g6jJWboVFgKkEr465L3D0ASb19ewzEgyEy6aqN10BZg57jIQasyRAh/28jlgk3t9r55icyqhKlZdnlfR7wnCsD0iFLYhxua548tNm7rQ1sZbMwrZRXXILR/DBGME95tFdB1SewyHOUWV1zlnFShjD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=n+r4iYPB; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="n+r4iYPB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=uS4QmL8znGKvVQwTwtA0SsKOy3t/cx7+36b2MDv6IPI=;
	b=n+r4iYPB5gpmA9AU1pnoRExcUmrPrtehzWnttnlVskB22qWiGPIWAmRIYZOyW+
	rgDhDQo0L6fE8uWkKJkS1p9LLpvQ3RrQVTmWoM6HOl5kjw+qnJzNcNR9mHY943Mk
	oazbjheTR68fCtUU33euCrUPXAOtQtolbDrgU92TJV9wg=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCHOQE0AzZqwKl0DQ--.63564S2;
	Sat, 20 Jun 2026 11:04:21 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: mjguzik@gmail.com
Cc: alex.aring@gmail.com,
	allen.lkml@gmail.com,
	arnd@arndb.de,
	brauner@kernel.org,
	chuck.lever@oracle.com,
	ebiederm@xmission.com,
	j.granados@samsung.com,
	jack@suse.cz,
	jackzxcui1989@163.com,
	jlayton@kernel.org,
	keescook@chromium.org,
	linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcgrof@kernel.org,
	pfalcato@suse.de,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3] coredump: exit_files() in coredump_wait() if MMF_DUMP_MAPPED_SHARED is not set
Date: Sat, 20 Jun 2026 11:04:20 +0800
Message-Id: <20260620030420.252025-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <jt7glnz6scdbnbzzl7l3slvnu4vtr2uzlbwe74znxp3sxeqdtc@dhrwwjhhn6md>
References: <jt7glnz6scdbnbzzl7l3slvnu4vtr2uzlbwe74znxp3sxeqdtc@dhrwwjhhn6md>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCHOQE0AzZqwKl0DQ--.63564S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF1UXF4DWF1kGw4UKF1xXwb_yoW5uw4fpF
	4Dua4Ykr4kGayUXr40yr90kF1rZws7Gr1DWryjga4qvr13XFWxKF4xt3y5ZF18Xrs7Wan5
	uFWDZw1YkrnrZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR9SdhUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCwBb1AGo2AzZ62AAA3o

On Fri, 19 Jun 2026 19:33:16 +0200 Mateusz Guzik <mjguzik@gmail.com> wrote:

> The claim is the coredump takes "some time" without specifying what kind
> of window is it (seconds, minutes?), nor where said time is spent.
> 
> For example it is known that a big mmapped areas are slow to dump even
> if they are sparsely populated.
> 
> So I would suggest profiling what exactly happens in this case. It is
> virtually guaranteed the time can be shortened, but it is plausible even
> with fixups it will be too long.

I test it by running the first testflock, wait until it output
'get flock success' and then run the second testflock.
testflock will send signal 6 to trigger coredump to the first testflock.
The second flock wait 11 seconds to get the flock. (it may wait less time
if I do not polling get the flock--add sleep in the while loop, as the two
testflock function is run by ssh, and they share the same cpu), but still
wait a long time(about 5 seconds).

./testflock
get flock success!
Aborted (core dumped)

./testflock
get flock fail!
lock_pid=8724
get flock success!
waitms=11443


The testflock program（the test program only use 500MB heap memory, the
memory used by other business processes will exceed this value）:

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/file.h>
#include <errno.h>
#include <time.h>
#include <signal.h>
#include <sys/syscall.h>

static inline long get_msec(void)
{
    struct timespec ts;

    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec * 1000 + ts.tv_nsec / 1000000;
}

#ifndef F_GETFD_EX
#define F_GETFD_EX	18
#endif

#ifndef F_SETFD_EX
#define F_SETFD_EX	19
#endif

#define FD_CLOBCOR	2

int main(int argc, char *argv[])
{
    size_t size_mb = 512;
	size_t size, i;
    long start = 0, stop;
    int mode = 1;

    const char *dir = "/map/zhaoxin/flock_tmp";
    int fd;
    int ret;
    char *buf;

    if (argc == 2 && strcmp(argv[1], "0") == 0) {
        printf("Do not send signal when fail!\n");
        mode = 0;
    }

    size = size_mb * 1024 * 1024;
    buf = (char*)malloc(size);
	if (!buf) {
		perror("malloc 失败");
		return 1;
	}
    for (i = 0; i < size; i++) {
        buf[i] = (char)i;
    }

    /* 打开目录，需要读权限 */
    fd = open(dir, O_CREAT | O_RDWR, 0777);
    if (fd < 0) {
        perror("open");
        exit(EXIT_FAILURE);
    }
    int setfd_ex_ret = fcntl(fd, F_SETFD_EX, FD_CLOBCOR);

    struct flock fl;
    fl.l_type = F_WRLCK;
    fl.l_whence = SEEK_SET;
    fl.l_start = 0;
    fl.l_len = 0;

    bool brunonce = false;
    int lastresult;

    int lock_pid = 0;

    while (1) {
        int result = fcntl(fd, F_SETLK, &fl);
        if (errno == EBADF || errno == EINVAL) {
          printf("errno=%d\n", errno);
          return -1;
        }
        if (!brunonce) {
            brunonce = true;
            // let lastresult differ from result
            lastresult = result + 1;
        }
        if (lastresult != result) {
            if (result == 0) {
                printf("get flock success!\n");
                if (start) {
                    stop = get_msec();
                    printf("waitms=%ld\n", stop - start);
                }
                while (1) {
                    sleep(1000);
                }
            }
            lastresult = result;
            if (errno == EAGAIN || errno == EACCES) {
                printf("get flock fail!\n");
                struct flock lock;
                (void)memset(&lock, 0, sizeof(lock));
                lock.l_type = F_WRLCK;
                lock.l_whence = SEEK_SET;
                lock.l_start = 0;
                lock.l_len = 0;
                if (fcntl(fd, F_GETLK, &lock) == 0) {
                    if (lock.l_type != F_UNLCK) {
                        lock_pid = lock.l_pid;

                        start = get_msec();

                        if (mode) {
                            int ret = syscall(SYS_tgkill, lock_pid, lock_pid, SIGABRT);
                        }
                        
                    }
                    printf("lock_pid=%d\n", lock_pid);
                }
            }
        }
    }

    return 0;
}

Thanks
Xin Zhao

