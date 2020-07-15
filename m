From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/6] exec: use force_uaccess_begin during exec and exit
Date: Wed, 15 Jul 2020 08:06:20 +0200
Message-ID: <20200715060620.GA21385@lst.de>
References: <20200714105505.935079-1-hch@lst.de> <20200714105505.935079-7-hch@lst.de> <87v9ip4fm6.fsf@x220.int.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:57614 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbgGOGGY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jul 2020 02:06:24 -0400
Content-Disposition: inline
In-Reply-To: <87v9ip4fm6.fsf@x220.int.ebiederm.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Christoph Hellwig <hch@lst.de>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:33:05PM -0500, Eric W. Biederman wrote:
> Christoph Hellwig <hch@lst.de> writes:
> 
> > Both exec and exit want to ensure that the uaccess routines actually do
> > access user pointers.  Use the newly added force_uaccess_begin helper
> > instead of an open coded set_fs for that to prepare for kernel builds
> > where set_fs() does not exist.
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Have you played with a tree with all of your patches
> and placing force_uaccess_begin in init/main.c:start_kernel?

No, I have converted the early boot code to not require KERNEL_DS
and except for a pending network item remove set_fs entirely.  Older
series here, will need some rework:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/set_fs-removal
