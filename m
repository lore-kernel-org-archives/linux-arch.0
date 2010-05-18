From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/3] Mark the 'current' pointer register read-only when
 such a thing exists
Date: Tue, 18 May 2010 14:05:46 -0700 (PDT)
Message-ID: <20100518.140546.170125902.davem@davemloft.net>
References: <20100518164537.6194.73366.stgit@warthog.procyon.org.uk>
	<20100518164542.6194.451.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:48266
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751441Ab0ERVFh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 18 May 2010 17:05:37 -0400
In-Reply-To: <20100518164542.6194.451.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dhowells@redhat.com
Cc: oleg@redhat.com, linux-arch@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Tue, 18 May 2010 17:45:42 +0100

> Where the value of current is kept in a register, that register can be marked
> such that the pointer value is read only, e.g.:
> 
> 	register struct task_struct *const current asm("e2");
> 
> This prevents inadvertent assignment outside of assembly code.
> 
> This has been available on the MN10300 arch for a while now, and I've also
> tested it on the FRV arch.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Acked-by: David S. Miller <davem@davemloft.net>
