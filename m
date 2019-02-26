Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:48364 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbfBZAXE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Feb 2019 19:23:04 -0500
Date: Mon, 25 Feb 2019 16:23:00 -0800 (PST)
Message-ID: <20190225.162300.209654917842732349.davem@davemloft.net>
Subject: Re: [PATCH 0/3] sparc: Unify the system call scripts
From: David Miller <davem@davemloft.net>
In-Reply-To: <1546444373-21386-1-git-send-email-firoz.khan@linaro.org>
References: <1546444373-21386-1-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: firoz.khan@linaro.org
Cc: viro@zeniv.linux.org.uk, sparclinux@vger.kernel.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de, kstewart@linuxfoundation.org, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
Message-ID: <20190226002300.KxtGYPeStzdM4x9G8Wz2rg0CtfDZd9RY5Jc-FYnsr4U@z>

From: Firoz Khan <firoz.khan@linaro.org>
Date: Wed,  2 Jan 2019 21:22:50 +0530

> System call table generation support is provided for
> alpha, ia64, m68k, microblaze, mips, parisc, powerpc,
> sh, sparc and xtensa architectures. The implementat-
> ions are almost similar across all the above archte-
> ctures. In order to reduce the source code across all
> the above architectures, create common ".sh" files and
> keep it in the common directory, script/. This will 
> be a generic scripts which can use for all the above
> architectures.
> 
> This patch depends on;
>  https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/

Can you please merge this series in with that dependency
then?

Acked-by: David S. Miller <davem@davemloft.net>
