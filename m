From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] linux++, this: rename "struct notifier_block *this"
Date: Fri, 19 Jun 2020 00:46:31 -0700
Message-ID: <20200619074631.GA1427@infradead.org>
References: <20200618210645.GB2212102@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbgFSHqf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jun 2020 03:46:35 -0400
Content-Disposition: inline
In-Reply-To: <20200618210645.GB2212102@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-arch@vger.kernel.org, netfilter-devel@vger.kernel.org

On Fri, Jun 19, 2020 at 12:06:45AM +0300, Alexey Dobriyan wrote:
> Rename
> 	struct notifier_block *this
> to
> 	struct notifier_block *nb
> 
> "nb" is arguably a better name for notifier block.

But not enough better to cause tons of pointless churn.  Feel free
to use better naming in new code you write or do significant changes
to, but stop these pointless renames.
