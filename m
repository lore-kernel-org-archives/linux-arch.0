From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 11/18] sparc32: propagate the calling conventions
 change down to __csum_partial_copy_sparc_generic()
Date: Tue, 21 Jul 2020 18:20:59 -0700 (PDT)
Message-ID: <20200721.182059.991648189839997678.davem@davemloft.net>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
        <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
        <20200721202549.4150745-11-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGVBVE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 21:21:04 -0400
In-Reply-To: <20200721202549.4150745-11-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: viro@ZenIV.linux.org.uk
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Tue, 21 Jul 2020 21:25:42 +0100

> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> ... and get rid of zeroing the target, etc. on fault.
> All exception handlers merge into one; moreover, since we are not
> calling lookup_fault() anymore, we don't need the magic with passing
> arguments for it from the page fault handler.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: David S. Miller <davem@davemloft.net>
