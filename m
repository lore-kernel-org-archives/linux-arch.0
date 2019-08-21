Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:53830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfHUCRm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Aug 2019 22:17:42 -0400
Date: Tue, 20 Aug 2019 19:17:41 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/3] csky: Support kernel non-aligned access
Message-ID: <20190821021741.GB32710@infradead.org>
References: <1566304469-5601-1-git-send-email-guoren@kernel.org>
 <1566304469-5601-3-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566304469-5601-3-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: guoren@kernel.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org, douzhk@nationalchip.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190821021741.JxV2BU3hABmIdovUHc_29CzZK1GCToK3iZRUTkU1z_E@z>

On Tue, Aug 20, 2019 at 08:34:29PM +0800, guoren@kernel.org wrote:
> From: Guo Ren <ren_guo@c-sky.com>
> 
> We prohibit non-aligned access in kernel mode, but some special NIC
> driver needs to support kernel-state unaligned access. For example,
> when the bus does not support unaligned access, IP header parsing
> will cause non-aligned access and driver does not recopy the skb
> buffer to dma for performance reasons.
> 
> Added kernel_enable & user_enable to control unaligned access and
> added kernel_count  & user_count for statistical unaligned access.

If the NIC drivers requires this it is buggy.  Kernel code must
use the get_unaligned* / put_unaligned* helpers for that.
