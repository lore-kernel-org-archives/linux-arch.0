Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:48066 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab3AROq4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2013 09:46:56 -0500
Received: by mail-ia0-f182.google.com with SMTP id w33so1464339iag.41
        for <linux-arch@vger.kernel.org>; Fri, 18 Jan 2013 06:46:55 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 18 Jan 2013 15:46:53 +0100
Message-ID: <CAHTX3dJ2Qqs6QxJEcd24KW5y2DSumLy82jvVUxBjjMWQULrxdQ@mail.gmail.com>
Subject: request_mem_region() for noPCI devices
From: Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20130118144653.MA8vOnjiqfZH2bC39u2P644qyjQNgDZ8Ro0koaOGobk@z>

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
