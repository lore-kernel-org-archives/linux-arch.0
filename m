From: Michal Simek <monstr@monstr.eu>
Subject: request_mem_region() for noPCI devices
Date: Fri, 18 Jan 2013 15:46:53 +0100
Message-ID: <CAHTX3dJ2Qqs6QxJEcd24KW5y2DSumLy82jvVUxBjjMWQULrxdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi guys,

just want to check with you usage of request_mem_region for noPCI devices.
kernel/resource.c suggests that it should be used just for PCI iomem
(iomem_resource uses name PCI mem).

If I grep architectures I see several usage for noPCI devices.

Does it mean that request_mem_region should be used for all devices
which request io memory? Or just for PCI iomem?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian
