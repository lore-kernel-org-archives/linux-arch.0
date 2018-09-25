Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728881AbeIYS7D (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Sep 2018 14:59:03 -0400
Subject: Re: [PATCH v4 0/4] devres: provide and use devm_kstrdup_const()
References: <20180925124629.20710-1-brgl@bgdev.pl>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c25df148-718a-d29d-9c1d-20701a0e4534@arm.com>
Date: Tue, 25 Sep 2018 13:51:32 +0100
MIME-Version: 1.0
In-Reply-To: <20180925124629.20710-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Arend van Spriel <aspriel@gmail.com>, Vivek Gautam <vivek.gautam@codeaurora.org>, Joe Perches <joe@perches.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>, Huang Ying <ying.huang@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20180925125132.B7AkX3PZyM4UGcZ3WWt3a1ZLfuo5iO_Tor2lF3h5WzQ@z>

On 25/09/18 13:46, Bartosz Golaszewski wrote:
> This series implements devm_kstrdup_const() together with some
> prerequisite changes and uses it in pmc-atom driver.

Is anyone expecting me to review this series, or am I just here because 
I once made a couple of entirely unrelated changes to device.h?

Robin.

> v1 -> v2:
> - fixed the changelog in the patch implementing devm_kstrdup_const()
> - fixed the kernel doc
> - moved is_kernel_rodata() to asm-generic/sections.h
> - fixed constness
> 
> v2 -> v3:
> - rebased on top of 4.19-rc5 as there were some conflicts in the
>    pmc-atom driver
> - collected Reviewed-by tags
> 
> v3 -> v4:
> - Andy NAK'ed patch 4/4 so I added a different example
> - collected more tags
> 
> Bartosz Golaszewski (4):
>    devres: constify p in devm_kfree()
>    mm: move is_kernel_rodata() to asm-generic/sections.h
>    devres: provide devm_kstrdup_const()
>    mailbox: tegra-hsp: use devm_kstrdup_const()
> 
>   drivers/base/devres.c          | 43 ++++++++++++++++++++++++++++++++--
>   drivers/mailbox/tegra-hsp.c    | 41 +++++++-------------------------
>   include/asm-generic/sections.h | 14 +++++++++++
>   include/linux/device.h         |  5 +++-
>   mm/util.c                      |  7 ------
>   5 files changed, 68 insertions(+), 42 deletions(-)
> 
