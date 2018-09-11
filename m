Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:35594 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbeIKPGg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Sep 2018 11:06:36 -0400
Date: Tue, 11 Sep 2018 12:07:57 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 07/16] x86/pci: Add Hygon Dhyana support to PCI and
 north bridge
Message-ID: <20180911100757.GD12094@zn.tnic>
References: <cover.1536550549.git.puwen@hygon.cn>
 <035e5d0a4f2a0edf68ca0f1019e47b878eaa5da6.1536550550.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <035e5d0a4f2a0edf68ca0f1019e47b878eaa5da6.1536550550.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, helgaas@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
Message-ID: <20180911100757.aOSK29LEDXgbtsk2q5ogQaGDYpcsTozmwG8dwwkqJJE@z>

On Mon, Sep 10, 2018 at 09:17:11PM +0800, Pu Wen wrote:
> As Hygon registered its PCI Vendor ID as a new one 0x1d94, and there
> are PCI Devices 0x1450/0x1463/0x1464 for Host bridge on Hygon Dhyana
> platforms, so add Hygon Dhyana support to the PCI and north bridge
> subsystem by using the code path of AMD family 17h.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/kernel/amd_nb.c | 47 +++++++++++++++++++++++++++++++++++++++++------
>  arch/x86/pci/amd_bus.c   |  6 ++++--
>  include/linux/pci_ids.h  |  2 ++
>  3 files changed, 47 insertions(+), 8 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
