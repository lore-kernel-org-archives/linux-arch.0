Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de ([212.227.126.176]:56030 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265202AbUETU4F (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 20 May 2004 16:56:05 -0400
Subject: =?iso-8859-1?Q?Re:_sys_getdents64_needs_compat_wrapper_??=
From: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>
Message-Id: <26879984$108508633440ad1a7e92a218.79906524@config19.schlund.de>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Thu, 20 May 2004 22:54:01 +0200
To: =?iso-8859-1?Q?Arun_Sharma?= <arun.sharma@intel.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Arun Sharma <arun.sharma@intel.com> schrieb am 20.05.2004, 20:32:23:
> 
> Running 32 bit ls on ia64 produces kernel mode unaligned faults
> with the attached backtrace on 2.6.6. I'm curious why this isn't a 
> problem for other compat archs.

At least s390x doesn't need 64 bit alignment for accessing 64 bit
variables. Other explanations could be
- 32 bit user space also needs 8 byte alignment for struct dirent64
- an architecture catches unaligned accesses only for user, not kernel
  space.
- put_user(u64...) handles unaligned access itself.

The attachment has an older (but so far untested) patch of mine
to consolidate the syscalls from fs/readdir.c. I have added a
compat_sys_getdents64() that uses __copy_to_user instead of
__put_user. Does that work for you or did you have something
different in mind?
Alternatively, that change could be done in sys_getdents64()
itself so you can use it for ia64 compat like the others do.

       Arnd <><
