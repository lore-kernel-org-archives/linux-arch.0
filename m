Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:11981 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964837AbWJIUhN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2006 16:37:13 -0400
From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4]
References: <Pine.LNX.4.61.0610091416290.4279@yvahk01.tjqt.qr>
	<Pine.LNX.4.61.0610062250090.30417@yvahk01.tjqt.qr>
	<20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
	<Pine.LNX.4.61.0610062232210.30417@yvahk01.tjqt.qr>
	<20061006203919.GS2563@parisc-linux.org> <5267.1160381168@redhat.com>
	<Pine.LNX.4.61.0610091032470.24127@yvahk01.tjqt.qr>
	<EE65413A-0E34-40DA-9037-72423C18CD0C@mac.com>
	<11639.1160398461@redhat.com>
	<Pine.LNX.4.61.0610092159340.23379@yvahk01.tjqt.qr>
Date: Mon, 09 Oct 2006 22:36:47 +0200
In-Reply-To: <Pine.LNX.4.61.0610092159340.23379@yvahk01.tjqt.qr> (Jan
	Engelhardt's message of "Mon, 9 Oct 2006 22:00:38 +0200 (MEST)")
Message-ID: <je4pudns4g.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: David Howells <dhowells@redhat.com>, Kyle Moffett <mrmacman_g4@mac.com>, Matthew Wilcox <matthew@wil.cx>, torvalds@osdl.org, akpm@osdl.org, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>> typedef uint32_t __u32;
>>
>>That only offsets the problem a bit.  You still have to derive uint32_t from
>>somewhere.
>
> The compiler could make it available as a 'fundamental type' - i.e. 
> available without any headers, like 'int' and 'long'.

The compiler is not allowed to define uint32_t without including
<stdint.h> first.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
