From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: DMA from user space buffer/VIPT cache flushing wows (was:
	Minutes: 21 Sept,09 RMK meeting)
Date: Wed, 11 Nov 2009 19:29:45 +0000
Message-ID: <20091111192945.GA31608@flint.arm.linux.org.uk>
References: <20091027163551.GA1446@flint.arm.linux.org.uk> <20091028.143432.241464826.Hiroshi.DOYU@nokia.com> <20091028174920.GA20945@flint.arm.linux.org.uk> <20091029.151251.45877478.Hiroshi.DOYU@nokia.com> <20091029133703.GA3860@flint.arm.linux.org.uk> <20091106151558.GA7986@localhost> <20091108184753.GA31433@flint.arm.linux.org.uk> <20091109001509.GB28928@localhost> <20091109101056.GA29621@flint.arm.linux.org.uk> <20091110160334.GE734@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57441 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758514AbZKKT3w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Nov 2009 14:29:52 -0500
Content-Disposition: inline
In-Reply-To: <20091110160334.GE734@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Imre Deak <imre.deak@nokia.com>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-arch@vger.kernel.org, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "vikram.pandita@ti.com" <vikram.pandita@ti.com>, "tony@atomide.com" <tony@atomide.com>, "rak@arm.linux.org.uk" <rak@arm.linux.org.uk>, "rhishi@ti.com" <rhishi@ti.com>, "r-woodruff2@ti.com" <r-woodruff2@ti.com>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>

On Tue, Nov 10, 2009 at 06:03:34PM +0200, Imre Deak wrote:
> Additionally as I said we would need a kernel interface for flushing
> user space buffers and mlock is not exposed to drivers. For that we
> would also need to add reference counting for mlock.

Oh, and let me re-iterate: the purpose of the patch I supplied to Texas
was to solve _their_ specific problem, which is to get the DSP bridge
driver working.

It is *not* a generic interface for kernel drivers to use.  That's why
I ignored your comment about kernel interfaces for flusing userspace
buffers.  It's just not relevant to the problem at hand.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
