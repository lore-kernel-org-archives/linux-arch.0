From: =?us-ascii?Q?Michal=20Simek?= <Monstr@seznam.cz>
Subject: =?us-ascii?Q?Re=3A=20microblaze=5Fv5=3A=20Status=20message?=
Date: Tue, 08 Jul 2008 21:43:12 +0200 (CEST)
Message-ID: <4550.7361-27429-1211674422-1215546192@seznam.cz>
References: <1215518398-5057-1-git-send-email-monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mxl.seznam.cz ([77.75.72.44]:60011 "EHLO mxl.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753036AbYGHToQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 8 Jul 2008 15:44:16 -0400
In-Reply-To: <1215518398-5057-1-git-send-email-monstr@monstr.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@monstr.eu
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk, hpa@zytor.com, lethal@linux-sh.org, florian@openwrt.org

Hi All,

I found the next two issues which are not in this pack. 
First one is removing kvm.h from asm-microblaze 
and second one is bad number of syscalls in unistd.h
I fixed it in my repo. Please do not report these two bugs.

Thanks,
Michal


Hi All,

here is microblaze_v5 set of patches with initial port
for Microblaze CPU. I did some changes which was reported
to me. Please check your reported changes if there are in the pack.

The patches are also available at git.monstr.eu. (linux-microblaze.git
 master branch).

I got ACK from Steve Neuendorffer (xilinx guy) for this pack.

Changes in v5 pack:
      Add new dts v1 file
      clean autoconf.h and remove a.out.h
      remove internal.h library
      fix headers - add one definition
      remove dependency on asm/semaphore.h
      Clean make headers_check dependency
      Fix Kconfig issue
      Remove macros DEFINE and BLANK from asm-offsets.c
      Move asm code from asm-generic checksum.h
      Clean process for enabling possibility to use smp with MB
      Clean platform folder to generic dts
      current config file
      Clean ptrace for generic use
      Clean cmdline handling
      Fix traps.c

Thanks for your comments and ACKs. I'll add them to patches.

Best regards,
Michal Simek
www.monstr.eu
