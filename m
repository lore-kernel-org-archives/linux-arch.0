From: David Miller <davem@davemloft.net>
Subject: Re: Do we use runtime patching of function calls somewhere?
Date: Sun, 13 May 2012 14:28:52 -0400 (EDT)
Message-ID: <20120513.142852.1892620394548661049.davem@davemloft.net>
References: <20120513121600.GA15708@merkur.ravnborg.org>
	<20120513142935.GC18390@parisc-linux.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:49402 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab2EMS27 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 13 May 2012 14:28:59 -0400
In-Reply-To: <20120513142935.GC18390@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: matthew@wil.cx
Cc: sam@ravnborg.org, linux-arch@vger.kernel.org

From: Matthew Wilcox <matthew@wil.cx>
Date: Sun, 13 May 2012 08:29:35 -0600

> On Sun, May 13, 2012 at 02:16:00PM +0200, Sam Ravnborg wrote:
>> Do we have any archs that does runtime patching of function calls?
> 
> Isn't this a slightly easier version of the x86 altinstructions mechanism?

Nope, altinstructions patches the implementation.

Sparc wants to patch the call sites.

Basically, run time linking of function calls.
