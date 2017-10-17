Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:48908 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753515AbdJQLu1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Oct 2017 07:50:27 -0400
Received: by mail-wm0-f41.google.com with SMTP id i124so3291485wmf.3
        for <linux-arch@vger.kernel.org>; Tue, 17 Oct 2017 04:50:27 -0700 (PDT)
Date: Tue, 17 Oct 2017 13:50:24 +0200
From: Christoffer Dall <cdall@linaro.org>
Subject: Re: [PATCH v3 22/28] arm64/sve: KVM: Prevent guests from using SVE
Message-ID: <20171017115024.GS1845@lvm>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-23-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1507660725-7986-23-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, kvmarm@lists.cs.columbia.edu
Message-ID: <20171017115024.BayfexWSv6pO2PEzRW4fHPV6Rba62aY_5OpMgi66CtE@z>

On Tue, Oct 10, 2017 at 07:38:39PM +0100, Dave Martin wrote:
> Until KVM has full SVE support, guests must not be allowed to
> execute SVE instructions.
> 
> This patch enables the necessary traps, and also ensures that the
> traps are disabled again on exit from the guest so that the host
> can still use SVE if it wants to.
> 
> This patch introduces another instance of
> __this_cpu_write(fpsimd_last_state, NULL), so this flush operation
> is abstracted out as a separate helper fpsimd_flush_cpu_state().
> Other instances are ported appropriately.

I don't understand this paragraph, beginning from ", so this...".
