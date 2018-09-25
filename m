From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 0/4] devres: provide and use devm_kstrdup_const()
Date: Tue, 25 Sep 2018 13:51:32 +0100
Message-ID: <c25df148-718a-d29d-9c1d-20701a0e4534@arm.com>
References: <20180925124629.20710-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925124629.20710-1-brgl@bgdev.pl>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Arend van Spriel <aspriel@gmail.com>, Vivek Gautam <vivek.gautam@codeaurora.org>, Joe Perches <joe@perches.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>, Huang Ying <ying.huang@intel.com>, Andy Shevchenko <and>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

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
