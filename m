From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC][PATCHSET] regset ->get() rework
Date: Thu, 23 Jul 2020 18:27:37 +0100
Message-ID: <20200723172737.GJ2786714@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200723080029.GA5815@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgGWR1s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 13:27:48 -0400
Content-Disposition: inline
In-Reply-To: <20200723080029.GA5815@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>

On Thu, Jul 23, 2020 at 09:00:29AM +0100, Christoph Hellwig wrote:
> Hi Al,
> 
> what's the state of the series?  I noticed it hasn't shown up in
> linux-next so far.

It (as well as fdpic coredump stuff) will go into -next as soon as I post
the second variant of csum_and_copy stuff (later today).
