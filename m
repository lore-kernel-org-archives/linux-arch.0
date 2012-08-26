Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:56578 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab2HZEtk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 26 Aug 2012 00:49:40 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 21/31] arm64: 32-bit (compat) applications support
Date: Sun, 26 Aug 2012 04:49:32 +0000
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <201208151434.05145.arnd@arndb.de> <20120824104338.GI7585@arm.com>
In-Reply-To: <20120824104338.GI7585@arm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201208260449.32807.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>
Message-ID: <20120826044932.ioPUmpjGKz60dCHfQiZXy5bi6PuN-3OdvU0kelt58oY@z>

On Friday 24 August 2012, Catalin Marinas wrote:
> > What good is the run-time BUG() here? Nothing should be calling these
> > when CONFIG_COMPAT is disabled, so I think you should just remove
> > the #ifdef around the declarations, and the entire #else case.
> 
> They are called from handle_signal(), so that's to avoid #ifdef inside
> functions. I can drop the BUG() (but keep the empty function) and
> change the checks to is_compat_task() so that the compiler optimises the
> condition out when !COMPAT.
> 

Sounds good. Note that you can turn a lot of #ifdef into
if(IS_ENABLED(CONFIG_FOO)) as well, even if there is no other runtime
check for them.

	Arnd
