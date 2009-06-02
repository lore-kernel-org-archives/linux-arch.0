From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [Ksummit-2009-discuss] Representing Embedded Architectures at
	the Kernel Summit
Date: Tue, 2 Jun 2009 23:34:52 +0200
Message-ID: <20090602213452.GK32630@pengutronix.de>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <20090602172941.GL3095@hansolo.jdub.homelinux.org> <1243964577.4229.49.camel@mulgrave.int.hansenpartnership.com> <20090602175244.GB10973@cuplxvomd02.corp.sa.net> <20090602185143.GA8655@zod.rchland.ibm.com> <4A257DF0.6040607@am.sony.com> <1243975064.6342.10.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-embedded-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1243975064.6342.10.camel@mulgrave.site>
Sender: linux-embedded-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Tim Bird <tim.bird@am.sony.com>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, linux-arch@vger.kernel.org, ksummit-2009-discuss@lists.linux-foundation.org, linux-embedded@vger.kernel.org, David VomLehn <dvomlehn@cisco.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 02, 2009 at 03:37:44PM -0500, James Bottomley wrote:
> The topic of "flattened device tree" look interesting to me (perhaps
> because I'm a hardened device driver person and things like that
> always look interesting to me) ...

The recent oftree activities look indeed very promising; the different
boot-information-passing methods, mainly in powerpc and arm land, is
IMHO and important field where a generic kernel infrastructure would
make sense for the embedded people. Taken that oftree has created
robustness and compatiblity problems in the past but seems to move into
a good direction recently, feedback from core kernel developers would
certainly be a good thing.

> if we can get a few more like that out of the woodwork, this approach
> might end up being successful.

Could flickerfree-bootsplash be a topic? Or is that completely pushed
into the userspace these fastboot days?

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
