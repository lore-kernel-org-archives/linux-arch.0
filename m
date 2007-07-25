Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38304
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750982AbXGYWBk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Jul 2007 18:01:40 -0400
Date: Wed, 25 Jul 2007 15:01:39 -0700 (PDT)
Message-Id: <20070725.150139.104063215.davem@davemloft.net>
Subject: Re: [PATCH][RFC] getting rid of stupid loop in BUG()
From: David Miller <davem@davemloft.net>
In-Reply-To: <46A7B46C.9020007@zytor.com>
References: <46A78B47.1070500@goop.org>
	<46A7B2BF.4000506@redhat.com>
	<46A7B46C.9020007@zytor.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: hpa@zytor.com
Cc: cebbert@redhat.com, jeremy@goop.org, viro@ftp.linux.org.uk, torvalds@linux-foundation.org, kaos@ocs.com.au, xyzzy@speakeasy.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 25 Jul 2007 13:37:00 -0700

> Another useful extension was a variant of __builtin_trap() which would
> create a dummy ELF relocation for the trapping instruction with a target.

That would be very useful.

Another idea that has been tossed around is to build with dwarf2
debugging, scan a pre-linked kernel image for conditional trap
instructions, and use the dwarf2 info to reconstruct the file and line
number information into the table of BUG entries.  Then perform the
final link and strip the dwarf2 debugging info out.
