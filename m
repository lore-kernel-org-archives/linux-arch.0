From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: Enhancing semantics with memremap() - aliasing with memremap()
Date: Tue, 31 May 2016 19:27:05 +0200
Message-ID: <20160531172705.GJ11948@wotan.suse.de>
References: <CAB=NE6Wy=V17uwc3GNMYaWk4cOx1a1TtHBgMYii-M5FDuPn_Gw@mail.gmail.com>
 <20160531165828.GA25366@infradead.org>
 <20160531172514.GI11948@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42520 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755681AbcEaR1I (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 31 May 2016 13:27:08 -0400
Content-Disposition: inline
In-Reply-To: <20160531172514.GI11948@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>

On Tue, May 31, 2016 at 07:25:14PM +0200, Luis R. Rodriguez wrote:
> On Tue, May 31, 2016 at 09:58:28AM -0700, Christoph Hellwig wrote:
> > On Tue, May 24, 2016 at 04:36:42PM -0700, Luis R. Rodriguez wrote:
> > > Is it a good time for that now? I would hope identifying proper
> > > aliasing uses for memremap() might be a bit easier now than for
> > > ioremap() given its not used as widely. It may be an easier target to
> > > also write some grammar rules for it as well.
> > 
> > So you want an explicit opt-in flag to allow aliasing?  Sounds fine to
> > me.
>   
> Yup! Can the default then safely already be no-aliasing then?

Or if aliasing is truly not needed as often a different API, this
maybe useful later if we pick up again module namespace stuff.

  Luis
