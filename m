Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:46142 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeKBFhu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Nov 2018 01:37:50 -0400
Date: Thu, 01 Nov 2018 13:33:15 -0700 (PDT)
Message-ID: <20181101.133315.47887636039827313.davem@davemloft.net>
Subject: Re: [PATCH v2 3/4] sparc: add system call table generation support
From: David Miller <davem@davemloft.net>
In-Reply-To: <1541080391-3890-4-git-send-email-firoz.khan@linaro.org>
References: <1541080391-3890-1-git-send-email-firoz.khan@linaro.org>
        <1541080391-3890-4-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: firoz.khan@linaro.org
Cc: sparclinux@vger.kernel.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de, kstewart@linuxfoundation.org, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
Message-ID: <20181101203315.Ml9kC3-XJ5-t6m6J-zS5MAT7ZL3DI6kpSftV_B8a64A@z>

From: Firoz Khan <firoz.khan@linaro.org>
Date: Thu,  1 Nov 2018 19:23:10 +0530

> +141	common	getpeername		sys_getpeername			sys_nis_syscall
 ...
> +150	common	getsockname		sys_getsockname			sys_nis_syscall

The sys_nis_syscall in these two entries is incorrect, see the patch
below.

One of my worst fears about this change has been realized, that
instead of helping us find problems, it is so automated to the point
that it fails to question issues like this.

If sys_nis_syscall for the compat syscall shows up in a situation where the
native 32-bit syscall does have an entry, that's a BUG and the script should
point this out so that the bug can be fixed.

Thank you.

====================
