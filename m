From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] x86: PAT: Documentation: update overlapping ioremap hack
 recommendation
Date: Fri, 4 Mar 2016 13:09:00 -0800
Message-ID: <20160304210900.GT3577@linux.vnet.ibm.com>
References: <1457040108-27358-1-git-send-email-mcgrof@kernel.org>
 <20160303214233.GN3577@linux.vnet.ibm.com>
 <20160304192326.GU25240@wotan.suse.de>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e18.ny.us.ibm.com ([129.33.205.208]:42087 "EHLO
	e18.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759668AbcCDVJi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Mar 2016 16:09:38 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 4 Mar 2016 16:09:38 -0500
Content-Disposition: inline
In-Reply-To: <20160304192326.GU25240@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: bp@alien8.de, mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, toshi.kani@hp.com, airlied@redhat.com, benh@kernel.crashing.org, mst@redhat.com, vinod.koul@intel.com, jgross@suse.com, daniel.vetter@ffwll.ch, luto@amacapital.net, linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net

On Fri, Mar 04, 2016 at 08:23:26PM +0100, Luis R. Rodriguez wrote:
> On Thu, Mar 03, 2016 at 01:42:33PM -0800, Paul E. McKenney wrote:
> > On Thu, Mar 03, 2016 at 01:21:48PM -0800, Luis R. Rodriguez wrote:
> > > The current documentation refers to using set_memor_wc() as a
> > > possible hole strategy when you have overlapping ioremap() regions,
> > > that's incorrect as set_memory_*() helpers can only be used on RAM,
> > > not IO memory. This fixes that, and updates the documention to
> > > *strongly* discourage overlapping ioremap() memory uses, but also
> > > documents a possible solution should there really be no other
> > > option.
> > > 
> > > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> > 
> > Given an Acked-by or better from the guys on the TO line, I would be
> > happy to queue it.
> 
> I'll need to respin as fortunately I ended up actually not needing
> to do an overlap on atyfb, and instead just let MTRR be effective
> over an entire range that included both write-combining and strong
> UC attributes. It was a bit fuzzy as this while ago, and since its
> also obscure, its more reason to document now.
> 
> Will spin a v2.

Sounds good!

							Thanx, Paul
