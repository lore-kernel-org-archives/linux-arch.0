Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33837 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbYAQIm2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Jan 2008 03:42:28 -0500
Date: Thu, 17 Jan 2008 08:36:38 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 1/3] bug.h: Remove HAVE_ARCH_BUG and HAVE_ARCH_WARN
Message-ID: <20080117083638.GA5959@flint.arm.linux.org.uk>
References: <20080117010130.GA24663@lixom.net> <20080117010827.GA24766@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080117010827.GA24766@lixom.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Olof Johansson <olof@lixom.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, linux-arch@vger.kernel.org

On Wed, Jan 16, 2008 at 07:08:27PM -0600, Olof Johansson wrote:
> No need to have the HAVE_ARCH_BUG.* / HAVE_ARCH_WARN.* defines, when
> the generic implementation can just use #ifndef on the macros themselves.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Cc: <linux-arch@vger.kernel.org>

For the ARM bit:

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
