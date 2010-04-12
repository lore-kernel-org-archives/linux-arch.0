From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 1/23] Make register values available to panic notifiers
Date: Mon, 12 Apr 2010 13:27:45 +0100
Message-ID: <20100412122745.GC28208@flint.arm.linux.org.uk>
References: <20100412060609.GA25273@dvomlehn-lnx2.corp.sa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56198 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab0DLM14 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Apr 2010 08:27:56 -0400
Content-Disposition: inline
In-Reply-To: <20100412060609.GA25273@dvomlehn-lnx2.corp.sa.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David VomLehn <dvomlehn@cisco.com>
Cc: to@dvomlehn-lnx2.corp.sa.net, "linux-arch@vger.kernel.org"@cisco.comlinux-arch@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, maint_arch@dvomlehn-lnx2.corp.sa.net

On Sun, Apr 11, 2010 at 11:06:09PM -0700, David VomLehn wrote:
> This patch makes panic() and die() registers available to, for example,
> panic notifier functions.  Panic notifier functions are quite useful
> for recording crash information, but they don't get passed the register
> values. This makes it hard to print register contents, do stack
> backtraces, etc. The changes in this patch save the register state when
> panic() is called and introduce a function for die() to call that allows
> it to pass in the registers it was passed.

Can you explain why you want this?

I'm wondering about the value of saving the registers; normally when a panic
occurs, it's because of a well defined reason, and not because something
went wrong in some CPU register; to put it another way, a panic() is a
more controlled exception than a BUG() or a bad pointer dereference.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
