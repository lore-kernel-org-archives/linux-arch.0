Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([206.83.70.75]:57143 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab1HZDCD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2011 23:02:03 -0400
Message-ID: <4E570B66.608@tilera.com>
Date: Thu, 25 Aug 2011 22:56:38 -0400
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
Subject: Re: __ARCH_WANT_SYSCALL_DEPRECATED
References: <20110822193602.GA23301@codeaurora.org> <2047151.mWElcT8jZQ@wuerfel> <1314151284.29738.34.camel@epip-laptop> <20110824152537.GA3993@codeaurora.org>
In-Reply-To: <20110824152537.GA3993@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Linas Vepstas (Code Aurora)" <linas@codeaurora.org>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, Arnd Bergmann <arnd@arndb.de>, GLIBC Devel <libc-alpha@sourceware.org>, Jonas Bonn <jonas.bonn@gmail.com>, libc-ports@sourceware.org, linux-hexagon@vger.kernel.org, linux-arch@vger.kernel.org, Mark Salter <msalter@redhat.com>, Tobias Klauser <tklauser@distanz.ch>
Message-ID: <20110826025638.JO2c2KAVZCLxhlQNZsnMbfT9COGcXeJTfxrGakqehvk@z>

On 8/24/2011 11:25 AM, Linas Vepstas (Code Aurora) wrote:
> On Wed, Aug 24, 2011 at 10:01:24AM +0800, Guan Xuetao wrote:
>>   For getdents (or other deprecated syscalls), we select getdents64 to
>> replace getdent, though we have not verified it on unicore32 platform.
> Do you have a publically-available version? Have you considered
> submitting it to the FSF?  Have you signed the copyright-transfer
> forms with the FSF?

I apologize for the slow-motion return of our glibc port to the community. 
We have a signed FSF copyright-transfer on file, which we've already used
for binutils, and gcc is in progress, but glibc is not quite at the top of
the stack yet.  It's the curse of being a small company with new features
to write, bugs to fix, and customers to keep happy :-)

Our 2.11.2 port is here:

http://www.tilera.com/scm/glibc-2.11.2.tar.bz2

Wwe are using 2.12 for our upcoming release, which is based around RHEL 6. 
We have not tried to return this to the community yet because there are
plenty of small cleanups to do: another pass through the code to make sure
there are no lingering minor issues, sync up to the git tip, check all the
code style issues, update copyrights, write changelogs, etc.

> My goal with the hexagon archiecture is to have the kernel asm/unistd.h
> include asm-generic/unistd.h, and have glibc compile (on hexagon) with
> no further #defines in asm/unistd.h.  This "almost" works today; with
> Chris Metcalf's generic syscall patches for glibc, I am able to compile
> glibc (and pass the glibc test suite). However, I have to #define
> __ARCH_WANT_SYSCALL_DEPRECATED to do this. If I don't, then the 
> getdents syscall fails to compile; I don't know how many others there are.

For getdents in particular, we use this patch:

--- sysdeps/unix/sysv/linux/getdents.c~        2010-05-04 07:27:23.000000000 -0400
+++ sysdeps/unix/sysv/linux/getdents.c  2010-10-12 14:28:47.026114000 -0400
@@ -236,6 +236,7 @@
 # endif
     }
 #endif
+#if !defined __NR_getdents64 || !defined __ASSUME_GETDENTS64_SYSCALL
   {
     size_t red_nbytes;
     struct kernel_dirent *skdp, *kdp;
@@ -295,4 +296,5 @@

     return (char *) dp - buf;
   }
+#endif
 }


> As to the "API": I just want to use Arnd's "generic" kernel support;
> that will be the API.  No changing, porting, hacking :-)

Indeed.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com

