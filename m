From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v10 00/19] Re-introduce h8300 architecture
Date: Mon, 4 May 2015 19:27:00 -0700
Message-ID: <20150505022700.GA26383@roeck-us.net>
References: <1430736122-20929-2-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49566 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755014AbbEEC1O (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2015 22:27:14 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YpSZl-0037Lq-IE
	for linux-arch@vger.kernel.org; Tue, 05 May 2015 02:27:13 +0000
Content-Disposition: inline
In-Reply-To: <1430736122-20929-2-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, May 04, 2015 at 07:41:43PM +0900, Yoshinori Sato wrote:
> Hello.
> I will re-introducing h8300.
> 

Hi,

With "make ARCH=h8300 edosk2674_defconfig; make ARCH=h8300",
I see the following build error:

scripts/Makefile.build:44: arch/h8300/boot/dtb/Makefile: No such file or directory
make[1]: *** No rule to make target 'arch/h8300/boot/dtb/Makefile'.  Stop.

After fixing this up with

diff --git a/arch/h8300/Makefile b/arch/h8300/Makefile
index c2b24c9..f547870 100644
--- a/arch/h8300/Makefile
+++ b/arch/h8300/Makefile
@@ -26,7 +26,7 @@ CROSS_COMPILE := h8300-unknown-linux-

 core-y += arch/$(ARCH)/kernel/ arch/$(ARCH)/mm/ arch/h8300/boot/dts/
 ifneq '$(CONFIG_H8300_BUILTIN_DTB)' '""'
-core-y += arch/h8300/boot/dtb/
+core-y += arch/h8300/boot/dts/
 endif
     
 libs-y += arch/$(ARCH)/lib/

I get

arch/h8300/boot/dts/built-in.o: In function `__dtb_edosk2674_end':
(.dtb.init.rodata+0x8fb): multiple definition of `__dtb_edosk2674_end'
arch/h8300/boot/dts/built-in.o:(.dtb.init.rodata+0x8fb): first defined here
arch/h8300/boot/dts/built-in.o: In function `__dtb_edosk2674_begin':
(.dtb.init.rodata+0x0): multiple definition of `__dtb_edosk2674_begin'
arch/h8300/boot/dts/built-in.o:(.dtb.init.rodata+0x0): first defined here
Makefile:932: recipe for target 'vmlinux' failed

This is with compiler and binutils built as you had provided earlier.

---

Other configurations fail to build with

h8300-unknown-linux-ld: cannot find arch/h8300/boot/dts/built-in.o: No such file or directory
Makefile:932: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

---

Switching from edosk2674_defconfig to h8300h-sim_defconfig without "make
mrproper" results in:

h8300-unknown-linux-ld: h8300s architecture of input file
`arch/h8300/boot/dts/built-in.o' is incompatible with h8300h output

---

Results are with git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git,
branch h8300.

Guenter
