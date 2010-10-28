From: "John David Anglin" <dave@hiauly1.hia.nrc.ca>
Subject: Re: [PATCH] parisc: fix compile failure with kmap_atomic changes
Date: Thu, 28 Oct 2010 14:11:38 -0400 (EDT)
Message-ID: <20101028181139.558BE4D30@hiauly1.hia.nrc.ca>
References: <1288287580.3043.159.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1288287580.3043.159.camel@mulgrave.site> from "James Bottomley" at Oct 28, 2010 12:39:40 pm
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

> The specific problem is that kmap_atomic no longer takes the index
> argument because Peter moved it to a stack based implementation.  All
> our kmap_atomic primitives in asm/cacheflush.h still have the extra
> index argument which causes a compile failure.

Sorry, missed that.  The issue I was trying to address was the lack of
calls to pagefault_disable() and pagefault_enable().

Dave
-- 
J. David Anglin                                  dave.anglin@nrc-cnrc.gc.ca
National Research Council of Canada              (613) 990-0752 (FAX: 952-6602)
