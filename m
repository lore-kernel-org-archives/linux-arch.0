From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v8 01/26] arm64: Fix HCR.TGE status for NMI contexts
Date: Mon, 14 Jan 2019 15:56:35 +0000
Message-ID: <20190114155634.GB84430@arrakis.emea.arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-2-git-send-email-julien.thierry@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1546956464-48825-2-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Julien Thierry <julien.thierry@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, daniel.thompson@linaro.org, Arnd Bergmann <arnd@arndb.de>, marc.zyngier@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, christoffer.dall@arm.com, james.morse@arm.com, joel@joelfernandes.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 08, 2019 at 02:07:19PM +0000, Julien Thierry wrote:
> When using VHE, the host needs to clear HCR_EL2.TGE bit in order
> to interract with guest TLBs, switching from EL2&0 translation regime
> to EL1&0.
> 
> However, some non-maskable asynchronous event could happen while TGE is
> cleared like SDEI. Because of this address translation operations
> relying on EL2&0 translation regime could fail (tlb invalidation,
> userspace access, ...).

Why would an NMI context need to access user space? (just curious what
breaks exactly without this patch; otherwise it looks fine)

-- 
Catalin
