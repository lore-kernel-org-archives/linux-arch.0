From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] [2/9] Add a kernel_address() that works for data too
Date: Tue, 5 Jan 2010 08:44:52 +0000
Message-ID: <20100105084452.GA16826@flint.arm.linux.org.uk>
References: <20100105315.789846878@firstfloor.org> <20100105021527.1AB19B17C2@basil.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43459 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab0AEIpN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jan 2010 03:45:13 -0500
Content-Disposition: inline
In-Reply-To: <20100105021527.1AB19B17C2@basil.firstfloor.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-arch@vger.kernel.org, ebiederm@xmission.com, paulmck@linux.vnet.ibm.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org

On Tue, Jan 05, 2010 at 03:15:27AM +0100, Andi Kleen wrote:
> 
> Add a variant of kernel_text_address() that includes kernel data.
> 
> Assumes kernel is _text ... _end - init section. True everywhere?

No.  XIP kernels have the text and data/bss separated into two distinct
address regions.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
