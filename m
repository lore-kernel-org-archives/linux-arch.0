Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268052AbUJOPaT@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:3514 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267976AbUJOPaS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Oct 2004 11:30:18 -0400
Date: Fri, 15 Oct 2004 17:21:12 +0200
From: Andi Kleen <ak@suse.de>
Subject: 4level page tables architecture porting
Message-Id: <20041015172112.73e884d9.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: akpm@digeo.com
List-ID: <linux-arch.vger.kernel.org>


ftp://ftp.suse.com/pub/people/ak/4level/4level-2.6.9rc4-2.gz 

now compiles and boots on x86-64, i386, ia64. alpha, ppc64, ppc compile too,
but missing hardware I'm still waiting for testers for that.

If anybody could do the conversion for their port and send me
the diff it would be very appreciated. It should be quite straight forward.

Thanks,

-Andi
