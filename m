From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 13/20] intel-iommu: switch from ioremap_cache to memremap
Date: Mon, 12 Oct 2015 15:05:35 -0700
Message-ID: <CAPcyv4h8zca3uNUH3ZoSVxrTYXr1XPD8AFrs60JzjKAu+45nog@mail.gmail.com>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
	<20151009221646.32203.98367.stgit@dwillia2-desk3.jf.intel.com>
	<20151012215830.GT10641@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37597 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbbJLWFg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2015 18:05:36 -0400
Received: by wijq8 with SMTP id q8so3561914wij.0
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2015 15:05:35 -0700 (PDT)
In-Reply-To: <20151012215830.GT10641@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joerg Roedel <jroedel@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Oct 12, 2015 at 2:58 PM, Joerg Roedel <jroedel@suse.de> wrote:
> Hi Dan,
>
> On Fri, Oct 09, 2015 at 06:16:46PM -0400, Dan Williams wrote:
>> In preparation for deprecating ioremap_cache() convert its usage in
>> intel-iommu to memremap.  This also eliminates the mishandling of the
>> __iomem annotation in the implementation.
>
> I appreciate the change, but in the cover letter you write the API is
> only implemented for x86 so far? The VT-d driver is also used on ia64,
> will it still work there with this patch?
>
>

I did convert ia64 in the series [1]  but you're right this patch
can't go in independently of that conversion.  If you ack this one
I'll carry them in order.

[1]: https://lkml.org/lkml/2015/10/9/702
