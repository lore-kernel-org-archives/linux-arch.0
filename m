From: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Subject: Re: [RFC][PATCHSET] mremap/mmap mess
Date: Wed, 9 Dec 2009 14:36:42 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0912091434490.30748@sister.anvils>
References: <20091208060701.GM14381@ZenIV.linux.org.uk>
 <Pine.LNX.4.64.0912081142280.31223@sister.anvils> <Pine.LNX.4.64.0912081254500.3365@sister.anvils>
 <20091208.130802.25121122.davem@davemloft.net> <20091208220638.GN14381@ZenIV.linux.org.uk>
 <Pine.LNX.4.64.0912091041250.23659@sister.anvils> <20091209134620.GR14381@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mk-filter-2-a-1.mail.uk.tiscali.com ([212.74.100.53]:49226 "EHLO
	mk-filter-2-a-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750936AbZLIOgp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Dec 2009 09:36:45 -0500
In-Reply-To: <20091209134620.GR14381@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: David Miller <davem@davemloft.net>, Ollie Wild <aaw@google.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, viro@ftp.linux.org.uk, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org

On Wed, 9 Dec 2009, Al Viro wrote:
> 
> Anyway, it's obviously *not* -rc1 fodder at the moment.  So what I'm going
> to do is to leave that one as it is in mainline, push the rest of mmap/mremap
> stuff to Linus later today

Phew, yes, agreed!

Hugh
