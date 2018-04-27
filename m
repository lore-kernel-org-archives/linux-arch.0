From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v8 0/4] Fix issues with huge mapping in ioremap for ARM64
Date: Fri, 27 Apr 2018 11:27:05 +0100
Message-ID: <20180427102705.giwkzgqp43qiptws@armageddon.cambridge.arm.com>
References: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
 <b2ea9760-cad4-8f30-98ac-86a04c4d42a4@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b2ea9760-cad4-8f30-98ac-86a04c4d42a4@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: will.deacon@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com, linux-arch@vger.kernel.org, arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, tglx@linutronix.de, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 17, 2018 at 03:55:08PM +0530, Chintan Pandya wrote:
> Ping...
> 
> On 4/3/2018 1:30 PM, Chintan Pandya wrote:
> > This series of patches are follow up work (and depends on)
> > Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
> > panic in ioremap huge pages".

First of all, you'd need to post patches against the latest mainline
(4.17-rcX).

Second, since they depend on another series, we'd have to wait for the
comments on that series to settle.

-- 
Catalin
