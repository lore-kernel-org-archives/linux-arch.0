From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 23/24] C6X: Power and Sleep Controller
Date: Mon, 22 Aug 2011 17:32:22 -0400
Message-ID: <1314048743.2404.32.camel@deneb.redhat.com>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com>
	 <1314043785-2880-24-git-send-email-msalter@redhat.com>
	 <2590242.9BfSTyhCik@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:65513 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753881Ab1HVVc1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Aug 2011 17:32:27 -0400
In-Reply-To: <2590242.9BfSTyhCik@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

On Mon, 2011-08-22 at 23:20 +0200, Arnd Bergmann wrote:
> I think this should be a proper driver instead, using a struct platform_driver
> and a match table instead the hacky of_find_compatible_node. That is generally
> the preferred approach for any nonessential code that can be initialized later
> and is not referenced by core code. As far as I can tell, this is the case
> here, though I could not actually find the callers so far.

The soc-64*.c files are the only place using it right now. I think this
really should be wired into the clock code so clk_enable/disable control
the PSC states as well. At least that is what arm/mach-davinci does with
similar hardware. The PSC unit controls power to certain peripherals but
it also controls clock gating for some of them.

--Mark
