Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35878 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757648AbcBJMLH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Feb 2016 07:11:07 -0500
Received: by mail-lf0-f51.google.com with SMTP id 78so10307737lfy.3
        for <linux-arch@vger.kernel.org>; Wed, 10 Feb 2016 04:11:06 -0800 (PST)
Subject: Re: [PATCH v3 2/8] dma-mapping: add {map,unmap}_resource to
 dma_map_ops
References: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1455065878-11906-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56BB28D7.1090608@cogentembedded.com>
Date: Wed, 10 Feb 2016 15:11:03 +0300
MIME-Version: 1.0
In-Reply-To: <1455065878-11906-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: robin.murphy@arm.com, vinod.koul@intel.com, laurent.pinchart@ideasonboard.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org
Message-ID: <20160210121103.O9zJFGzhzbfMS846Sk3vaXlQxgm3g6-Gk9_hAwVSN7I@z>

Hello.

On 2/10/2016 3:57 AM, Niklas Söderlund wrote:

> Add methods to handle mapping of device resources from a physical
> address. This is needed for example to map be able to map MMIO FIFO
                                          ^^^ not needed

> registers to a IOMMU.
>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
[...]

MBR, Sergei

