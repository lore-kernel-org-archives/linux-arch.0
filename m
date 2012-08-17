From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 07/31] arm64: Process management
Date: Fri, 17 Aug 2012 17:15:28 +0100
Message-ID: <20120817161528.GK24389@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-8-git-send-email-catalin.marinas@arm.com>
 <201208151353.01367.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:38154 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758337Ab2HQQQB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Aug 2012 12:16:01 -0400
Content-Disposition: inline
In-Reply-To: <201208151353.01367.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>

On Wed, Aug 15, 2012 at 02:53:01PM +0100, Arnd Bergmann wrote:
> On Tuesday 14 August 2012, Catalin Marinas wrote:
> 
> > +#define THREAD_SIZE_ORDER	1
> > +#define THREAD_SIZE		8192
> > +#define THREAD_START_SP		(THREAD_SIZE - 16)
> 
> THREAD_SIZE_ORDER looks wrong for 64kb-page kernels. It also doesn't seem to
> be used, so better remove it.

It's used in kernel/fork.c if THREAD_SIZE >= PAGE_SIZE. I'll define it
conditionally.

-- 
Catalin
