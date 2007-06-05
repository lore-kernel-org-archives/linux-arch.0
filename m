Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:10606 "EHLO
	mtagate1.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765677AbXFEWR7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jun 2007 18:17:59 -0400
Date: Wed, 6 Jun 2007 00:17:36 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: volatile and atomic_t/spinlock_t
Message-ID: <20070605221736.GA9315@osiris.ibm.com>
References: <20070605114813.GA17048@osiris.boeblingen.de.ibm.com> <617E1C2C70743745A92448908E030B2A019DD5B5@scsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <617E1C2C70743745A92448908E030B2A019DD5B5@scsmsx411.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jun 05, 2007 at 11:38:27AM -0700, Luck, Tony wrote:
> > So is
> >
> >	while (__raw_spin_is_locked(&v));
> >
> > supposed to work? Or should that be 
> >
> >	while (__raw_spin_is_locked(&v))
> >		cpu_relax();
> >
> > as well and all the volatiles can/should go away?
> 
> cpu_relax() is a really good idea in every spinloop on
> hyper-threaded cores.  It lets the h/w know that we aren't
> doing anything useful here, so resources and power can be
> diverted to other threads sharing the core.
> 
> Avoiding the need for volatile or other compiler optimizer
> defeating tricks is a side benefit.

Currently it is already that it has to be

	while (__raw_spin_is_locked(&v))
		cpu_relax();

Just like in __raw_spin_unlock_wait(). Oh well, I should have
checked more before posting...
