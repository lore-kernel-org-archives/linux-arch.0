From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/6] syscalls: use uaccess_kernel in addr_limit_user_check
Date: Mon, 20 Jul 2020 07:55:43 -0700
Message-ID: <c6099697-5ccd-22b4-f5cb-cbe1c14644a9@roeck-us.net>
References: <20200714105505.935079-1-hch@lst.de>
 <20200714105505.935079-2-hch@lst.de> <20200718013849.GA157764@roeck-us.net>
 <20200718094846.GA8593@lst.de>
 <fe1d4a6d-e32d-6994-a08b-40134000e988@roeck-us.net>
 <20200720100104.GA20196@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGTOzp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2020 10:55:45 -0400
In-Reply-To: <20200720100104.GA20196@lst.de>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>, linux-arm-kernel@lists.infradead.org, Peter Maydell <peter.maydell@linaro.org>

On 7/20/20 3:01 AM, Christoph Hellwig wrote:
> To try to reproduce your report I built a mps2_defconfig kernel
> and then run the qemu command line manually extraced from your
> script below, using a mainline qemu built for arm-softmmu, but it
> crashes with the following message even for the baseline kernel.
> 
> qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)
> 
> R00=00000000 R01=00000000 R02=00000000 R03=00000000
> R04=00000000 R05=00000000 R06=00000000 R07=00000000
> R08=00000000 R09=00000000 R10=00000000 R11=00000000
> R12=00000000 R13=ffffffe0 R14=fffffff9 R15=00000000
> XPSR=40000003 -Z-- A handler
> FPSCR: 00000000
> 
> Does anyone have an idea what this means?
> 

Ah, sorry, you can't use the upstream version of qemu to test mps2-an385
Linux images. You'll have to use a version from https://github.com/groeck/qemu.
I'd recommend to use the v5.0.0-local branch.

I had to make some changes to qemu to be able to boot mps2-an385.
I tried to submit those changes into upstream qemu, but that was
rejected because, as I was told, the qemu implementation
would no longer reflect the real hardware with those changes in
place.

Guenter
