From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v8 07/16] x86/pci: Add Hygon Dhyana support to PCI and
 north bridge
Date: Sun, 23 Sep 2018 13:10:46 +0200
Message-ID: <20180923111046.GA20575@zn.tnic>
References: <cover.1537533368.git.puwen@hygon.cn>
 <580dc519d37ad9257520fe8c533f2c61d3e0cd83.1537533369.git.puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <580dc519d37ad9257520fe8c533f2c61d3e0cd83.1537533369.git.puwen@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>
Cc: bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, helgaas@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, Sep 23, 2018 at 05:35:13PM +0800, Pu Wen wrote:
> As Hygon registered its PCI Vendor ID as a new one 0x1d94, and there
> are PCI Devices 0x1450/0x1463/0x1464 for Host bridge on Hygon Dhyana
> platform, so add Hygon Dhyana support to the PCI and north bridge
> subsystem by using the code path of AMD family 17h.
> 
> To prevent further checking PCI device ids which cannot happen both on
> Hygon and Intel platform, the function amd_gart_present should return
> if it's not a AMD CPU.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h
> Reviewed-by: Borislav Petkov <bp@suse.de>

A note for your future submissions: if you rework a patch in a
non-trivial way, you *must* drop Reviewed-by/Acked-by tags because they
are not valid anymore.

In this case I guess Bjorn's tag can stay because he's acking the
pci_ids.h addition but mine definitely must go.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
