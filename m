Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50902 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbeJSToI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Oct 2018 15:44:08 -0400
Date: Fri, 19 Oct 2018 12:38:21 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC 12/17] arm64: move ptrauth keys to thread_info
Message-ID: <20181019113820.jly74g2kk3cxf3yp@mbp>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-13-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005084754.20950-13-kristina.martsenko@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Andrew Jones <drjones@redhat.com>, Jacob Bramley <jacob.bramley@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Adam Wallis <awallis@codeaurora.org>, "Suzuki K . Poulose" <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>, Amit Kachhap <Amit.Kachhap@arm.com>, Dave P Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Message-ID: <20181019113821.ddOgxTWHW2cZ20gicFmEtkTS0_Jb8BcDSYebk52cHVo@z>

On Fri, Oct 05, 2018 at 09:47:49AM +0100, Kristina Martsenko wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> To use pointer authentication in the kernel, we'll need to switch keys
> in the entry assembly. This patch moves the pointer auth keys into
> thread_info to make this possible.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>

Can we actually fold this into patch 7? It also leaves the door open to
allowing per-thread keys.

-- 
Catalin
