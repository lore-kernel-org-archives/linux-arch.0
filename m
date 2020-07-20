From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/6] syscalls: use uaccess_kernel in addr_limit_user_check
Date: Mon, 20 Jul 2020 16:28:35 +0100
Message-ID: <CAFEAcA8=O6TbxYwmRwZJbcqFKi364=ueV_TsTu_84M5WFVtD8g@mail.gmail.com>
References: <20200714105505.935079-1-hch@lst.de> <20200714105505.935079-2-hch@lst.de>
 <20200718013849.GA157764@roeck-us.net> <20200718094846.GA8593@lst.de>
 <fe1d4a6d-e32d-6994-a08b-40134000e988@roeck-us.net> <20200720100104.GA20196@lst.de>
 <c6099697-5ccd-22b4-f5cb-cbe1c14644a9@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgGTP2r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2020 11:28:47 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B62C0619D2
        for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2020 08:28:46 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h1so12500158otq.12
        for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2020 08:28:46 -0700 (PDT)
In-Reply-To: <c6099697-5ccd-22b4-f5cb-cbe1c14644a9@roeck-us.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Vladimir Murzin <vladimir.murzin@arm.com>, arm-mail-list <linux-arm-kernel@lists.infradead.org>

On Mon, 20 Jul 2020 at 15:55, Guenter Roeck <linux@roeck-us.net> wrote:
> Ah, sorry, you can't use the upstream version of qemu to test mps2-an385
> Linux images. You'll have to use a version from https://github.com/groeck/qemu.
> I'd recommend to use the v5.0.0-local branch.
>
> I had to make some changes to qemu to be able to boot mps2-an385.
> I tried to submit those changes into upstream qemu, but that was
> rejected because, as I was told, the qemu implementation
> would no longer reflect the real hardware with those changes in
> place.

Yes; the rationale is that if you wanted to boot a kernel
on an actual MPS2 board you'd need a bit of guest code to
start it up (and to bundle the initrd/dtb in with it), so
since you need to write that code anyway you could use it for
booting the kernel in QEMU too.

I appreciate that this is awkward for kernel developers (and
perhaps for some other users too), but QEMU's handling of
-kernel and built-in-bootloader code is already a morass of
special cases and do-what-I-mean behaviour that I'm not
enthusiastic about further complicating :-)

(https://lists.gnu.org/archive/html/qemu-arm/2018-06/msg00393.html
has the archive of our original discussion on the point, for
other readers of this post interested in further context and
discussion.)

thanks
-- PMM
