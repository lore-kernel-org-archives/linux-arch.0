From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH] iommu: of: Fix check for returning EPROBE_DEFER
Date: Tue, 16 May 2017 16:09:43 +0200
Message-ID: <20170516140943.ps2yufiukz6iurpl@latitude>
References: <1494912253-25957-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1494912253-25957-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org, okaya@codeaurora.org, robh+dt@kernel.org, frowand.list@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, gregkh@linuxfoundation.org
List-Id: linux-arch.vger.kernel.org

Hi, I have a few suggestions on how to make this commit message more
readable:

On Tue, May 16, 2017 at 10:54:13AM +0530, Sricharan R wrote:
> While returning EPROBE_DEFER for iommu masters

Add a comma at the end of this line

> take in to account of iommu nodes that could be

s/in to/into/
s/of iommu/of_iommu/

> marked in DT as 'status=disabled', in which case
> simply return NULL and let the master's probe
> continue rather than deferring.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Tested-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>


Thanks,
Jonathan Neuschäfer
