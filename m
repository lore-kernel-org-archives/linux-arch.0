From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: DMA from user space buffer/VIPT cache flushing wows (was:
	Minutes: 21 Sept,09 RMK meeting)
Date: Wed, 11 Nov 2009 13:50:09 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B949329@dlee02.ent.ti.com>
References: <20091027163551.GA1446@flint.arm.linux.org.uk>
 <20091028.143432.241464826.Hiroshi.DOYU@nokia.com>
 <20091028174920.GA20945@flint.arm.linux.org.uk>
 <20091029.151251.45877478.Hiroshi.DOYU@nokia.com>
 <20091029133703.GA3860@flint.arm.linux.org.uk>
 <20091106151558.GA7986@localhost>
 <20091108184753.GA31433@flint.arm.linux.org.uk>
 <20091109001509.GB28928@localhost>
 <20091109101056.GA29621@flint.arm.linux.org.uk>
 <20091110160334.GE734@localhost>
 <20091111192945.GA31608@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47490 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758821AbZKKTuY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Nov 2009 14:50:24 -0500
In-Reply-To: <20091111192945.GA31608@flint.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>, Imre Deak <imre.deak@nokia.com>
Cc: Paul Mundt <lethal@linux-sh.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "tony@atomide.com" <tony@atomide.com>, "rak@arm.linux.org.uk" <rak@arm.linux.org.uk>, "Joshi, Rhishi" <rhishi@ti.com>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>


> From: Russell King [mailto:rmk@arm.linux.org.uk]
> Sent: Wednesday, November 11, 2009 8:30 PM

> It is *not* a generic interface for kernel drivers to use.  That's why
> I ignored your comment about kernel interfaces for flusing userspace
> buffers.  It's just not relevant to the problem at hand.

It does solve our specific problem.  Thanks Russell.

It is several peoples stance it is not the greatest generic API.  There isn't any alternate solution yet identified/proposed.

Some architectures like AVR32 do implement the selective flush for the easier icache side of sys_cacheflush.

Regards,
Richard W.
