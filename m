From: Richard Kuo <rkuo@codeaurora.org>
Subject: [patch v3 00/36] Hexagon: Add support for Qualcomm Hexagon architecture
Date: Thu, 08 Sep 2011 20:08:47 -0500
Message-ID: <20110909010847.294039464@codeaurora.org>
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This is the third version of the patchset to the Linux kernel to support
the Qualcomm Hexagon architecture.  These patches have been organized like
the last time, in a somewhat logically grouped fashion.

A summary of changes from the last patchset:
* removed __delay
* cleaned up checksum header to pull generic one
* implemented vDSO so signal trampolines are no longer on stack
* fixed cpu_idle()
* removed init_IRQ() wrapper
* cleaned up (most of) the wrongness in time.c
* cleaned up smp.c to use more generic IPI handlers
* filled in ins/outs routines in IO and other misc cleanup
* removed redundant vunmap from ioremap
* removed more highmem cruft
* moved rwsem to asm-generic
* bonus ifdefs added to generic checksum.h

Also, I have been compiling with sparse and it seems to pass.

These patches are available on Code Aurora:

https://www.codeaurora.org/patches/quic/hlk/hexagon-linux-20110908.tar.gz

Thanks again for everyone's feedback!

-Richard Kuo

-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
