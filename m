From: Andi Kleen <andi@firstfloor.org>
Subject: Please include const-sections into linux-next
Date: Fri, 14 Oct 2011 01:38:18 +0200
Message-ID: <20111013233818.GB26654@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:58105 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717Ab1JMXiW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 13 Oct 2011 19:38:22 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Stephen,

Please include 
git://github.com/andikleen/linux-misc.git const-sections
in linux-next. This has a tree sweep to fix all kind of constant 
section issues.

I intend to send Linus a pull request next cycle and would like 
to get some testing in next first.

I got various acks last time it was posted and added them all.
In general it falls more in the "trivial" category, but it's 
rather large and all over so I may have made a mistake.

Thanks,

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
