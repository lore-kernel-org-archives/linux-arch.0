From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 02/15] bitops: Change the bitmap index from int to unsigned long [arm]
Date: Wed, 25 Feb 2009 22:41:15 +0000
Message-ID: <20090225224115.GD18712@flint.arm.linux.org.uk>
References: <200902250442.UAA12563@hpdst41.cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52388 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761872AbZBYWok (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2009 17:44:40 -0500
Content-Disposition: inline
In-Reply-To: <200902250442.UAA12563@hpdst41.cup.hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Justin Chen <jchen@hpdst41.cup.hp.com>
Cc: linux-arch@vger.kernel.org, ben-linux@fluff.org, bjorn.helgaas@hp.com, dan.j.williams@intel.com, justin.chen@hp.com, kernel@pengutronix.de, kernel@wantstofly.org, linux-kernel@vger.kernel.org, linux@maxim.org.za, mcuos.com@gmail.com

On Tue, Feb 24, 2009 at 08:42:52PM -0800, Justin Chen wrote:
> Change the index to unsigned long in all bitops for [arm]
> 
> Signed-off-by: Justin Chen <justin.chen@hp.com>
> Reviewed-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
