Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:60462 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbdASJSc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2017 04:18:32 -0500
Date: Thu, 19 Jan 2017 10:10:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 02/26] treewide: Move dma_ops from struct dev_archdata
 into struct device
Message-ID: <20170119091012.GC29554@kroah.com>
References: <20170112190718.6728-1-bart.vanassche@sandisk.com>
 <20170112190718.6728-3-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170112190718.6728-3-bart.vanassche@sandisk.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, David Woodhouse <dwmw2@infradead.org>, Juergen Gross <jgross@suse.com>, "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>, x86@kernel.org
Message-ID: <20170119091012.mlw6dLQgTHaiO7GBdA9iJPrj5JBMTOJNoSTCd3Eiz6I@z>

On Thu, Jan 12, 2017 at 11:06:54AM -0800, Bart Van Assche wrote:
> Some but not all architectures provide set_dma_ops(). Move dma_ops
> from struct dev_archdata into struct device such that it becomes
> possible on all architectures to configure dma_ops per device.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: x86@kernel.org


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
