From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Change long to unsigned long in ptrace functions to
 fix sparse warnings
Date: Thu, 01 May 2008 16:16:08 -0700 (PDT)
Message-ID: <20080501.161608.150609265.davem@davemloft.net>
References: <18458.19939.138289.173048@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38608
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1760117AbYEAXQJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 May 2008 19:16:09 -0400
In-Reply-To: <18458.19939.138289.173048@cargo.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulus@samba.org
Cc: linux-arch@vger.kernel.org, roland@redhat.com, akpm@linux-foundation.org

From: Paul Mackerras <paulus@samba.org>
Date: Fri, 2 May 2008 09:10:27 +1000

> Sparse warns every time we have an (unsigned long __user *) cast on a
> long (not unsigned long) variable.  This happens frequently in the
> ptrace code because the addr and data arguments to sys_ptrace,
> ptrace_request, arch_ptrace et al. are long rather than unsigned long.
> 
> There doesn't seem to be any good reason not to have them be unsigned,
> so this changes them from long to unsigned long.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Thanks for fixing this:

Acked-by: David S. Miller <davem@davemloft.net>

I thought there might be some cases that cared about
negative values of 'addr', but I can't see any.
