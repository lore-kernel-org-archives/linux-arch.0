From: David Miller <davem@davemloft.net>
Subject: Re: CONFIG_HAVE_ARCH_TRACEHOOK and you
Date: Fri, 12 Sep 2008 15:40:15 -0700 (PDT)
Message-ID: <20080912.154015.93377289.davem@davemloft.net>
References: <20080912223156.51D4815420D@magilla.localdomain>
	<20080912.153703.21849753.davem@davemloft.net>
	<20080912223926.5EF0715420D@magilla.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:47236
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753641AbYILWkV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 12 Sep 2008 18:40:21 -0400
In-Reply-To: <20080912223926.5EF0715420D@magilla.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: roland@redhat.com
Cc: rmk+lkml@arm.linux.org.uk, linux-arch@vger.kernel.org, utrace-devel@redhat.com, linux-kernel@vger.kernel.org

From: Roland McGrath <roland@redhat.com>
Date: Fri, 12 Sep 2008 15:39:26 -0700 (PDT)

> > It was allocating too much memory, which is harmless.
> 
> Didn't it also write NT_PRFPREG notes of the wrong size?

Yep, but gdb was "generous in what it received" and happily
read the contents.
