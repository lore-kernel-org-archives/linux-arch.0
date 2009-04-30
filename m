From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 08/27] asm-generic: add generic versions of common
 headers
Date: Thu, 30 Apr 2009 10:12:31 -0700 (PDT)
Message-ID: <20090430.101231.27030060.davem@davemloft.net>
References: <200904301849.45543.arnd@arndb.de>
	<20090430.095147.208962142.davem@davemloft.net>
	<200904301907.46515.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:51136
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765049AbZD3RMh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 30 Apr 2009 13:12:37 -0400
In-Reply-To: <200904301907.46515.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-arch@vger.kernel.org, monstr@monstr.eu, remis.developer@googlemail.com, linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 30 Apr 2009 19:07:45 +0200

> On Thursday 30 April 2009, David Miller wrote:
>> I use "git format-patch" and send the postings by hand.
> 
> That's what I tried as well,

You didn't read what I said.

I extract the commit messages and patches using "git format-patch"
merely as a formality, then I hand craft every aspect of the emails.

I never put "Date:" fields into the message body, that's rediculiously
stupid.  And it confuses patchwork as well.  Just say NO.

If necessary I put the From: field in there to specify the author, or
leave it out when it's me (which is %99.9999 of the time).
