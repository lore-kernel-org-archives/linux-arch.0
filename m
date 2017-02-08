From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: armv8_deprecated: add missing arm/kprobes.h header
Date: Wed, 8 Feb 2017 19:09:05 +0000
Message-ID: <20170208190904.GO3986@arm.com>
References: <20170208173341.14326-1-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170208173341.14326-1-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: akpm@linux-foundation.org, arnd@arndb.de, mhiramat@kernel.org, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, luto@kernel.org, broonie@kernel.org, catalin.marinas@arm.com, rostedt@goodmis.org, bp@suse.de, bp@alien8.de, linux@armlinux.org.uk, dhowells@redhat.com, benh@kernel.crashing.org, ralf@linux-mips.org, jpoimboe@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org, kernel-build-reports@lists.linaro.org
List-Id: linux-arch.vger.kernel.org

Thanks, Luis.

On Wed, Feb 08, 2017 at 09:33:41AM -0800, Luis R. Rodriguez wrote:
> 0-day caught a compile issue after the commit titled (kprobes: move
> kprobe declarations to asm-generic/kprobes.h) was applied. This fixes
> that.
> 
> Reported-by: 0-day
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
> 
> As seen on linux-next tag next-20170208.

I'm happy to pick this up in arm64, but given that the offending commit
comes via akpm, I guess he may prefer to pick it up so that his tree
builds for arm64 stand-alone. In that case:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
