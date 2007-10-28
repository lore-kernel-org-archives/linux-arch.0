Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:53244 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbXJ1Ay5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 27 Oct 2007 20:54:57 -0400
Message-ID: <4723DDDD.8050900@zytor.com>
Date: Sat, 27 Oct 2007 17:54:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: struct user . u_ar0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

I recently noticed that all architectures appear to have an entry n 
struct user called u_ar0:

   struct user_pt_regs * u_ar0;  /* Used by gdb to help find the values 
for */
                                 /* the registers. */

In all cases, u_ar0 is a pointer type, although the type of pointer 
varies with the architecture.

However, under no conditions does this field ever contain a pointer 
value!  It is set by the a.out code and its derivatives as an offset, 
not a pointer value (there are a total of four references in the kernel, 
in arch/{m68k,blackfin}/kernel/process.c, arch/x86/ia32/ia32_aout.c and 
fs/binfmt_aout.c -- they are all functionally identical and write-only):

dump.u_ar0 = (void *)(((unsigned long)(&dump.regs)) - ((unsigned 
long)(&dump)));

Any reason to *NOT* change this field to "unsigned long"?  <asm/user.h>, 
where struct user is defined, is not exported to userspace in any 
architecture as far as I can tell, although <linux/user.h>, which just 
contains #include <asm/user.h>, *is* exported (clearly a bug.)

	-hpa


