Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:44539 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbcFLEnD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 12 Jun 2016 00:43:03 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 3748C47AC9A
	for <linux-arch@vger.kernel.org>; Sun, 12 Jun 2016 06:38:22 +0200 (CEST)
Date: Sat, 11 Jun 2016 21:38:10 -0700
From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: undefined reference to `printk'
Message-ID: <20160612043810.GA1326@x>
References: <201606121058.3CeznQLn%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201606121058.3CeznQLn%fengguang.wu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, kbuild test robot <fengguang.wu@intel.com>
Message-ID: <20160612043810.ejyThmbX989tc9WEge77OzanXTL6rTVumet9A9w9cjI@z>

[Adding LKML, linux-arch, and Linus.]

On Sun, Jun 12, 2016 at 10:17:01AM +0800, kbuild test robot wrote:
> All errors (new ones prefixed by >>):
> 
>    arch/m32r/kernel/built-in.o: In function `default_eit_handler':
> >> (.text+0x3f8): undefined reference to `printk'
>    arch/m32r/kernel/built-in.o: In function `default_eit_handler':
>    (.text+0x3f8): relocation truncated to fit: R_M32R_26_PCREL_RELA against undefined symbol `printk'

As far as I can tell, there has been a patch available for this for
months, and it still doesn't seem to have been applied anywhere.

m32r is listed in MAINTAINERS as "Orphan", and has been since commit
b4174867bee83e79dc155479cb1b67c452da6476 in 2014.  And that commit
in turn observed no commits from the maintainer since 2009.  Looking at
the log for arch/m32r, I don't see any activity other than random fixes
by others, and based on the signoffs, all of those seem to go through
miscellaneous trees.

Is anyone using m32r?  Is anyone willing to maintain it?  And if not,
should we consider removing it?

- Josh Triplett
