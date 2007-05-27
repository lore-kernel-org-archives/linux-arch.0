Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from alephnull.demon.nl ([83.160.184.112]:49574 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbXE0Wq1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 May 2007 18:46:27 -0400
Date: Mon, 28 May 2007 00:24:08 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [CFT] read+shared mmap write+read data corruption
Message-ID: <20070527222408.GA26268@xi.wantstofly.org>
References: <20070527104930.GB25023@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070527104930.GB25023@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, davej@codemonkey.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Sun, May 27, 2007 at 11:49:30AM +0100, Russell King wrote:

> So, if you have a cache which needs a flush_dcache_page()
> implementation, can you please grab:
> 
>   http://www.wantstofly.org/~buytenh/cache-issue.c

Davide Libenzi pointed out that there is an error in this program,
in that it doesn't lseek() back to the beginning of the file, so it
ends up reading bytes 16-31 instead.  *blush*

The program below accurately (AFAICT) reflects what fsx-linux does
just before it dies in this testcase.  It write(2)s to a file, reads
from the file via an mmap() region, read(2)s from the file, writes
to the file via an mmap() region, and finally, read(2)s from the file
again.  The last read(2) call returns the data written by the first
write(2) call, and doesn't see the data written by the mmap() write,
and so the last line of output is firstfirstfirst instead of the
expected secondsecondsec.

fsx-linux does call msync(), but it calls it with a third argument
of zero.  Changing the third msync() argument from 0 to MS_SYNC seems
to make the issue disappear, which makes me suspect that fsx-linux's
calling msync(pointer, size, 0); isn't guaranteed to be doing what it
expects it to be doing.

If it _is_ in fact a bug in fsx, it would seem that most of the 2615
fsx versions out there are affected.



#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

char *file = "footest";
char buf[4096];

int main()
{
	int fd;
	char *x;

	/* Clear test file.  */
	fd = open(file, O_CREAT | O_TRUNC | O_RDWR, 0644);
	write(fd, buf, sizeof(buf));
	close(fd);
	sleep(0);

	/* WRITE */
	fd = open(file, O_RDWR, 0644);
	write(fd, "firstfirstfirst\n", 16);
	close(fd);

	/* MAPREAD */
	fd = open(file, O_RDWR, 0644);
	x = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
	memcpy(buf, x, 16);
	munmap(x, 4096);
	close(fd);

	/* READ */
	fd = open(file, O_RDWR, 0644);
	read(fd, buf + 16, 16);
	close(fd);

	/* MAPWRITE */
	fd = open(file, O_RDWR, 0644);
	x = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
	memcpy(x, "secondsecondsec\n", 16);
	msync(x, 4096, 0);
	munmap(x, 4096);
	close(fd);

	/* READ */
	fd = open(file, O_RDWR, 0644);
	read(fd, buf + 32, 16);
	close(fd);

	/* dump output */
	write(1, buf, 3 * 16);

	return 0;
}
