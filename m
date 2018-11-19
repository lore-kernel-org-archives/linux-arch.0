Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:60252 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeKSNV1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Nov 2018 08:21:27 -0500
Date: Sun, 18 Nov 2018 18:59:13 -0800 (PST)
Message-ID: <20181118.185913.65989390344960294.davem@davemloft.net>
Subject: Re: [PATCH v3 0/4] sparc: system call table generation support
From: David Miller <davem@davemloft.net>
In-Reply-To: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org>
References: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: firoz.khan@linaro.org
Cc: sparclinux@vger.kernel.org, geert@linux-m68k.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de, kstewart@linuxfoundation.org, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
Message-ID: <20181119025913.IMZIR7tlAHF_1UfwUfIvfdUXtSbQ7QQWWGIkRx7AxqQ@z>

From: Firoz Khan <firoz.khan@linaro.org>
Date: Wed, 14 Nov 2018 10:56:27 +0530

> The purpose of this patch series is, we can easily
> add/modify/delete system call table support by cha-
> nging entry in syscall.tbl file instead of manually
> changing many files. The other goal is to unify the 
> system call table generation support implementation 
> across all the architectures. 
 ...

Series applied to sparc-next.
