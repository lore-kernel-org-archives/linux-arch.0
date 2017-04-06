From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH V10 00/12] IOMMU probe deferral support
Date: Thu, 6 Apr 2017 11:46:07 -0700
Message-ID: <58E68CEF.8090101@gmail.com>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
 <1491301105-5274-1-git-send-email-sricharan@codeaurora.org>
 <CAL_JsqJH9C9sNGBSLH88bJ=uKF7RibHDAUZUW9M2xeO2AM-FUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJH9C9sNGBSLH88bJ=uKF7RibHDAUZUW9M2xeO2AM-FUw@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Sricharan R <sricharan@codeaurora.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Linux IOMMU <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Tomasz Nowicki <tn@semihalf.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sinan Kaya <okaya@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>S
List-Id: linux-arch.vger.kernel.org

On 04/04/17 18:23, Rob Herring wrote:
> On Tue, Apr 4, 2017 at 5:18 AM, Sricharan R <sricharan@codeaurora.org> wrote:
>> This series calls the dma ops configuration for the devices
>> at a generic place so that it works for all busses.
>> The dma_configure_ops for a device is now called during
>> the device_attach callback just before the probe of the
>> bus/driver is called. Similarly dma_deconfigure is called during
>> device/driver_detach path.
> 
> For patches 3, 4, 6, 7, 8:
> 
> Acked-by: Rob Herring <robh@kernel.org>
> .
> 

And a few hours later, I had the opposite opinion on a couple of
patches, so there is some ongoing discussion working this out.

-Frank
