Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:34434 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbeITNHa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Sep 2018 09:07:30 -0400
Date: Thu, 20 Sep 2018 09:25:09 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 07/16] x86/pci: Add Hygon Dhyana support to PCI and
 north bridge
In-Reply-To: <d05c7aa5-05ba-5ac2-c70f-414d9539925f@amd.com>
Message-ID: <alpine.DEB.2.21.1809200923190.1425@nanos.tec.linutronix.de>
References: <cover.1536550549.git.puwen@hygon.cn> <035e5d0a4f2a0edf68ca0f1019e47b878eaa5da6.1536550550.git.puwen@hygon.cn> <d05c7aa5-05ba-5ac2-c70f-414d9539925f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: Pu Wen <puwen@hygon.cn>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "helgaas@kernel.org" <helgaas@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <20180920072509.LeZ1dDAgxDdVwNrMao3Ex-RBDeN2S58k6bmlGOcdFAA@z>

On Wed, 19 Sep 2018, Lendacky, Thomas wrote:
> 
> To be compatible with "before this patch" you should probably do:
> 
> 	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
> 		root_ids = hygon_root_ids;
> 		misc_ids = hygon_nb_misc_ids;
> 		link_ids = hygon_nb_link_ids;
> 	} else {
> 		root_ids = amd_root_ids;
> 		misc_ids = amd_nb_misc_ids;
> 		link_ids = amd_nb_link_ids;
> 	}
> 
> That way they are always the AMD values if not your chip.

And please can we have a comment why this is called on anything which is
not AMD or HYGON. It's all but obvious and clearly unexpected.

Thanks,

	tglx
