From: David Miller <davem@davemloft.net>
Subject: Re: x86: faster strncpy_from_user()
Date: Tue, 10 Apr 2012 20:43:22 -0400 (EDT)
Message-ID: <20120410.204322.1625218582933057448.davem@davemloft.net>
References: <1334097321.3040.62.camel@pasglop>
	<20120410.192550.1904257005034151185.davem@davemloft.net>
	<CA+55aFwAQ13t6HwPVmvntwPvDq_kK6=W9e8KLahtfGwKr=2YCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:49428 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755768Ab2DKAn1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Apr 2012 20:43:27 -0400
In-Reply-To: <CA+55aFwAQ13t6HwPVmvntwPvDq_kK6=W9e8KLahtfGwKr=2YCQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: benh@kernel.crashing.org, mingo@kernel.org, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 10 Apr 2012 17:34:14 -0700

> Sparc has "faligndata", no?

It's an FPU instruction :-)

The barrel shift would be the fastest on sparc.
