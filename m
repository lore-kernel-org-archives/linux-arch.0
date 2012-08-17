From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 02/31] arm64: Kernel booting and initialisation
Date: Fri, 17 Aug 2012 06:13:59 -0700
Message-ID: <20120817131358.GF11011@atomide.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-3-git-send-email-catalin.marinas@arm.com>
 <502E11B6.4020104@ti.com>
 <20120817100533.GE24389@arm.com>
 <CAMQu2gzz0j+SnxCY0u3H__H4U-Lor_xV-eyiMBSohCMngbkD2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:22763 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567Ab2HQNOE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Aug 2012 09:14:04 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gzz0j+SnxCY0u3H__H4U-Lor_xV-eyiMBSohCMngbkD2w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <Will.Deacon@arm.com>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120817 03:11]:
> On Fri, Aug 17, 2012 at 3:35 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> >
> > On Fri, Aug 17, 2012 at 10:41:10AM +0100, Santosh Shilimkar wrote:
> > >
> > > So you expect all the secondary CPUs to be in wakeup state and probably
> > > looping in WFE for a signal from kernel to boot. There is one issue
> > > with this requirement though. For large CPU system, you need to reset
> > > all the CPUs and hit this waiting loop. This will lead to large inrush
> > > current need at bootup which may be not be supported. To avoid this
> > > issue, secondary CPUs are kept in OFF state and then they are woken
> > > up from kernel one by one whenever they need to be brought into the
> > > system. This requirement should be considered.
> >
> > I agree, this part will be extended. That's one method that we currently
> > support and suitable to the model.
> >
> > The better method is the SMC standardisation that Charles Garcia-Tobin
> > has written (to be made available soon) and was presented at the last
> > Linaro Connect in HK. Given that the CPU power is usually controlled by
> > the secure side, we'll ask for an SMC to be issued for waking up
> > secondary CPUs, so it's up to the secure firmware to write the correct
> > hardware registers.
> >
> Thanks for the information. SMC standardization would indeed help
> to overcome some of these. Will wait for that information before
> next set of questions.

Yes please. If the SMC is not standardized for most calls at least,
we'll end up with a horrible mess of SoC specific calls like we
currently have. Related to that, the virtualization calls should be
also standardized so we don't end up with multiple different hypervisors
with different calls.

Regards,

Tony
