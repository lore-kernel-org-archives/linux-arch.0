Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel10.hp.com ([156.153.255.245]:8674 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S264505AbUESTNG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 May 2004 15:13:06 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16555.45503.258963.822973@napali.hpl.hp.com>
Date: Wed, 19 May 2004 12:13:03 -0700
Subject: Re: [PATCH] fixing sendfile on 64bit architectures
In-Reply-To: <20040519210156.2a983a7c.ak@suse.de>
References: <20040519114940.6b92cf1a.ak@suse.de>
	<16555.42184.694738.917744@napali.hpl.hp.com>
	<20040519210156.2a983a7c.ak@suse.de>
Reply-To: davidm@hpl.hp.com
To: Andi Kleen <ak@suse.de>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, linux-arch@vger.kernel.org, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Wed, 19 May 2004 21:01:56 +0200, Andi Kleen <ak@suse.de> said:

  Andi> How about just putting it into an a extra file and using lib-y
  Andi> in the Makefile?

  Andi> Then it will be only linked when someone references it.

That may work in some cases, but usually the stubs depend on other
functions which are static only.  Moreover, putting them in separate
files prevents inlining.

	--david
