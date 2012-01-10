From: Jamie Lokier <jamie@shareable.org>
Subject: Re: why doesn't x86_32 have the accept4() syscall?
Date: Tue, 10 Jan 2012 16:03:17 +0000
Message-ID: <20120110160317.GC7180@jl-vm1.vm.bytemark.co.uk>
References: <CA+8MBbLe5uC4gMg9vySTWYUsNv=P-9spnNbKsFAZqQCT_Wk+YQ@mail.gmail.com>
 <20120109.133640.1785167474272651414.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.shareable.org ([80.68.89.115]:43505 "EHLO
	mail2.shareable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756476Ab2AJQaf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jan 2012 11:30:35 -0500
Content-Disposition: inline
In-Reply-To: <20120109.133640.1785167474272651414.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: tony.luck@intel.com, linux-arch@vger.kernel.org

David Miller wrote:
> Because accept4() has been provided via the sys_socketcall() indirect
> operation, for this socket system call and several others the native
> direct syscalls were never added to the x86 32-bit table and probably
> never will be.

Hi David,

Is there any reason why it was added via sys_socketcall() - isn't that
just a waste of a few cycles and kernel size, compared with a direct
pointer in the syscall table?

I see sendmmsg() and recvmmsg() got proper syscall slots on x86
32-bit, and are in sys_socketcall() as well, which seems a bit pointless.

Thanks,
-- Jamie
