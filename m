From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/2] arm64: support initrd outside of mapped RAM
Date: Tue, 28 Jul 2015 16:14:47 +0100
Message-ID: <20150728151447.GF15213@leverpostej>
References: <1438093961-15536-1-git-send-email-msalter@redhat.com>
 <20150728145906.GE15213@leverpostej>
 <1438096069.14248.13.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59952 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749AbbG1PPR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 28 Jul 2015 11:15:17 -0400
Content-Disposition: inline
In-Reply-To: <1438096069.14248.13.camel@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

> > >  arch/arm64/kernel/setup.c           | 55 
> > > +++++++++++++++++++++++++++++++++++++
> > >  include/asm-generic/early_ioremap.h |  6 ++++
> > >  mm/early_ioremap.c                  | 22 +++++++++++++++
> > >  3 files changed, 83 insertions(+)
> > 
> > Any reason for not moving x86 over to the new generic version?
> 
> I have a patch to do that but I'm not sure how to contrive a
> testcase to exercise it.

The easiest option might be to hack up KVM tool [1] to load a kernel an
initrd at suitable addresses.

Otherwise I'm sure someone else must have a way of exercising this.

Mark.

[1] https://git.kernel.org/cgit/linux/kernel/git/will/kvmtool.git/
