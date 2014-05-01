Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:39765 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755646AbaEAJ5n (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 May 2014 05:57:43 -0400
Date: Thu, 1 May 2014 11:57:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH V4 6/7] arm64: mm: Enable HAVE_RCU_TABLE_FREE logic
Message-ID: <20140501095739.GO11096@twins.programming.kicks-ass.net>
References: <1396018892-6773-1-git-send-email-steve.capper@linaro.org>
 <1396018892-6773-7-git-send-email-steve.capper@linaro.org>
 <20140430152047.GF31220@arm.com>
 <20140430153317.GG31220@arm.com>
 <20140430153824.GA7166@linaro.org>
 <20140430172114.GI31220@arm.com>
 <20140501073402.GA30358@linaro.org>
 <20140501095246.GB22316@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140501095246.GB22316@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Steve Capper <steve.capper@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gary.robertson@linaro.org" <gary.robertson@linaro.org>, "anders.roxell@linaro.org" <anders.roxell@linaro.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Message-ID: <20140501095739.LAvbpHjr1-eULXttNQM7GxadwJAF8tg4EeUYSLACpXQ@z>

On Thu, May 01, 2014 at 10:52:47AM +0100, Catalin Marinas wrote:
> Does gup_fast walking increment the mm_users? Or is it a requirement of
> the calling code? I can't seem to find where this happens.

No, its not required at all. One should only walk current->mm with
gup_fast, any other usage is broken.

And by delaying TLB shootdown, either through disabling IRQs and
stalling IPIs or by using RCU freeing, you're guaranteed your own page
tables won't disappear underneath your feet.
