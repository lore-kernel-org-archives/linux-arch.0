Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.ocs.com.au ([203.34.248.175]:60465 "EHLO mail.ocs.com.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728AbXGYC5K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 Jul 2007 22:57:10 -0400
From: Keith Owens <kaos@ocs.com.au>
Subject: Re: [PATCH][RFC] getting rid of stupid loop in BUG() 
In-reply-to: Your message of "Tue, 24 Jul 2007 19:31:36 MST."
             <Pine.LNX.4.58.0707241921470.30561@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 25 Jul 2007 12:50:47 +1000
Message-ID: <21803.1185331847@ocs10w.ocs.com.au>
Sender: linux-arch-owner@vger.kernel.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Trent Piepho (on Tue, 24 Jul 2007 19:31:36 -0700 (PDT)) wrote:
>Adding __builtin_trap after the
>asm might be an ok fix.  It will emit a spurious int 6, but that won't even be
>reached since the asm doesn't return, and it probably be less extra code than
>the loop.

int 6 is a two byte instruction, the loop generates jmp with an 8 bit
offset, also two bytes.  No change in code size.

