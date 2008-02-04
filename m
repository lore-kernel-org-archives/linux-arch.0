Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42105 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751372AbYBDLOf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Feb 2008 06:14:35 -0500
Date: Mon, 4 Feb 2008 03:14:15 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 2/3] CONFIG_HIGHPTE vs. sub-page page tables.
Message-Id: <20080204031415.c7d9816e.akpm@linux-foundation.org>
In-Reply-To: <20080204110238.GB2791@flint.arm.linux.org.uk>
References: <20071112143009.425807965@de.ibm.com>
	<20071112144009.831296895@de.ibm.com>
	<20080201151541.8e3e0359.akpm@linux-foundation.org>
	<1202017020.7208.2.camel@pasglop>
	<20080202215315.3ac6907d.akpm@linux-foundation.org>
	<1202121409.31801.7.camel@localhost>
	<20080204025133.511ac3e2.akpm@linux-foundation.org>
	<20080204110238.GB2791@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: schwidefsky@de.ibm.com, benh@kernel.crashing.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

On Mon, 4 Feb 2008 11:02:38 +0000 Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> I don't see any end to these bun fights at the start of the merge window.
> I believe it's inevitable given the work flow that we're now using.

I'm trying to find someone who will run an merged tree of all the
subsystems (I dub it "linux-next").  Subsystem maintainers will put their
2.6.x+1 material into branches or quilt directories for that tree.

Once that person is found and the system is up and running we can solicit
testing of that tree - it's basically like -mm without the -mm bits. 
Obviously I'll be able to put a lot of -mm in there too (uml, fbdev, etc,
etc).

Right now, the merge practices of the subsystem maintainers will drive that
person insane, so some pushback will be needed to make it practical.

None of which is really relevant to your complaint.  But if/when linux-next
is running, we can do more things around it.  One might be "if a non-bugfix
patch wasn't in linux-next one week prior to 2.6.x, it doesn't get merged
into 2.6.x+1".  For example.

