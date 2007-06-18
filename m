Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:47566 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762648AbXFRKFR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Jun 2007 06:05:17 -0400
Date: Mon, 18 Jun 2007 19:03:44 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: pause_on_oops
Message-ID: <20070618100344.GA19056@linux-sh.org>
References: <20070617114758.GA6716@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070617114758.GA6716@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On Sun, Jun 17, 2007 at 12:47:58PM +0100, Russell King wrote:
> AFAICS only i386, powerpc and x86_64 call oops_enter() and oops_exit().
> However, ARM, MIPS, S390, SH, Sparc64, and UML support lockdep, so
> presumably it would be a good idea if they too were aware of these
> functions.
> 
> I suggest _at least_ mips, s390, sh, sparc64 and uml folk look into
> adding support to their die() functions (and check whether their
> die functions are missing any other useful functionality.)
> 
I've added it on SH now, thanks Russell.
