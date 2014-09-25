Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:64628 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305AbaIYO5I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Sep 2014 10:57:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 0/8] asm-generic/io.h overhaul
Date: Thu, 25 Sep 2014 16:56:53 +0200
Message-ID: <3399763.VZ83zCGta1@wuerfel>
In-Reply-To: <20140924060419.GA20253@ulmo>
References: <1407925738-26170-1-git-send-email-thierry.reding@gmail.com> <20140825112630.GA4163@ulmo.nvidia.com> <20140924060419.GA20253@ulmo>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Sam Ravnborg <sam@ravnborg.org>
Message-ID: <20140925145653.35OTgIN4rtPSEG5bW2LJtSFHvY2Ze9N1Of5byy7kd3k@z>

On Wednesday 24 September 2014 08:04:21 Thierry Reding wrote:
> > 
> > Arnd, do you think this looks good to take for test-driving in
> > linux-next?
> 
> Ping?
> 

I've put it all into the asm-generic tree, and Will's patches on top.
Unless I get complaints, I plan to submit them all for 3.18.

	Arnd
