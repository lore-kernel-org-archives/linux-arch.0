Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:56847 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757575AbXFESia convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jun 2007 14:38:30 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: volatile and atomic_t/spinlock_t
Date: Tue, 5 Jun 2007 11:38:27 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A019DD5B5@scsmsx411.amr.corp.intel.com>
In-Reply-To: <20070605114813.GA17048@osiris.boeblingen.de.ibm.com>
From: "Luck, Tony" <tony.luck@intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> So is
>
>	while (__raw_spin_is_locked(&v));
>
> supposed to work? Or should that be 
>
>	while (__raw_spin_is_locked(&v))
>		cpu_relax();
>
> as well and all the volatiles can/should go away?

cpu_relax() is a really good idea in every spinloop on
hyper-threaded cores.  It lets the h/w know that we aren't
doing anything useful here, so resources and power can be
diverted to other threads sharing the core.

Avoiding the need for volatile or other compiler optimizer
defeating tricks is a side benefit.

-Tony
