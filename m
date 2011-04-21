From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Error in head-common.S file while ARM Linux booting
Date: Thu, 21 Apr 2011 16:22:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1104211614140.24613@xanadu.home>
References: <BANLkTi=rVF1r-3WpF+iBWMSgy46VnoVx=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_F9qtxyWg3KcoC6c5QAzsqA)"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:21089 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960Ab1DUUWt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 Apr 2011 16:22:49 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LK0009KTR91R960@vl-mh-mrz21.ip.videotron.ca> for
 linux-arch@vger.kernel.org; Thu, 21 Apr 2011 16:22:14 -0400 (EDT)
In-reply-to: <BANLkTi=rVF1r-3WpF+iBWMSgy46VnoVx=A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Madhavi Manchala <madhavi.linux@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_F9qtxyWg3KcoC6c5QAzsqA)
Content-type: TEXT/PLAIN; charset=windows-1252
Content-transfer-encoding: 8BIT

On Thu, 21 Apr 2011, Madhavi Manchala wrote:

> Dear All,
> 
> I have developed machine code for my Samsung S3C2510A MCU under Linux
> kernel 2.6.36. The code exists at arch/arm/mach-s3c2510a. I developed
> only CPU, UART and Clocks initialization code, especially. For
> developing the S3C2510A HAL code, I have gone through the existing
> mach-s3c2410 code.
> 
> I build vmlinux image on a Linux box in the ELF format for my Samsung
> MCU. Then, I am trying to load the build vmlinux image on to my
> device’s (targets) RAM area using J-link J-TAG and J-LinkGDBServer
> tool with a gdbinit script file from Cygwin on a Windows XP system.
> The gdb init script file initializes the CPU system configuration
> registers, RAM, Flash and UART registers and then loads ELF image.
> 
> I am able to put break points in the developed HAL code. However, when
> I run (continue) from gdb prompt, I did not see any break points in
> the GDB server tool, but, when I press “Ctrl+C”, I am seeing the
> following messages.
> 
> <gdb> break s3c2510a_init
> Breakpoint 1 at 0x3000b648: file arch/arm/mach-s3c2510a/s3c2510a.c, line 59.
> <gdb> c
> Continuing.
> 
> Pressing “control+c”, then the statements are as follows.
> 
> Program received signal SIGTRAP, Trace/Breakpoint trap.
> __error_p () at head-common.S:142
> 
> <gdb>bt
> #0 __error_p () at head-common.S:142
> 
> Why am I seeing these errors? Am I missing any CPU configuration, still?

Did you look at the actual code below __error_p in 
arch/arm/kernel/head-common.S?  The code even shows what could be 
displayed on your serial port when you have CONFIG_DEBUG_LL enabled.


Nicolas

--Boundary_(ID_F9qtxyWg3KcoC6c5QAzsqA)--
