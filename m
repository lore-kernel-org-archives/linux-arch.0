Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from emailer.gwdg.de ([134.76.10.24]:50319 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964801AbWJIUIE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2006 16:08:04 -0400
Date: Mon, 9 Oct 2006 22:00:38 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in
 the kernel [try #4]
In-Reply-To: <11639.1160398461@redhat.com>
Message-ID: <Pine.LNX.4.61.0610092159340.23379@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0610091416290.4279@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0610062250090.30417@yvahk01.tjqt.qr>
 <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.61.0610062232210.30417@yvahk01.tjqt.qr> <20061006203919.GS2563@parisc-linux.org>
 <5267.1160381168@redhat.com> <Pine.LNX.4.61.0610091032470.24127@yvahk01.tjqt.qr>
 <EE65413A-0E34-40DA-9037-72423C18CD0C@mac.com>  <11639.1160398461@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Matthew Wilcox <matthew@wil.cx>, torvalds@osdl.org, akpm@osdl.org, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


>> typedef uint32_t __u32;
>
>That only offsets the problem a bit.  You still have to derive uint32_t from
>somewhere.

The compiler could make it available as a 'fundamental type' - i.e. 
available without any headers, like 'int' and 'long'.


	-`J'
-- 
