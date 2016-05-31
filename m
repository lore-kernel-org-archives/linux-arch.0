From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Enhancing semantics with memremap() - aliasing with memremap()
Date: Tue, 31 May 2016 09:58:28 -0700
Message-ID: <20160531165828.GA25366@infradead.org>
References: <CAB=NE6Wy=V17uwc3GNMYaWk4cOx1a1TtHBgMYii-M5FDuPn_Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:43598 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbcEaQ6i (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2016 12:58:38 -0400
Content-Disposition: inline
In-Reply-To: <CAB=NE6Wy=V17uwc3GNMYaWk4cOx1a1TtHBgMYii-M5FDuPn_Gw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, Christoph Hellwig <hch@infradead.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>

On Tue, May 24, 2016 at 04:36:42PM -0700, Luis R. Rodriguez wrote:
> Is it a good time for that now? I would hope identifying proper
> aliasing uses for memremap() might be a bit easier now than for
> ioremap() given its not used as widely. It may be an easier target to
> also write some grammar rules for it as well.

So you want an explicit opt-in flag to allow aliasing?  Sounds fine to
me.
