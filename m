Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from emailer.gwdg.de ([134.76.10.24]:60089 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1422960AbWJFU6m (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Oct 2006 16:58:42 -0400
Date: Fri, 6 Oct 2006 22:52:59 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in
 the kernel [try #4]
In-Reply-To: <20061006203919.GS2563@parisc-linux.org>
Message-ID: <Pine.LNX.4.61.0610062250090.30417@yvahk01.tjqt.qr>
References: <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.61.0610062232210.30417@yvahk01.tjqt.qr> <20061006203919.GS2563@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


>> >+ *   the massive ternary operator construction
>> >+	(sizeof(n) <= 4) ?			\
>> >+	__ilog2_u32(n) :			\
>> >+	__ilog2_u64(n)				\
>> 
>> Should not this be: sizeof(n) <= sizeof(u32)
>
>Were you planning on porting Linux to a machine with non-8-bit-bytes any
>time soon?  Because there's a lot more to fix than this.

I am considering the case [assuming 8-bit-byte machines] where 
sizeof(u32) is not 4. Though I suppose GCC will probably make a 32-bit 
type up if the hardware does not know one.


	-`J'
-- 
