Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:39241 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387967AbfIJOOd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Sep 2019 10:14:33 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3] powerpc/lockdep: fix a false positive warning
In-Reply-To: <1568039433-10176-1-git-send-email-cai@lca.pw>
References: <1568039433-10176-1-git-send-email-cai@lca.pw>
Date: Wed, 11 Sep 2019 00:14:34 +1000
Message-ID: <87pnk8z19x.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Qian Cai <cai@lca.pw>
Cc: benh@kernel.crashing.org, paulus@samba.org, mingo@kernel.org, peterz@infradead.org, bvanassche@acm.org, arnd@arndb.de, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190910141434.UXONFJKzldN9o7884ptMlSDL7hCvMibJ5cO42ZRUCNU@z>

Hi Qian,

Sorry I haven't replied sooner, I've been travelling.

Qian Cai <cai@lca.pw> writes:
> The commit 108c14858b9e ("locking/lockdep: Add support for dynamic
> keys") introduced a boot warning on powerpc below, because since the
> commit 2d4f567103ff ("KVM: PPC: Introduce kvm_tmp framework") adds
> kvm_tmp[] into the .bss section and then free the rest of unused spaces
> back to the page allocator.

Thanks for debugging this, but I'd like to fix it differently.

kvm_tmp has caused trouble before, with kmemleak, and it can also cause
trouble with STRICT_KERNEL_RWX, so I'd like to change how it's done,
rather than doing more hacks for it.

It should just be a page in text that we use if needed, and don't free,
which should avoid all these problems.

I'll try and get that done and posted soon.

cheers
