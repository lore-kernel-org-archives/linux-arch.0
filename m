Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:49233 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfCDAsJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 3 Mar 2019 19:48:09 -0500
In-Reply-To: <1546441324-19774-2-git-send-email-firoz.khan@linaro.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/2] powerpc: remove nargs from __SYSCALL
Message-ID: <44CLwk4pdDz9s6w@ozlabs.org>
Date: Mon,  4 Mar 2019 11:48:06 +1100 (AEDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Al Viro <viro@zeniv.linux.org.uk>, linuxppc-dev@lists.ozlabs.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org, deepa.kernel@gmail.com
Message-ID: <20190304004806.73kQPo927AM56PhGIzzhnxuk4dif1u4RDPybfQsZvWM@z>

On Wed, 2019-01-02 at 15:02:03 UTC, Firoz Khan wrote:
> The __SYSCALL macro's arguments are system call number,
> system call entry name and number of arguments for the
> system call.
> 
> Argument- nargs in __SYSCALL(nr, entry, nargs) is neither
> calculated nor used anywhere. So it would be better to
> keep the implementaion as  __SYSCALL(nr, entry). This will
> unifies the implementation with some other architetures
> too.
> 
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6b1200facc051a3e487a52cbabd745f7

cheers
