From: Mark Salter <msalter@redhat.com>
Subject: possible problem with generic asm/types.h
Date: Sat, 25 May 2013 11:14:18 -0400
Message-ID: <1369494858.25297.58.camel@t520.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:64802 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756762Ab3EYPO2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 25 May 2013 11:14:28 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, catalin.marinas@arm.com

While building some stuff for aarch64, I ran into a conflict between
the kernel's definition of __s64 and glibc's definition of int64_t.
The package I was building (fuse) does this:

  #include <stdint.h>
  #define __s64 int64_t

The kernel typedefs __s64 in asm/types.h and due to ordering of includes
in the fuse package sources, the kernel __s64 gets used at some points
while the fuse __s64 gets used in others. This leads to a build failure
on aarch64 because glibc typedefs int64_t as a long while kernel uses
long long for __s64. Both are 64bits but it creates a type conflict in
some of the fuse code. But this same fuse code builds on other arches so
I looked a further and found what I think is a problem with the kernel's
asm-generic/types.h file which has:

    /*
     * int-ll64 is used practically everywhere now,
     * so use it as a reasonable default.
     */
    #include <asm-generic/int-ll64.h>

Shouldn't this be:

    #include <asm/bitsperlong.h>
    #if __BITS_PER_LONG == 64
    #include <asm-generic/int-l64.h>
    #else
    #include <asm-generic/int-ll64.h>
    #endif

--Mark
