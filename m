Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:48796 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfKZTQA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2019 14:16:00 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Nov 2019 13:15:23 -0600
Message-ID: <8736eaxxdg.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: new uses of SYSCTL_SYSCALL
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org


Doing a test merge against linux-next I see that in the
tree git://github.com/jcmvbkbc/linux-xtensa.git#xtensa-for-next
a new defconfig is added:

arch/xtensa/configs/xip_kc705_defconfig

That defconfig adds CONFIG_SYSCTL_SYSCALL.

Is xtensa actually using this system call?  So far I have not seen any
other users and I am serously proposing to remove it. 

Eric
