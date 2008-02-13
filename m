Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:41657
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752867AbYBMAag (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Feb 2008 19:30:36 -0500
Date: Tue, 12 Feb 2008 16:31:07 -0800 (PST)
Message-Id: <20080212.163107.89231473.davem@davemloft.net>
Subject: Re: Announce: Linux-next (Or Andrew's dream :-))
From: David Miller <davem@davemloft.net>
In-Reply-To: <alpine.LFD.1.00.0802121011280.2920@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0802120847500.2920@woody.linux-foundation.org>
	<20080212174824.GA1919@kroah.com>
	<alpine.LFD.1.00.0802121011280.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: greg@kroah.com, jeff@garzik.org, arjan@infradead.org, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Feb 2008 10:26:53 -0800 (PST)

> We absolutely MUST NOT have the mindset that "cross-subsystem conflicts 
> happen all the time". 

Perhaps not, but self-conflicts are the bigger issue for the
networking.

If I (or Jeff or John) push a bug fix to you outside of the merge
window, that blows the entire development tree because at 1500+
changesets I can guarentee you there will be a merge conflict
somewhere.

Near the end of 2.6.24 every bug fix I merged to you created a
conflict with my net-2.6.25 tree.  Every time I rebased there
were on the order of 10 to 20 patches with merge conflicts to
resolve.

