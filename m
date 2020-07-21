From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/6] syscalls: use uaccess_kernel in
 addr_limit_user_check
Date: Tue, 21 Jul 2020 07:35:42 +0200
Message-ID: <20200721053542.GA10301@lst.de>
References: <20200714105505.935079-1-hch@lst.de> <20200714105505.935079-2-hch@lst.de> <20200718013849.GA157764@roeck-us.net> <20200718094846.GA8593@lst.de> <20200720221046.GA86726@roeck-us.net> <20200721045834.GA9613@lst.de> <eb470677-b569-a6f0-e63b-60149b54863a@roeck-us.net> <20200721052022.GA10011@lst.de> <7fc565fe-411e-6a0b-8aaf-0bf808f0d6a9@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:50620 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgGUFfq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Jul 2020 01:35:46 -0400
Content-Disposition: inline
In-Reply-To: <7fc565fe-411e-6a0b-8aaf-0bf808f0d6a9@roeck-us.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Christoph Hellwig <hch@lst.de>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 10:30:30PM -0700, Guenter Roeck wrote:
> Guess I lost it somewhere. Are you saying the check was wrong all along
> and your patch fixed it ?

Oh, it is a little complicated.

Normally we have two address space limits, KERNEL_DS and USER_DS,
and they are supposed to be different.  armnommu and m68k define them
to the same value for no good reason.  That leads to:

uaccess_kernel always returning true as it does a positive check
agains KERNEL_DS, which disables a bunch of drivers like sg and
rdma, and could also lead to really strange and probably broken
results in a few places.

It also leads to the SIGKILL in addr_limit_user_check never
triggering due to the negatіve check, which is ok as the limits
never are different.
