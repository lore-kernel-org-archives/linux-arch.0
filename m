From: ltykernel@gmail.com
Subject: [PATCH V4 0/6] x86/Hyper-V: Panic code path fixes
Date: Mon,  6 Apr 2020 08:53:25 -0700
Message-ID: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37659 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgDFPxg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Apr 2020 11:53:36 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, michael.h.kelley@microsoft.com
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, vkuznets@redhat.com

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

This patchset fixes some issues in the Hyper-V panic code path.
Patch 1 resolves issue that panic system still responses network
packets.
Patch 2-3,5-6 resolves crash enlightenment issues.
Patch 4 is to set crash_kexec_post_notifiers to true for Hyper-V
VM in order to report crash data or kmsg to host before running
kdump kernel.

Tianyu Lan (6):
  x86/Hyper-V: Unload vmbus channel in hv panic callback
  x86/Hyper-V: Free hv_panic_page when fail to register kmsg dump
  x86/Hyper-V: Trigger crash enlightenment only once during
    0;136;0c0;136;0c system crash.
  x86/Hyper-V: Report crash register data or kmsg before  running crash
    kernel
  x86/Hyper-V: Report crash register data when sysctl_record_panic_msg
    is not set
  x86/Hyper-V: Report crash data in die() when panic_on_oops is set

 arch/x86/hyperv/hv_init.c      |  6 +++-
 arch/x86/kernel/cpu/mshyperv.c | 10 +++++++
 drivers/hv/channel_mgmt.c      |  3 ++
 drivers/hv/vmbus_drv.c         | 62 ++++++++++++++++++++++++++++++------------
 include/asm-generic/mshyperv.h |  2 +-
 5 files changed, 63 insertions(+), 20 deletions(-)

-- 
2.14.5
