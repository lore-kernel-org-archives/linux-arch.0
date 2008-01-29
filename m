Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:17406 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754981AbYA2DVq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jan 2008 22:21:46 -0500
Received: from zps36.corp.google.com (zps36.corp.google.com [172.25.146.36])
	by smtp-out.google.com with ESMTP id m0T3LeUx011347
	for <linux-arch@vger.kernel.org>; Mon, 28 Jan 2008 19:21:40 -0800
Received: from rv-out-0910.google.com (rvfc24.prod.google.com [10.140.180.24])
	by zps36.corp.google.com with ESMTP id m0T3Lcr5017584
	for <linux-arch@vger.kernel.org>; Mon, 28 Jan 2008 19:21:40 -0800
Received: by rv-out-0910.google.com with SMTP id c24so1690616rvf.42
        for <linux-arch@vger.kernel.org>; Mon, 28 Jan 2008 19:21:40 -0800 (PST)
Message-ID: <da824cf30801281921n603458c4wc8caf34791401514@mail.gmail.com>
Date: Tue, 29 Jan 2008 14:21:39 +1100
From: "Grant Grundler" <grundler@google.com>
Subject: Re: DMA mapping on SCSI device?
In-Reply-To: <479E6E8C.2090501@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <479E6E8C.2090501@shaw.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-arch@vger.kernel.org, ide <linux-ide@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org

On Jan 29, 2008 11:08 AM, Robert Hancock <hancockr@shaw.ca> wrote:
...
> The last solution I tried was to set the DMA mask on both ports to
> 32-bit on slave_configure when an ATAPI device is connected. However,
> this runs into complications as well. This is run on initialization and
> when trying to set the other port into 32-bit DMA, it may not be
> initialized yet. Plus, it forces the port with a hard drive on it into
> 32-bit DMA needlessly.

Have you measured the impact of setting the PCI dma mask to 32-bit?

Last time Alex Williamson (HP) measured this on IA64, we deliberately
forced pci_map_sg() to use the IOMMU even for devices that were 64-bit
capable. We got 3-5% better throughput since the device had fewer
entries to retrieve and the devices (at the time) weren't that good at
processing SG lists.

>
> The ideal solution would be to do mapping against a different struct
> device for each port, so that we could maintain the proper DMA mask for
> each of them at all times. However I'm not sure if that's possible. The
> thought of using the SCSI struct device for DMA mapping was brought up
> at one point.. any thoughts on that?

I'm pretty sure that's not possible (using two PCI dev structs). I'm
skeptical it's worth converting DMA services to use SCSI devs since
that's an extremely invasive change for a marginal benefit.

hth,
grant

> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
