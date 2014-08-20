Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2lp0212.outbound.protection.outlook.com ([207.46.163.212]:3191
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750984AbaHTF6L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 Aug 2014 01:58:11 -0400
From: "Bharat.Bhushan@freescale.com" <Bharat.Bhushan@freescale.com>
Subject: RE: [RFC PATCH 03/11] PCI/MSI: Refactor pci_dev_msi_enabled()
Date: Wed, 20 Aug 2014 05:57:55 +0000
Message-ID: <674b6075c4dd4ee1a4c4149219b5afea@BLUPR03MB566.namprd03.prod.outlook.com>
References: <1406344128-27055-1-git-send-email-wangyijing@huawei.com>
 <1406344128-27055-4-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1406344128-27055-4-git-send-email-wangyijing@huawei.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yijing Wang <wangyijing@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Paul.Mundt@huawei.com" <Paul.Mundt@huawei.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Marc Zyngier <marc.zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnab.basu@freescale.com" <arnab.basu@freescale.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Hanjun Guo <guohanjun@huawei.com>
Message-ID: <20140820055755.wF_aficxEXRK3dGOlsagZ52BVv1_ltVjsL0Qd8vybMk@z>



> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org]
> On Behalf Of Yijing Wang
> Sent: Saturday, July 26, 2014 8:39 AM
> To: linux-kernel@vger.kernel.org
> Cc: Xinwei Hu; Wuyun; Bjorn Helgaas; linux-pci@vger.kernel.org;
> Paul.Mundt@huawei.com; James E.J. Bottomley; Marc Zyngier; linux-arm-
> kernel@lists.infradead.org; Russell King; linux-arch@vger.kernel.org; Basu
> Arnab-B45036; virtualization@lists.linux-foundation.org; Hanjun Guo; Yijing Wang
> Subject: [RFC PATCH 03/11] PCI/MSI: Refactor pci_dev_msi_enabled()
> 
> Pci_dev_msi_enabled() is used to check whether device MSI/MSIX enabled. Refactor
> this function  to suuport checking only device MSI or MSIX enabled.

s/support/support
