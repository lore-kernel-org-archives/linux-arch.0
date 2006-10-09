Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from emailer.gwdg.de ([134.76.10.24]:22964 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932405AbWJIInN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2006 04:43:13 -0400
Date: Mon, 9 Oct 2006 10:36:12 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in
 the kernel [try #4]
In-Reply-To: <5267.1160381168@redhat.com>
Message-ID: <Pine.LNX.4.61.0610091032470.24127@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0610062250090.30417@yvahk01.tjqt.qr>
 <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.61.0610062232210.30417@yvahk01.tjqt.qr> <20061006203919.GS2563@parisc-linux.org>
  <5267.1160381168@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <matthew@wil.cx>, torvalds@osdl.org, akpm@osdl.org, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


>> >Were you planning on porting Linux to a machine with non-8-bit-bytes any
>> >time soon?  Because there's a lot more to fix than this.
>> 
>> I am considering the case [assuming 8-bit-byte machines] where 
>> sizeof(u32) is not 4. Though I suppose GCC will probably make a 32-bit 
>> type up if the hardware does not know one.
>
>If the machine has 8-bit bytes, how can sizeof(u32) be anything other than 4?

	typedef unsigned int u32;

Though this should not be seen in the linux kernel.


	-`J'
-- 
