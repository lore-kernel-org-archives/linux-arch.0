From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHv2 1/5] mm: add coherence API for DMA to vmalloc/vmap
 areas
Date: Mon, 04 Jan 2010 07:14:21 +1100
Message-ID: <1262549661.2173.262.camel@pasglop>
References: <1261603345-2494-1-git-send-email-James.Bottomley@suse.de>
	 <1261603345-2494-2-git-send-email-James.Bottomley@suse.de>
	 <20091224100853.GA3165@console-pimps.org>
	 <20091224123913.GD5335@parisc-linux.org>
	 <1262467678.2173.244.camel@pasglop>
	 <1262469295.2741.30.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1262469295.2741.30.camel@mulgrave.site>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Matthew Wilcox <matthew@wil.cx>, Matt Fleming <matt@console-pimps.org>, linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-arch.vger.kernel.org

On Sat, 2010-01-02 at 15:54 -0600, James Bottomley wrote:
> Well, that's the result of the email thread.  XFS is poking deeply into
> architectural issues by trying to do I/O on a vmap area.  I thought the
> consensus was that if xfs wants to do that then it takes complete
> responsibility for coherence rather than trying to hide it in a block
> API.

Well, maybe ... Mostly my comment was about the "other" (standard) DMA
APIs, ie, the work you do for XFS just reminded me of that issue I've
been thinking about :-)

Cheers,
Ben.


