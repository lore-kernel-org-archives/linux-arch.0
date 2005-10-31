Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 31 Oct 2005 22:43:01 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 17/20] inflate: mark some arrays as initdata
Message-ID: <20051031224301.GF20452@flint.arm.linux.org.uk>
References: <17.196662837@selenic.com> <18.196662837@selenic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18.196662837@selenic.com>
Sender: Russell King <rmk@arm.linux.org.uk>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Oct 31, 2005 at 02:54:51PM -0600, Matt Mackall wrote:
> inflate: mark some arrays as INITDATA and define it in in-core callers

This breaks ARM.  Our decompressor has some rather odd requirements
due to the way we support PIC - it's PIC text with fixed data.

This means that all fixed initialised data must be "const" or initialised
by code.  This patch breaks that assertion.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
