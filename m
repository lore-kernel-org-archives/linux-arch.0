Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:45213 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965344AbWIREbG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Sep 2006 00:31:06 -0400
Date: Sun, 17 Sep 2006 21:31:00 -0700
From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [patch 1/1] make PROT_WRITE imply PROT_READ
Message-ID: <20060918043100.GA15828@tuatara.stupidest.org>
References: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net> <20060917202408.GA10031@tuatara.stupidest.org> <1158527646.6069.67.camel@localhost.localdomain> <20060918005723.GB12662@tuatara.stupidest.org> <17677.65159.433214.4524@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17677.65159.433214.4524@cargo.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org, linux-arch@vger.kernel.org, jbaron@redhat.com, ak@muc.de, arjan@linux.intel.com, benh@kernel.crashing.org, geert@linux-m68k.org, hugh@veritas.com, kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, rmk@arm.linux.org.uk, spyro@f2s.com, tony.luck@intel.com, zippel@linux-m68k.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Sep 18, 2006 at 12:03:51PM +1000, Paul Mackerras wrote:

> I think the problem is that these applications break randomly,

which means they are broken surely?

> depending on exactly when page faults happen, and these patches make
> the behaviour consistent and deterministic.

so would detecting PROT_WRITE w/o PROT_READ and returning -EINVAL
surely then?

it would still be broken so no loss there and we wouldn't have to make
such a long term change
