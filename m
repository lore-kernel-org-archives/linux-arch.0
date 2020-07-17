From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] asm-generic/mmiowb: Allow mmiowb_set_pending() when preemptible()
Date: Fri, 17 Jul 2020 11:43:43 +0100
Message-ID: <159497652409.524891.6561966096386113237.b4-ty@kernel.org>
References: <20200716112816.7356-1-will@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200716112816.7356-1-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, kernel-team@android.com, Paul Walmsley <paul.walmsley@sifive.com>, Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org, Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Thu, 16 Jul 2020 12:28:16 +0100, Will Deacon wrote:
> Although mmiowb() is concerned only with serialising MMIO writes occuring
> in contexts where a spinlock is held, the call to mmiowb_set_pending()
> from the MMIO write accessors can occur in preemptible contexts, such
> as during driver probe() functions where ordering between CPUs is not
> usually a concern, assuming that the task migration path provides the
> necessary ordering guarantees.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] asm-generic/mmiowb: Allow mmiowb_set_pending() when preemptible()
      https://git.kernel.org/arm64/c/bd024e82e4cd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
