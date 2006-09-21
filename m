Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:45749 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751295AbWIUQAR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 21 Sep 2006 12:00:17 -0400
Subject: Re: ZONE_DMA (was: Re: 2.6.19 -mm merge plans)
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <1158800630.11109.72.camel@localhost.localdomain>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	 <4511D855.7050100@mbligh.org> <20060920172253.f6d11445.akpm@osdl.org>
	 <Pine.LNX.4.64.0609201724490.2403@schroedinger.engr.sgi.com>
	 <1158800630.11109.72.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 11:59:51 -0400
Message-Id: <1158854391.14329.1.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2006-09-21 at 02:03 +0100, Alan Cox wrote:
> IOMMUs don't always help. They IOMMU aperture on AMD64 for example is
> too high to help devices with below 32bit limits.

That's because it's not an IOMMU; it's a GART.  A true IOMMU separates
the machine physical and bus physical address spaces ... a GART merely
remaps a hole in physical address space.

James


