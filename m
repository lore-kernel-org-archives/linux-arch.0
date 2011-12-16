From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/4 V7] Avoid soft lockup message when KVM is stopped by host
Date: Fri, 16 Dec 2011 16:08:57 +0000
Message-ID: <201112161608.57532.arnd@arndb.de>
References: <1323978126-13222-1-git-send-email-emunson@mgebm.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:58666 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab1LPQJK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Dec 2011 11:09:10 -0500
In-Reply-To: <1323978126-13222-1-git-send-email-emunson@mgebm.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@mgebm.net>
Cc: avi@redhat.com, mingo@redhat.com, hpa@zytor.com, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, mtosatti@redhat.com, jeremy.fitzhardinge@citrix.com, levinsasha928@gmail.com, Jan Kiszka <jan.kiszka@siemens.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Thursday 15 December 2011, Eric B Munson wrote:
>  Documentation/virtual/kvm/api.txt   |   12 ++++++++++++
>  arch/ia64/include/asm/kvm_para.h    |    5 +++++
>  arch/powerpc/include/asm/kvm_para.h |    5 +++++
>  arch/s390/include/asm/kvm_para.h    |    5 +++++
>  arch/x86/include/asm/kvm_host.h     |    2 ++
>  arch/x86/include/asm/kvm_para.h     |    8 ++++++++
>  arch/x86/include/asm/pvclock-abi.h  |    1 +
>  arch/x86/kernel/kvmclock.c          |   21 +++++++++++++++++++++
>  arch/x86/kvm/x86.c                  |   20 ++++++++++++++++++++
>  include/asm-generic/kvm_para.h      |   14 ++++++++++++++
>  include/linux/kvm.h                 |    2 ++
>  kernel/watchdog.c                   |   12 ++++++++++++
>  12 files changed, 107 insertions(+), 0 deletions(-)
>  create mode 100644 include/asm-generic/kvm_para.h

asm-generic changes Acked-by: Arnd Bergmann <arnd@arndb.de>

but please remove me from the cc-list for the other patches.

	Arnd
