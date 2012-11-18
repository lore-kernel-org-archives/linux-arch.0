From: David Miller <davem@davemloft.net>
Subject: Re: sigaltstack fun
Date: Sun, 18 Nov 2012 16:18:33 -0500 (EST)
Message-ID: <20121118.161833.985081954687473276.davem@davemloft.net>
References: <20121118.140332.1273544560009594278.davem@davemloft.net>
	<20121118195921.GH16916@ZenIV.linux.org.uk>
	<20121118210253.GI16916@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:52542 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab2KRVSg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 18 Nov 2012 16:18:36 -0500
In-Reply-To: <20121118210253.GI16916@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: viro@ZenIV.linux.org.uk
Cc: torvalds@linux-foundation.org, monstr@monstr.eu, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Sun, 18 Nov 2012 21:02:53 +0000

> Are you OK with the patch below?  Should be the minimal fix, getting
> rid of those segfaults and converting to usual semantics here...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Yep, looks fine:

Acked-by: David S. Miller <davem@davemloft.net>
