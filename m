Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:20668 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbaHECV1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Aug 2014 22:21:27 -0400
Message-ID: <53E03F87.8040702@huawei.com>
Date: Tue, 5 Aug 2014 10:20:55 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 00/11] Refactor MSI to support Non-PCI device
References: <1406344128-27055-1-git-send-email-wangyijing@huawei.com> <201408011516.26253.arnd@arndb.de> <53DEFECB.3030201@huawei.com> <201408041645.50566.arnd@arndb.de>
In-Reply-To: <201408041645.50566.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Paul.Mundt@huawei.com, Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, virtualization@lists.linux-foundation.org, Xinwei Hu <huxinwei@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>, Wuyun <wuyun.wu@huawei.com>
Message-ID: <20140805022055.cY2O-EtXV-BHiQ3EcA1gVKTcUX3ymgiRFA7e0FUc6c0@z>

On 2014/8/4 22:45, Arnd Bergmann wrote:
> On Monday 04 August 2014, Yijing Wang wrote:
>> I have another question is some drivers will request more than one
>> MSI/MSI-X IRQ, and the driver will use them to process different things.
>> Eg. network driver generally uses one of them to process trivial network thins,
>> and others to transmit/receive data.
>>
>> So, in this case, it seems to driver need to touch the IRQ numbers.
>>
>> wr-linux:~ # cat /proc/interrupts
>>             CPU0       CPU1       CPU2     ....      CPU17      CPU18      CPU19      CPU20      CPU21      CPU22      CPU23
>>  ......
>>  100:          0          0          0               0          0          0          0          0          0          0  IR-PCI-MSI-edge      eth0
>>  101:          2          0          0               0          0          0  302830488          0          0          0  IR-PCI-MSI-edge      eth0-TxRx-0
>>  102:        110          0          0               0          0  360675897          0          0          0          0  IR-PCI-MSI-edge      eth0-TxRx-1
>>  103:        109          0          0               0          0          0          0          0          0          0  IR-PCI-MSI-edge      eth0-TxRx-2
>>  104:        107          0          0         9678933          0          0          0          0          0          0  IR-PCI-MSI-edge      eth0-TxRx-3
>>  105:        107          0          0               0  357838258          0          0          0          0          0  IR-PCI-MSI-edge      eth0-TxRx-4
>>  106:        115          0          0               0          0          0          0          0          0          0  IR-PCI-MSI-edge      eth0-TxRx-5
>>  107:        114          0          0               0          0          0          0  337866096          0          0  IR-PCI-MSI-edge      eth0-TxRx-6
>>  108:  373801199          0          0               0          0          0          0          0          0          0  IR-PCI-MSI-edge      eth0-TxRx-7
>>
> 
> I think in this example, you just need to request eight interrupts, and pass a
> different data pointer each time, pointing to the napi_struct of each of the
> NIC queues. The driver has no need to deal with the IRQ number at all,
> and I would be surprised if it cared today.

Yes, you are right, this is not a stumbling block. :)

> 
> 	Arnd
> 
> .
> 


-- 
Thanks!
Yijing

