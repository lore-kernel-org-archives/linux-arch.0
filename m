Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267751AbUHPQTF@vger.kernel.org>
Received: from thunk.org ([140.239.227.29]:42388 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S267747AbUHPQSN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Aug 2004 12:18:13 -0400
Date: Mon, 16 Aug 2004 12:17:56 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Using get_cycles for add_timer_randomness
Message-ID: <20040816161756.GC16521@thunk.org>
References: <200308160303.17612.arnd@arndb.de> <20040810162435.GK24690@krispykreme> <20040814183623.GB5637@krispykreme> <20040815154821.2d6edb03.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040815154821.2d6edb03.akpm@osdl.org>
Sender: "Theodore Ts'o" <tytso@thunk.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, arnd@arndb.de, richm@oldelvet.org.uk, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Aug 15, 2004 at 03:48:21PM -0700, Andrew Morton wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> I noticed that only i386 and x86-64 are currently using a high resolution
> timer source when adding randomness.  Since many architectures have a
> working get_cycles() implementation, it seems rather straightforward to use
> that.

My only concern about using get_cycles is the speed question; on some
architectures, could (particularly those without TSC registers or
equivalent hardware support) could get_cycles() be slow enough to cause
latency problems?

						- Ted
