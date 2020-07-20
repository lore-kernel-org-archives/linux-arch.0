From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/6] syscalls: use uaccess_kernel in
 addr_limit_user_check
Date: Mon, 20 Jul 2020 12:01:04 +0200
Message-ID: <20200720100104.GA20196@lst.de>
References: <20200714105505.935079-1-hch@lst.de> <20200714105505.935079-2-hch@lst.de> <20200718013849.GA157764@roeck-us.net> <20200718094846.GA8593@lst.de> <fe1d4a6d-e32d-6994-a08b-40134000e988@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:46243 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgGTKBI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Jul 2020 06:01:08 -0400
Content-Disposition: inline
In-Reply-To: <fe1d4a6d-e32d-6994-a08b-40134000e988@roeck-us.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>, linux-arm-kernel@lists.infradead.org, Peter Maydell <peter.maydell@linaro.org>

To try to reproduce your report I built a mps2_defconfig kernel
and then run the qemu command line manually extraced from your
script below, using a mainline qemu built for arm-softmmu, but it
crashes with the following message even for the baseline kernel.

qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)

R00=00000000 R01=00000000 R02=00000000 R03=00000000
R04=00000000 R05=00000000 R06=00000000 R07=00000000
R08=00000000 R09=00000000 R10=00000000 R11=00000000
R12=00000000 R13=ffffffe0 R14=fffffff9 R15=00000000
XPSR=40000003 -Z-- A handler
FPSCR: 00000000

Does anyone have an idea what this means?


---
/opt/qemu/bin/qemu-system-arm \
	-M mps2-an385 \
	-cpu cortex-m3 \
	-dtb arch/arm/boot/dts/mps2-an385.dtb \
	-kernel vmlinux \
	-no-reboot \
        -snapshot -m 16 \
        -initrd ~/images/rootfs-arm-m3.cpio \
        -append 'panic=-1' \
	-bios ~/images/mps2-boot.axf \
	-nographic -monitor null -serial stdio
