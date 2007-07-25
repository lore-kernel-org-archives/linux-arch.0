Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:46249 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbXGYFOF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jul 2007 01:14:05 -0400
Message-ID: <46A6DB04.3000003@zytor.com>
Date: Tue, 24 Jul 2007 22:09:24 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH][RFC] getting rid of stupid loop in BUG()
References: <21803.1185331847@ocs10w.ocs.com.au>
In-Reply-To: <21803.1185331847@ocs10w.ocs.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Keith Owens <kaos@ocs.com.au>
Cc: Trent Piepho <xyzzy@speakeasy.org>, Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Keith Owens wrote:
> Trent Piepho (on Tue, 24 Jul 2007 19:31:36 -0700 (PDT)) wrote:
>> Adding __builtin_trap after the
>> asm might be an ok fix.  It will emit a spurious int 6, but that won't even be
>> reached since the asm doesn't return, and it probably be less extra code than
>> the loop.
> 
> int 6 is a two byte instruction, the loop generates jmp with an 8 bit
> offset, also two bytes.  No change in code size.
> 

INT 6 is #UD, so the __builtin_trap() replaces the ud2a as well as the loop.

How far back was __builtin_trap() supported?

	-hpa
