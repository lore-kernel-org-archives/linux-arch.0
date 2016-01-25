Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:59393 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755368AbcAYJJv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jan 2016 04:09:51 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/5] dma-mapping: add dma_{map,unmap}_page_attrs
Date: Mon, 25 Jan 2016 10:09:41 +0100
Message-ID: <1926814.s3ZxygyFZe@wuerfel>
In-Reply-To: <1989275.WS6Og0GPnT@avalon>
References: <1453384895-20395-1-git-send-email-niklas.soderlund+renesas@ragnatech.se> <1453384895-20395-2-git-send-email-niklas.soderlund+renesas@ragnatech.se> <1989275.WS6Og0GPnT@avalon>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>, dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org, vinod.koul@intel.com, linus.walleij@linaro.org, geert+renesas@glider.be, dan.j.williams@intel.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20160125090941.DTCeP8RFox0t8EwMbV6UwdwltizIY3VPgSyRgn1LIXA@z>

On Sunday 24 January 2016 22:43:57 Laurent Pinchart wrote:
> Hi Niklas,
> 
> (CC'ing LKML, linux-arch and Arnd Bergmann)
> 
> Thank you for the patch.
> 
> On Thursday 21 January 2016 15:01:31 Niklas Söderlund wrote:
> > Add a version of dmap_{map,unmap}_page that can pass on attributes to
> > the underlaying map_page. This already exists for dma_{map,unmap}_single
> > and dmap_{map,unmap}_sg versions.
> > 
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 

The patch looks fine, but won't apply any more now that the code has
been moved to include/linux/dma-mapping.h

	Arnd
