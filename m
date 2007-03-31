Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:51243 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753000AbXCaNPX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 31 Mar 2007 09:15:23 -0400
Date: Sat, 31 Mar 2007 15:15:22 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: missing kretprobes support on avr32 and sparc64
Message-ID: <20070331131522.GA15148@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: hskinnemoen@atmel.com, davem@davemloft.net
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Currently all avr32 and sparc64 don't support kretprobes unlike all
other kprobes supporting architectures.  This is not nice from the
user interface point of view and from the ugly ifdefs point of view.
Is there a reason these ports can't support kretprobes or was this
simply an oversight / lazyness?
