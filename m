Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:43139
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753892AbXCaTAZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 31 Mar 2007 15:00:25 -0400
Date: Sat, 31 Mar 2007 12:00:23 -0700 (PDT)
Message-Id: <20070331.120023.91313972.davem@davemloft.net>
Subject: Re: missing kretprobes support on avr32 and sparc64
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070331131522.GA15148@lst.de>
References: <20070331131522.GA15148@lst.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: hch@lst.de
Cc: hskinnemoen@atmel.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Christoph Hellwig <hch@lst.de>
Date: Sat, 31 Mar 2007 15:15:22 +0200

> Currently all avr32 and sparc64 don't support kretprobes unlike all
> other kprobes supporting architectures.  This is not nice from the
> user interface point of view and from the ugly ifdefs point of view.
> Is there a reason these ports can't support kretprobes or was this
> simply an oversight / lazyness?

I just haven't gotten around to it yet.

Don't worry I'm aware of it. :-)
