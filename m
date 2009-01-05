From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 1/6] PCI: add pci_common_swizzle() for INTx swizzling
Date: Mon, 5 Jan 2009 10:53:01 -0800
Message-ID: <200901051053.02747.jbarnes@virtuousgeek.org>
References: <20081217043443.8372.28890.stgit@bob.kio> <20081217043655.8372.52729.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20081217043655.8372.52729.stgit@bob.kio>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com
List-Id: linux-arch.vger.kernel.org

On Tuesday, December 16, 2008 8:36 pm Bjorn Helgaas wrote:
> This patch adds pci_common_swizzle(), which swizzles INTx values all the
> way up to a root bridge.
>
> This common implementation can replace several architecture-specific
> ones.  This should someday be combined with pci_get_interrupt_pin(),
> but I left it separate for now to make reviewing easier.
>
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

We got acks from the arch maintainers on the previous series, so I'm assuming 
these ones are ok too (please pipe up if not, they're in my linux-next queue).

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
