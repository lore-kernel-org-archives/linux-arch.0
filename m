Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2850 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbXFRJlg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 Jun 2007 05:41:36 -0400
Date: Mon, 18 Jun 2007 10:41:03 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] Wire up sys_sync_file_range() on powerpc
Message-ID: <20070618094103.GA10387@flint.arm.linux.org.uk>
References: <1181992681.25228.683.camel@pmac.infradead.org> <1182018044.2808.75.camel@pmac.infradead.org> <18038.6658.854660.4233@cargo.ozlabs.ibm.com> <1182158711.2799.78.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1182158711.2799.78.camel@shinybook.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org, linuxppc-dev@ozlabs.org, torvalds@osdl.org, linux-arch@vger.kernel.org, drepper@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jun 18, 2007 at 05:25:11PM +0800, David Woodhouse wrote:
> [PATCH] Add sys_sync_file_range2() system call
> ... with more sensible ABI, for those architectures which hated
> sys_sync_file_range() for wasting argument slots by misaligning 64-bit
> values. Convert ARM to use it, wire it up on PowerPC, and prevent the
> missing syscall checker from bitching about sync_file_range if you have
> sync_file_range2 instead.
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>

For the ARM bits:

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
