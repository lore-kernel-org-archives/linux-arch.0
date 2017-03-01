From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/20] PCI: remove __weak tag from pci_remap_iospace()
Date: Wed, 1 Mar 2017 17:15:14 +0100
Message-ID: <CAK8P3a36fX2gdgdYcVT1Zg=5dsN1o-Z=Xy4471zxRWwnr1aZvw@mail.gmail.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-2-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170227151436.18698-2-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Wenrui Li <wenrui.li@rock-chips.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, linux-pci <linux-pci@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>, Michal Simek <michal.simek@xilinx.com>, Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>, linux-arch <linux-arch@vger.kernel.org>, Joao Pinto <Joao.Pinto@synopsys.com>, Pratyush Anand <pratyush.anand@gmail.com>, Russell King <linux@armlinux.org.uk>, Jon Mason <jonmason@broadcom.com>, Murali Karicheri <m-karicheri2@ti.com>, Catalin Marinas <catalin.marinas@arm.com>, Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>, Ray Jui <rjui@broadcom.com>, John Garry <john.garry@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@freescale.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-ele>
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 27, 2017 at 4:14 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> pci_remap_iospace() is marked as a weak symbol even though
> no architecture is currently overriding it; given that its
> implementation internals have already code paths that are
> arch specific (ie PCI_IOBASE and ioremap_page_range() attributes)
> there is no need to leave the weak symbol in the kernel since the
> same functionality can be achieved by customizing per-arch the
> corresponding functionality.
>
> Remove the __weak symbol from pci_remap_iospace().

Good idea,

Acked-by: Arnd Bergmann <arnd@arndb.de>
