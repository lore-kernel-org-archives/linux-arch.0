Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:57142 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753070AbeBVKKc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Feb 2018 05:10:32 -0500
Subject: Re: [PATCH v14 0/9] LPC: legacy ISA I/O support
References: <1519062520-198902-1-git-send-email-john.garry@huawei.com>
 <20180221231508.GA3790@xps13.dannf>
From: John Garry <john.garry@huawei.com>
Message-ID: <39283d76-7ab1-4886-fc2e-5861b7e8acc0@huawei.com>
Date: Thu, 22 Feb 2018 10:10:09 +0000
MIME-Version: 1.0
In-Reply-To: <20180221231508.GA3790@xps13.dannf>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dann frazier <dann.frazier@canonical.com>
Cc: mika.westerberg@linux.intel.com, rafael@kernel.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org, robh+dt@kernel.org, bhelgaas@google.com, arnd@arndb.de, mark.rutland@arm.com, olof@lixom.net, andy.shevchenko@gmail.com, robh@kernel.org, joe@perches.com, benh@kernel.crashing.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, minyard@acm.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, rdunlap@infradead.org

On 21/02/2018 23:15, dann frazier wrote:
> On Tue, Feb 20, 2018 at 01:48:31AM +0800, John Garry wrote:
>> This patchset supports the IPMI-bt device attached to the Low-Pin-Count
>> interface implemented on Hisilicon Hip06/Hip07 SoC.
>>                         -----------
>>                         | LPC host|
>>                         |         |
>>                         -----------
>>                              |
>>                 _____________V_______________LPC
>>                   |                       |
>>                   V                       V
>>                                      ------------
>>                                      |  BT(ipmi)|
>>                                      ------------
>>

[...]

>>  .../arm/hisilicon/hisilicon-low-pin-count.txt      |  33 ++
>>  MAINTAINERS                                        |   7 +
>>  drivers/acpi/pci_root.c                            |   8 +-
>>  drivers/acpi/scan.c                                |  14 +
>>  drivers/bus/Kconfig                                |   8 +
>>  drivers/bus/Makefile                               |   1 +
>>  drivers/bus/hisi_lpc.c                             | 646 +++++++++++++++++++++
>>  drivers/of/address.c                               |  96 ++-
>>  drivers/pci/pci.c                                  |  95 +--
>>  include/asm-generic/io.h                           |   4 +-
>>  include/linux/logic_pio.h                          | 131 +++++
>>  include/linux/pci.h                                |   3 +-
>>  lib/Kconfig                                        |  15 +
>>  lib/Makefile                                       |   2 +
>>  lib/logic_pio.c                                    | 285 +++++++++
>>  15 files changed, 1250 insertions(+), 98 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
>>  create mode 100644 drivers/bus/hisi_lpc.c
>>  create mode 100644 include/linux/logic_pio.h
>>  create mode 100644 lib/logic_pio.c
>
> Tested this version on a D05 board, no problems. So, for the series:
>
> Tested-by: dann frazier <dann.frazier@canonical.com>
>
> .

Thanks Dann.

I think I still need 1/2 more series review/test/sob tags to get me 
across the line.

John

>
