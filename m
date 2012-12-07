From: Michal Simek <monstr@monstr.eu>
Subject: Re: Sharing PCIE driver between Microblaze and Arm zynq
Date: Fri, 07 Dec 2012 19:52:15 +0100
Message-ID: <50C23ADF.3060607@monstr.eu>
References: <CAHTX3dLxbVxn+D+AV7L0VsGYFOjas3AJ_3M_xncVfxp02FCy=Q@mail.gmail.com> <20121207131706.EC9273E0B87@localhost>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121207131706.EC9273E0B87@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Michal Simek <michal.simek@xilinx.com>, LKML <linux-kernel@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arch@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, John Williams <jwilliams@xilinx.com>
List-Id: linux-arch.vger.kernel.org

On 12/07/2012 02:17 PM, Grant Likely wrote:
> On Thu, 6 Dec 2012 15:23:14 +0100, Michal Simek <michal.simek@xilinx.com> wrote:
>> Hi guys,
>>
>> I have a question regarding to sharing generic OF pcie driver between
>> two architectures MB and ARM Zynq.
>> Is drivers/pci/pcie location good for it?
>> Make no sense to have the same driver in two locations.
>> Is using readl/writel IO functions in this driver the best option
>> which we can have?
>> Or is there any other recommendation?

Grant: What do you think about readl/iowrite usage in connection to PCI?

>> Also just want to check if it is correct to use pcie device_type.
>> The rest should be the same with pci description:
>> (http://devicetree.org/MPC5200:PCI#PCI_Address_Translation).
>
> Yes. device_type may be deprecated, but the PCI binding predates that.

If it is deprecated, there could be probably problem with early_init_dt_scan_memory()
which is checking memory device_type (drivers/of/fdt.c).


> PowerPC uses pcie in the device type. arch/powerpc/kernel/of_platform.c

ok. I see.

> Some of that powerpc DT PCI support code really should be made generic.

yep.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
