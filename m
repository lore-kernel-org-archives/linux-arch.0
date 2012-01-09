From: David Miller <davem@davemloft.net>
Subject: Re: why doesn't x86_32 have the accept4() syscall?
Date: Mon, 09 Jan 2012 13:36:40 -0800 (PST)
Message-ID: <20120109.133640.1785167474272651414.davem@davemloft.net>
References: <CA+8MBbLe5uC4gMg9vySTWYUsNv=P-9spnNbKsFAZqQCT_Wk+YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:36210 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755486Ab2AIVgn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2012 16:36:43 -0500
In-Reply-To: <CA+8MBbLe5uC4gMg9vySTWYUsNv=P-9spnNbKsFAZqQCT_Wk+YQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tony.luck@intel.com
Cc: linux-arch@vger.kernel.org


Because accept4() has been provided via the sys_socketcall() indirect
operation, for this socket system call and several others the native
direct syscalls were never added to the x86 32-bit table and probably
never will be.
