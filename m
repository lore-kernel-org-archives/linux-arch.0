Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:34463 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964786AbWEJHlY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 May 2006 03:41:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17505.39199.355967.509714@cargo.ozlabs.ibm.com>
Date: Wed, 10 May 2006 17:41:19 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
In-Reply-To: <20060509.233958.73723993.davem@davemloft.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510051649.GD1794@lixom.net>
	<17505.34919.750295.170941@cargo.ozlabs.ibm.com>
	<20060509.233958.73723993.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: olof@lixom.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org
List-ID: <linux-arch.vger.kernel.org>

David S. Miller writes:

> That first cache line of current_thread_info() should be so hot that
> it's probably just fine to use current_thread_info()->task since
> you're just doing a mask on a fixed register (r1) to implement that.

I tried that, but I found that adding 1 instruction to the sequence
for getting current adds about 8k to the kernel text.  Currently we do
it in one instruction, that would be two - the mask and the load.  It
probably doesn't make a measurable difference to performance, but it
doesn't look good.  The number of instructions we lose by using
__thread is much less than the 8k we gain from using
current_thread_info()->task for current.  So I'd prefer to use a
per-cpu variable for current, since we can get to that in 1
instruction.

Paul.
