Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:56261 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731091AbfBRV7L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2019 16:59:11 -0500
Date: Mon, 18 Feb 2019 22:59:08 +0100
From: Hugo Lefeuvre <hle@owl.eu.com>
Subject: Re: [asm-generic:master 4/6] lib/iomap.c:198:48: warning: passing
 argument 1 of 'mmio_insb' discards 'const' qualifier from pointer target
 type
Message-ID: <20190218215908.GC18457@behemoth.owl.eu.com.local>
References: <201902190215.BuNxMvI2%fengguang.wu@intel.com>
 <CAK8P3a3fs=pcQBcB+sGFfuK-pQ-a6du-rJ_VQiyv1_FK2LW2oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3fs=pcQBcB+sGFfuK-pQ-a6du-rJ_VQiyv1_FK2LW2oA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, linux-arch <linux-arch@vger.kernel.org>

> It seems to be a result of applying the patches in the wrong order, in
> particular
> 'iomap: add missing const to ioread*/iowrite addr arg' before 'lib/iomap: add
> missing const to mmio_ins* addr arg'. I've swapped them around now
> and uploaded the new branch.
> 
> Hugo, could you check
> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
> that it still makes sense to you?

Agree. However the first error will require an additional patch. ioread()
definitions from arch/ almost always omit the const[0], leading to
conflicting types...

I guess we should just add the missing const to arch/ definitions. The
patch is very simple anyways... Should I submit it separately or update the
applied patch set?

[0] https://elixir.bootlin.com/linux/latest/ident/ioread32

-- 
                Hugo Lefeuvre (hle)    |    www.owl.eu.com
RSA4096_ 360B 03B3 BF27 4F4D 7A3F D5E8 14AA 1EB8 A247 3DFD
ed25519_ 37B2 6D38 0B25 B8A2 6B9F 3A65 A36F 5357 5F2D DC4C
