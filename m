From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: start_kernel(): bug: interrupts were enabled early
Date: Thu, 01 Apr 2010 09:36:53 +1100
Message-ID: <1270075013.7101.78.camel@pasglop>
References: <20100325194100.GA2364@debian>
	 <20100331134048.da4e35a7.akpm@linux-foundation.org>
	 <4BB3B4DB.7040904@kernel.org> <20100331210145.GB32165@parisc-linux.org>
	 <4BB3B8FC.1020608@zytor.com> <20100331211754.GC32165@parisc-linux.org>
	 <alpine.DEB.2.00.1003311640410.30456@router.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:58294 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755817Ab0CaWiA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Mar 2010 18:38:00 -0400
In-Reply-To: <alpine.DEB.2.00.1003311640410.30456@router.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux-foundation.org>
Cc: Matthew Wilcox <matthew@wil.cx>, "H. Peter Anvin" <hpa@zytor.com>, Yinghai Lu <yinghai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Rabin Vincent <rabin@rab.in>, lkml <linux-kernel@vger.kernel.org>, penberg@cs.helsinki.fi, linux-arch@vger.kernel.org

On Wed, 2010-03-31 at 16:42 -0500, Christoph Lameter wrote:
> 
> Do not run the checks while we are in a single threaded context?
> 
> I thought we had some dynamic code patching thingamy that could change
> those when we go to smp mode? 

The problem isn't about checks. Those -will- enable IRQs before it's
safe to do so, the checks are perfectly right to point it out, it -is- a
bug waiting to happen on some random HW.

Cheers,
Ben.
