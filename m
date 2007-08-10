Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:54397
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754640AbXHJX7M (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Aug 2007 19:59:12 -0400
Date: Fri, 10 Aug 2007 16:59:13 -0700 (PDT)
Message-Id: <20070810.165913.58962051.davem@davemloft.net>
Subject: Re: [patch 47/59] x86: optimize page faults like all other
 achitectures and kill notifier cruft
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070810235207.GA28512@lst.de>
References: <200708102200.l7AM0CnU011952@imap1.linux-foundation.org>
	<200708110117.34171.ak@suse.de>
	<20070810235207.GA28512@lst.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: hch@lst.de
Cc: ak@suse.de, akpm@linux-foundation.org, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org, prasanna@in.ibm.com
List-ID: <linux-arch.vger.kernel.org>

From: Christoph Hellwig <hch@lst.de>
Date: Sat, 11 Aug 2007 01:52:07 +0200

> I'm not going to let all this crappy and uneeded code rot in kprobes.c
> just because you disagree with everyone else.

FWIW I totally agree with Christoph on this.
