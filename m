Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267757AbUHPQWl@vger.kernel.org>
Received: from holomorphy.com ([207.189.100.168]:11176 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267755AbUHPQWl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Aug 2004 12:22:41 -0400
Date: Mon, 16 Aug 2004 09:22:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Using get_cycles for add_timer_randomness
Message-ID: <20040816162228.GB11200@holomorphy.com>
References: <200308160303.17612.arnd@arndb.de> <20040810162435.GK24690@krispykreme> <20040814183623.GB5637@krispykreme> <20040815154821.2d6edb03.akpm@osdl.org> <20040816161756.GC16521@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040816161756.GC16521@thunk.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>, arnd@arndb.de, richm@oldelvet.org.uk, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

At some point in the past, Arnd Bergmann <arnd@arndb.de> wrote:
>> I noticed that only i386 and x86-64 are currently using a high resolution
>> timer source when adding randomness.  Since many architectures have a
>> working get_cycles() implementation, it seems rather straightforward to use
>> that.

On Mon, Aug 16, 2004 at 12:17:56PM -0400, Theodore Ts'o wrote:
> My only concern about using get_cycles is the speed question; on some
> architectures, could (particularly those without TSC registers or
> equivalent hardware support) could get_cycles() be slow enough to cause
> latency problems?

AFAICT most of those return 0 from get_cycles().


-- wli
