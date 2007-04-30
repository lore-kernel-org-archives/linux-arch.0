Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:26188 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423675AbXD3VeS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Apr 2007 17:34:18 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: condingstyle, was Re: utrace comments
Date: Mon, 30 Apr 2007 14:34:12 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A016A5EDA@scsmsx411.amr.corp.intel.com>
In-Reply-To: <20070430100917.439ebfc8.akpm@linux-foundation.org>
From: "Luck, Tony" <tony.luck@intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>
Cc: Roland McGrath <roland@redhat.com>, Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> I'm a bit lost here.  Are we referring to
>
>	if (expr) {
>		...
>	} else {
>		...
>	}
>
> versus
>
>	if (expr) {
>		...
>	}
>	else {
>		...
>	}

This one is already covered by Documentation/CodingStyle (with the Justification
that this is the way that K&R do it, so it must be right).

> This is
>
>	if (expr1 &&
>		expr2)
>
> versus
>
>	if (expr1
>		&& expr2)

This isn't covered ... CodingStyle merely says that long lines
should be broken into "sensible chunks".  Perhaps we should add
some words about breaking long lines leaving binary operators
trailing on the end of the line (my preferred style).  But the
only examples of this I could find leafing through K&R they
put the binary operator on the start of the continuation line
(could the prophets have been wrong here :-)

-Tony
