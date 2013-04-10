Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:49761 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765413Ab3DJRGa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Apr 2013 13:06:30 -0400
Date: Wed, 10 Apr 2013 13:06:23 -0400 (EDT)
Message-ID: <20130410.130623.1470172183056352815.davem@davemloft.net>
Subject: Re: [PATCH/RFC] m68k: Add -ffreestanding to KBUILD_CFLAGS
From: David Miller <davem@davemloft.net>
In-Reply-To: <1365585879-5321-1-git-send-email-geert@linux-m68k.org>
References: <1365585879-5321-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: geert@linux-m68k.org
Cc: linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130410170623.5dfqyg2DlBe2pKVzuUehD_GNbRb1YvDKJY3AR62iBOY@z>

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 10 Apr 2013 11:24:39 +0200

> Without -ffreestanding, gcc may replace calls to standard C library
> functions by calls to other standard C library functions and/or inline
> code.  This may cause link errors if the replacement code calls a standard
> C library function that's implemented as a macro in the kernel.

I think you should instead implement the library functions that gcc might
emit during a build.
