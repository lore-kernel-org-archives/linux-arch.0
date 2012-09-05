From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 20/31] arm64: User access library function
Date: Wed, 5 Sep 2012 20:13:12 +0100
Message-ID: <20120905191312.GH24085@n2100.arm.linux.org.uk>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-21-git-send-email-catalin.marinas@arm.com> <201208151449.54834.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54401 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643Ab2IETN1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Sep 2012 15:13:27 -0400
Content-Disposition: inline
In-Reply-To: <201208151449.54834.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Aug 15, 2012 at 02:49:54PM +0000, Arnd Bergmann wrote:
> It's fairly unusual to have out of line get_user/put_user functions.
> What is the reason for this, other than copying from ARM?

Actually, we never used to out of line on ARM, and then I experimented,
and found there was a net benefit - not only in code size but also
there appeared to be a performance benefit by out of lining them.
