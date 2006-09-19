Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36256
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751373AbWISWxM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Sep 2006 18:53:12 -0400
Date: Tue, 19 Sep 2006 15:53:17 -0700 (PDT)
Message-Id: <20060919.155317.22126004.davem@davemloft.net>
Subject: Re: generic__raw_read_trylock Considered Harmful
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060831134254.GE4919@parisc-linux.org>
References: <20060831134254.GE4919@parisc-linux.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: matthew@wil.cx
Cc: linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, takata@linux-m32r.org, lethal@linux-sh.org, kkojima@rr.iij4u.or.jp, linuxsh-dev@lists.sourceforge.net, wli@holomorphy.com, sparclinux@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Matthew Wilcox <matthew@wil.cx>
Date: Thu, 31 Aug 2006 07:42:55 -0600

> NOTE to architecture maintainers: generic_raw_read_trylock() is
> completely unfit for use and will cause lockups if used in interrupt
> context.

I was about to go an fix SPARC but then looked in the tree
for actual users, and I see one, and only one, in the lockdep
code which tries to grab the tasklist_lock.

That's it (well.. there's one strange IA64 specific case in the MCA
code too).

You say you were fixing up PARISC and actually hit this problem, was
it exactly this lockdep case?  I really doubt it...

