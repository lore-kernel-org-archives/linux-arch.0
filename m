From: David Miller <davem@davemloft.net>
Subject: Re: why doesn't x86_32 have the accept4() syscall?
Date: Tue, 10 Jan 2012 12:07:24 -0800 (PST)
Message-ID: <20120110.120724.178373558788579377.davem@davemloft.net>
References: <CA+8MBbLe5uC4gMg9vySTWYUsNv=P-9spnNbKsFAZqQCT_Wk+YQ@mail.gmail.com>
	<20120109.133640.1785167474272651414.davem@davemloft.net>
	<20120110160317.GC7180@jl-vm1.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:45313 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab2AJUHd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jan 2012 15:07:33 -0500
In-Reply-To: <20120110160317.GC7180@jl-vm1.vm.bytemark.co.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: jamie@shareable.org
Cc: tony.luck@intel.com, linux-arch@vger.kernel.org

From: Jamie Lokier <jamie@shareable.org>
Date: Tue, 10 Jan 2012 16:03:17 +0000

> Is there any reason why it was added via sys_socketcall() - isn't that
> just a waste of a few cycles and kernel size, compared with a direct
> pointer in the syscall table?

Looks like an oversight, but one for which I don't think is worth
correcting.
