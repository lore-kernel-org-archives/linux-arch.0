From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3] powerpc/lockdep: fix a false positive warning
Date: Wed, 11 Sep 2019 00:14:34 +1000
Message-ID: <87pnk8z19x.fsf@mpe.ellerman.id.au>
References: <1568039433-10176-1-git-send-email-cai@lca.pw>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1568039433-10176-1-git-send-email-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mingo@kernel.org, peterz@infradead.org, bvanassche@acm.org, arnd@arndb.de, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
List-Id: linux-arch.vger.kernel.org

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
