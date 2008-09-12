From: David Miller <davem@davemloft.net>
Subject: Re: CONFIG_HAVE_ARCH_TRACEHOOK and you
Date: Fri, 12 Sep 2008 15:37:03 -0700 (PDT)
Message-ID: <20080912.153703.21849753.davem@davemloft.net>
References: <20080912025733.E55F415420D@magilla.localdomain>
	<20080912131351.GA31545@flint.arm.linux.org.uk>
	<20080912223156.51D4815420D@magilla.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:47228
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754891AbYILWhJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 12 Sep 2008 18:37:09 -0400
In-Reply-To: <20080912223156.51D4815420D@magilla.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: roland@redhat.com
Cc: rmk+lkml@arm.linux.org.uk, linux-arch@vger.kernel.org, utrace-devel@redhat.com, linux-kernel@vger.kernel.org

From: Roland McGrath <roland@redhat.com>
Date: Fri, 12 Sep 2008 15:31:56 -0700 (PDT)

> > means sparc ends up allocating 38 * sizeof(u32) * sizeof(u32), and
> > sparc64 ends up with 36 * sizeof(u64) * sizeof(u64), which must surely
> > be wrong?
> 
> Yup!  Sure looks like Dave skipped the step where it says "test that core
> dumps work ... and produce correct results". :-)

It was allocating too much memory, which is harmless.

So it did work, and I did test it.
