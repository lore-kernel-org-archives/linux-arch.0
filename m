From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] asm-generic/io.h: reorder funtions to form logical groups
Date: Sat, 2 Aug 2014 00:42:28 +0200
Message-ID: <20140801224228.GA25980@ravnborg.org>
References: <1405508484-18303-1-git-send-email-thierry.reding@gmail.com>
 <20140718205953.GA21964@ravnborg.org>
 <20140719125937.GA18566@ravnborg.org>
 <20140801140956.GA1913@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:34587 "EHLO
	asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756136AbaHAWmh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Aug 2014 18:42:37 -0400
Content-Disposition: inline
In-Reply-To: <20140801140956.GA1913@ulmo.nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@codeaurora.org>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

> 
> Oh, by the way: would you prefer that I keep your patch separate or
> shall I just squash it into the one that has the major asm-generic/io.h
> cleanup?
Do whatever is the most convinient for you.
And do not bother with any attribution and such for such a simple patch.

	Sam
