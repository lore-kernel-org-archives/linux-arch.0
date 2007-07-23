Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:49868 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765615AbXGWJvl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Jul 2007 05:51:41 -0400
Subject: Re: [patch] bitops: lock bitops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20070723061642.GA7559@wotan.suse.de>
References: <20070712031419.GF32414@wotan.suse.de>
	 <1185170792.5439.105.camel@localhost.localdomain>
	 <20070723061642.GA7559@wotan.suse.de>
Content-Type: text/plain
Date: Mon, 23 Jul 2007 19:50:55 +1000
Message-Id: <1185184255.5439.109.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paul Mackerras <paulus@samba.org>, tony.luck@intel.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2007-07-23 at 08:16 +0200, Nick Piggin wrote:
> 
> OK, I'll mention that in the ppc code... but generic code shouldn't
> rely on this anyway, right? (Or was it decided that spinlocks must
> fence IO?).
> 
> Would _io postfixed locks be a sane way to handle this? 

It's unclear what spinlocks are supposed to do, but for ppc, I decided
to be safe and put the fencing implicitely in spin_unlock.

Ben.


