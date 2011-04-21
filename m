From: Madhavi Manchala <madhavi.linux@gmail.com>
Subject: Error in head-common.S file while ARM Linux booting
Date: Thu, 21 Apr 2011 16:01:20 +0530
Message-ID: <BANLkTi=rVF1r-3WpF+iBWMSgy46VnoVx=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:33016 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab1DUKbW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 Apr 2011 06:31:22 -0400
Received: by qyk7 with SMTP id 7so2743300qyk.19
        for <linux-arch@vger.kernel.org>; Thu, 21 Apr 2011 03:31:22 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org

Dear All,

I have developed machine code for my Samsung S3C2510A MCU under Linux
kernel 2.6.36. The code exists at arch/arm/mach-s3c2510a. I developed
only CPU, UART and Clocks initialization code, especially. For
developing the S3C2510A HAL code, I have gone through the existing
mach-s3c2410 code.

I build vmlinux image on a Linux box in the ELF format for my Samsung
MCU. Then, I am trying to load the build vmlinux image on to my
device=92s (targets) RAM area using J-link J-TAG and J-LinkGDBServer
tool with a gdbinit script file from Cygwin on a Windows XP system.
The gdb init script file initializes the CPU system configuration
registers, RAM, Flash and UART registers and then loads ELF image.

I am able to put break points in the developed HAL code. However, when
I run (continue) from gdb prompt, I did not see any break points in
the GDB server tool, but, when I press =93Ctrl+C=94, I am seeing the
following messages.

<gdb> break s3c2510a_init
Breakpoint 1 at 0x3000b648: file arch/arm/mach-s3c2510a/s3c2510a.c, lin=
e 59.
<gdb> c
Continuing.

Pressing =93control+c=94, then the statements are as follows.

Program received signal SIGTRAP, Trace/Breakpoint trap.
__error_p () at head-common.S:142

<gdb>bt
#0 __error_p () at head-common.S:142

Why am I seeing these errors? Am I missing any CPU configuration, still=
?

=46YI: I build the kernel with debugging information enabled i.e. I set
CONFIG_DEBUG_KERNEL to y. I did not see any debug messages in the
hyper terminal.
I have gone through the following links. However, there are all based
on the 2.4.x kernel versions. I think, they are slightly different.
http://gicl.cs.drexel.edu/people/sevy/linux/ARM_Linux_boot_sequence.htm=
l
http://www.simtec.co.uk/products/SWLINUX/files/booting_article.html

Any hints/help/links would be appreciated.

Thanks and Regards,
Madhavi M.
