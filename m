Return-Path: <jakub@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:10928 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263740AbUDPVI1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 16 Apr 2004 17:08:27 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i3GL8RJW011712
	for <linux-arch@vger.kernel.org>; Fri, 16 Apr 2004 17:08:27 -0400
Date: Fri, 16 Apr 2004 17:08:03 -0400
From: Jakub Jelinek <jakub@redhat.com>
Subject: Unexpected syscalls on 64-bit arches
Message-ID: <20040416210802.GU31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-arch@vger.kernel.org
Cc: drepper@redhat.com
List-ID: <linux-arch.vger.kernel.org>

Hi!

While updating our glibc-kernheaders asm*/unistd.h tables, I have noticed
a bunch of syscalls which IMHO should have never been added:

asm-ia64/unistd.h:
#define __NR_fstatfs64                  1257
#define __NR_statfs64                   1258
asm-ppc64/unistd.h:
#define __NR_statfs64           252
#define __NR_fstatfs64          253
#define __NR_fadvise64_64       254
asm-s390/unistd.h:
#define __NR_statfs64           265
#define __NR_fstatfs64          266
but doesn't have
#undef __NR_statfs64
and
#undef __NR_fstatfs64
in the __s390x__ section
asm-sparc64/unistd.h:
#define __NR_statfs64           234 /* Linux Specific                              */
#define __NR_fstatfs64          235 /* Linux Specific                              */
#define __NR_fadvise64_64       210 /* Linux Specific                              */

On all these arches, struct statfs and struct statfs64 are identical,
thus __NR_statfs64 is a dup of __NR_statfs and __NR_fstatfs64 is a dup of
__NR_fstatfs.
Similarly, __NR_fadvise64_64 is a dup of __NR_fadvise64_64.

At least from glibc's point of view, these syscalls will never be used
on 64-bit arches, so IMHO they should be at least killed from the
unistd.h headers to avoid confusion and maybe nuked from the syscall tables
as well.

	Jakub
