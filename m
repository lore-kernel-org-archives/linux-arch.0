From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v8 0/4] Fix issues with huge mapping in ioremap for ARM64
Date: Tue, 3 Apr 2018 09:43:23 +0100
Message-ID: <a613f834-f356-a826-526f-aef532f62951@arm.com>
References: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Chintan Pandya <cpandya@codeaurora.org>, catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com
Cc: arnd@arndb.de, ard.biesheuvel@linaro.org, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

Hi Chintan,

On 03/04/18 09:00, Chintan Pandya wrote:
> This series of patches are follow up work (and depends on)
> Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
> panic in ioremap huge pages".
> 
> This series of patches are tested on 4.9 kernel with Cortex-A75
> based SoC.

Given that this is targeting mainline, can you please test with 4.16?
Basing your patches on something that is over 15 months old is not
exactly reassuring.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
