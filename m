Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S261517AbULFMpy@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27368 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261508AbULFMpy
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 6 Dec 2004 07:45:54 -0500
Received: from willy by www.linux.org.uk with local (Exim 4.33)
	id 1CbIFV-0007gs-TI
	for linux-arch@vger.kernel.org; Mon, 06 Dec 2004 12:45:53 +0000
Date: Mon, 6 Dec 2004 12:45:53 +0000
From: Matthew Wilcox <matthew@wil.cx>
Subject: mask_irq
Message-ID: <20041206124553.GM15450@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: <willy@www.linux.org.uk>
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


I don't know when it happened, but mask_irq() is no longer required
as an interface.  The following architectures still define and/or use
it internally:

arm arm26 cris mips parisc ppc ppc64 sh sh64 x86_64

Arch maintainers may want to see if they can get rid of it.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
