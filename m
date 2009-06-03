From: Greg KH <greg@kroah.com>
Subject: Re: [Ksummit-2009-discuss] Representing Embedded Architectures at
	the Kernel Summit
Date: Tue, 2 Jun 2009 20:35:35 -0700
Message-ID: <20090603033535.GA24291@kroah.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <20090602172941.GL3095@hansolo.jdub.homelinux.org> <1243964577.4229.49.camel@mulgrave.int.hansenpartnership.com> <20090602175244.GB10973@cuplxvomd02.corp.sa.net> <20090602185143.GA8655@zod.rchland.ibm.com> <4A257DF0.6040607@am.sony.com> <1243975064.6342.10.camel@mulgrave.site> <20090602213452.GK32630@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:54161 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754843AbZFCDjo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 2 Jun 2009 23:39:44 -0400
Content-Disposition: inline
In-Reply-To: <20090602213452.GK32630@pengutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, David VomLehn <dvomlehn@cisco.com>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Tim Bird <tim.bird@am.sony.com>, ksummit-2009-discuss@lists.linux-foundation.org

On Tue, Jun 02, 2009 at 11:34:52PM +0200, Robert Schwebel wrote:
> Could flickerfree-bootsplash be a topic? Or is that completely pushed
> into the userspace these fastboot days?

We have that working today, no in-kernel work needed other than the
already-present KMS stuff.  See the recent Moblin images for proof of
this.

thanks,

greg k-h
