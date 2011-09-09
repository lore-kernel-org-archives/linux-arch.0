Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:9259 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757322Ab1IIBKm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Sep 2011 21:10:42 -0400
Message-ID: <20110909010847.294039464@codeaurora.org>
Date: Thu, 08 Sep 2011 20:08:47 -0500
From: Richard Kuo <rkuo@codeaurora.org>
Subject: [patch v3 00/36] Hexagon: Add support for Qualcomm Hexagon architecture
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20110909010847.cY50FwROqsrBhwlfL9l539viVmqjMgVaiWEeeK4qOhM@z>

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
