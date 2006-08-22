Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:60919 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932311AbWHVPNs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Aug 2006 11:13:48 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] introduce kernel_execve function to replace __KERNEL_SYSCALLS__
Date: Tue, 22 Aug 2006 17:13:39 +0200
References: <20060819073031.GA25711@atjola.homenet> <200608221207.00344.arnd@arndb.de> <20060822133945.GA3813@ccure.user-mode-linux.org>
In-Reply-To: <20060822133945.GA3813@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608221713.40165.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>
Cc: Bj?rn Steinbrink <B.Steinbrink@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tuesday 22 August 2006 15:39, Jeff Dike wrote:
> You're contemplating changing UML to do, e.g.
>         syscall(NR_write, fd, buf, len)
> instead of the current
>         write(fd, buf,len)
> ?
> 
> That hardly seems like an improvement and it seems fairly unnecessary.
> 
No, that's not what I was referring to. I was thinking of the calls:

arch/um/os-Linux/process.c:inline _syscall0(pid_t, getpid)
arch/um/os-Linux/sys-i386/tls.c:static _syscall1(int, get_thread_area, user_desc_t *, u_info);
arch/um/os-Linux/tls.c:static _syscall1(int, get_thread_area, user_desc_t *, u_info);
arch/um/os-Linux/tls.c:static _syscall1(int, set_thread_area, user_desc_t *, u_info);
arch/um/sys-i386/unmap.c:static inline _syscall2(int,munmap,void *,start,size_t,len)
arch/um/sys-i386/unmap.c:static inline _syscall6(void *,mmap2,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)
arch/um/sys-x86_64/unmap.c:static inline _syscall2(int,munmap,void *,start,size_t,len)
arch/um/sys-x86_64/unmap.c:static inline _syscall6(void *,mmap,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)

Are these for calling the host OS or calling the UML kernel?
If they are for the host, they can be implemented using syscall(),
otherwise by calling the sys_* functions directly.

	Arnd <><
