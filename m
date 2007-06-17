Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3462 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756008AbXFQLsI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 17 Jun 2007 07:48:08 -0400
Date: Sun, 17 Jun 2007 12:47:58 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: pause_on_oops
Message-ID: <20070617114758.GA6716@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

Folk,

It seems that arch maintainers weren't copied on the "pause on oops"
patch (dd287796d608fcdc3fe5e8fdb5bf762a8f1bc32a) which introduced
some generic infrastructure (oops_enter, oops_exit).  This has been
subsequently used by lockdep to disable itself when an oops occurs.

AFAICS only i386, powerpc and x86_64 call oops_enter() and oops_exit().
However, ARM, MIPS, S390, SH, Sparc64, and UML support lockdep, so
presumably it would be a good idea if they too were aware of these
functions.

I suggest _at least_ mips, s390, sh, sparc64 and uml folk look into
adding support to their die() functions (and check whether their
die functions are missing any other useful functionality.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
