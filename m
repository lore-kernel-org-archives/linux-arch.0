Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr730131.outbound.protection.outlook.com ([40.107.73.131]:10208
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfKTHQh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Nov 2019 02:16:37 -0500
From: Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2 0/2] Implement hv_is_hibernation_supported() and enhance hv_balloon for hibernation
Date: Tue, 19 Nov 2019 23:16:03 -0800
Message-ID: <1574234165-49066-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Content-Type: text/plain
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, mikelley@microsoft.com, david@redhat.com, arnd@arndb.de, bp@alien8.de, daniel.lezcano@linaro.org, hpa@zytor.com, mingo@redhat.com, tglx@linutronix.de, x86@kernel.org, Alexander.Levin@microsoft.com, vkuznets@redhat.com
Cc: linux-arch@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Message-ID: <20191120071603.MboqFHZVebUo9fmX1yS21VQZiLFd5vlI58Fbs77WDZ8@z>

v2 is actually the same as v1. This is just a resend.

I suggest both the patches should go through the Hyper-V tree:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next
because the first patch is needed by the second one.

This first patch doesn't conflict with any patch in the tip.git tree.

Dexuan Cui (2):
  x86/hyperv: Implement hv_is_hibernation_supported()
  hv_balloon: Add the support of hibernation

 arch/x86/hyperv/hv_init.c      |  7 +++
 drivers/hv/hv_balloon.c        | 87 +++++++++++++++++++++++++++++++++-
 include/asm-generic/mshyperv.h |  2 +
 3 files changed, 94 insertions(+), 2 deletions(-)

-- 
2.19.1
