Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23179 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752240AbXFYVgH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jun 2007 17:36:07 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PARISC] Handle wrapping in expand_upwards()
Date: Mon, 25 Jun 2007 14:36:04 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A01C206AB@scsmsx411.amr.corp.intel.com>
In-Reply-To: <20070623095548.a7117833.akpm@linux-foundation.org>
From: "Luck, Tony" <tony.luck@intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Kyle McMartin <kyle@parisc-linux.org>
Cc: linux-arch@vger.kernel.org, torvalds@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

> I will magically infer from your To: line that you consider it 2.6.22
> material, but if so I think that we'll need suitable reviewing, testing and
> acking from Tony, please.  If he's offline (ols, perhaps?) then we might
> have a problem.  Perhaps find a suitable ia64-enabled alternate?

Wrap-around to zero for the ia64 RSE stack isn't possible (it must be
in a user region (0-4), so it is far, far away from the top of the
address space.

-Tony
