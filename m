From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 16/18] sparc64: propagate the calling convention
 changes down to __csum_partial_copy_...()
Date: Tue, 21 Jul 2020 18:21:08 -0700 (PDT)
Message-ID: <20200721.182108.566362185204376467.davem@davemloft.net>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
        <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
        <20200721202549.4150745-16-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGVBVJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 21:21:09 -0400
In-Reply-To: <20200721202549.4150745-16-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: viro@ZenIV.linux.org.uk
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Tue, 21 Jul 2020 21:25:47 +0100

> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> ... and rename them into csum_and_copy_...() - the wrappers become pointless.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: David S. Miller <davem@davemloft.net>
