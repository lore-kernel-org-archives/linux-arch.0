From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/20] PCI: fix config and I/O Address space memory
 mappings
Date: Wed, 1 Mar 2017 17:18:27 +0100
Message-ID: <CAK8P3a2ULkNH39UJAeZSuw2kS+7wNyySs1RaY74ELGm498NmnA@mail.gmail.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
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
Cc: Pratyush Anand <pratyush.anand@gmail.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>, Michal Simek <michal.simek@xilinx.com>, Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>, linux-arch <linux-arch@vger.kernel.org>, Joao Pinto <Joao.Pinto@synopsys.com>, Jonathan Corbet <corbet@lwn.net>, Wenrui Li <wenrui.li@rock-chips.com>, Russell King <linux@armlinux.org.uk>, Jon Mason <jonmason@broadcom.com>, Murali Karicheri <m-karicheri2@ti.com>, linux-pci <linux-pci@vger.kernel.org>, Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>, Ray Jui <rjui@broadcom.com>, John Garry <john.garry@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@freescale.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Thomas
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 27, 2017 at 4:14 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

> This patch series[1] addresses both issues in one go:
>
> - It updates the pci_remap_iospace() function to use a page mapping
>   that guarantees non-posted write transactions for I/O space addresses
> - It adds a kernel API to remap PCI config space resources, so that
>   architecture can override it with a mapping implementation that
>   guarantees PCI specifications compliancy wrt non-posted write
>   configuration transactions
> - It updates all PCI host controller implementations (and the generic
>   ECAM layer) to use the newly introduced mapping interface
>
> Tested on Juno ECAM based interface (DT/ACPI).

This looks all good to me, nice work!

    Arnd
