From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH 02/20] PCI: fix pci_remap_iospace() remap attribute
Date: Fri, 17 Mar 2017 17:26:18 +0100
Message-ID: <20170317162617.GC28800@wotan.suse.de>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-3-lorenzo.pieralisi@arm.com>
 <20170316214844.GA17769@bhelgaas-glaptop.roam.corp.google.com>
 <20170317003321.GB28800@wotan.suse.de>
 <20170317104339.GD24830@bart.dudau.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170317104339.GD24830@bart.dudau.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Liviu Dudau <liviu@dudau.co.uk>
Cc: Wenrui Li <wenrui.li@rock-chips.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Russell King <linux@armlinux.org.uk>, Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>, Zhou Wang <wangzhou1@hisilicon.com>, linux-arch@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Pratyush Anand <pratyush.anand@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>, Murali Karicheri <m-karicheri2@ti.com>, Bjorn Helgaas <helgaas@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jonmason@broadcom.com>, Will Deacon <will.deacon@arm.com>, John Garry <john.garry@huawei.com>, Joao Pinto <Joao.Pinto@syn>
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 17, 2017 at 10:43:39AM +0000, Liviu Dudau wrote:
> On Fri, Mar 17, 2017 at 01:33:21AM +0100, Luis R. Rodriguez wrote:
> > a) should we then use a Fixes tag for this patch ?
> 
> I'm not aware of issues being reported, but Lorenzo might have more info on this.

Lorenzo ? If not what exactly made you discover this ? If it is a fix, and only 
ARM64 is implicated, seems like a worthy change to consider for stable for the
sake of stable ARM64 kernels. But, that would leave the PCI config space without
a simple 1 liner fix too -- so maybe its not worth it. Distributions wanting
to support ARM64 however would like to carry these changes, so some annotations
such as Fixes should help.

> > b) it does not seem clear what the semantics for pgprot_device() or even
> >    pgprot_noncached(). Can you add some ?
> > 
> > 8b921acfeffdb ("PCI: Add pci_remap_iospace() to map bus I/O resources")
> > 
> > Also this patch claims archs can override this call alone, as its __weak.
> > So is the right thing to do to change pci_remap_iospace() to pgprot_noncached()
> > or is it for archs to add their own pci_remap_iospace()? If so why ? Without
> > proper semantics defined for these helpers this is all fuzzy.
> 
> That was the initial intention, to let arches / platforms overwrite the whole
> pci_remap_iospace(). I guess the reality is that no one needs to overwrite it except
> for the AArch64 quirk, so probably easier to remove the __weak and fix the attributes for arm64.

Sounds much more reasonable to me.

  Luis
