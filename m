Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:11621 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdCBL7E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2017 06:59:04 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: RE: [PATCH 14/20] PCI: hisi: update PCI config space remap function
Date: Thu, 2 Mar 2017 11:53:44 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1FA96D4D@lhreml507-mbx>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-15-lorenzo.pieralisi@arm.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1FA96A69@lhreml507-mbx>
 <20170302114937.GA17277@red-moon>
In-Reply-To: <20170302114937.GA17277@red-moon>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>
Message-ID: <20170302115344.1MGngUTO44wGvq-Hq_NX--Ssg3fembSUTh9b7SsWgG4@z>

[...]

> 
> I will fold the changes into v2 (and I hope other host controllers
> maintainers will follow suit - I do not have enough knowledge of
> all host bridges drivers internals to understand what ioremap calls
> need patching).

Ok great, many thanks!

Gab

> 
> Thanks !
> Lorenzo
