Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:55531 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265237AbUHAG7Q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Aug 2004 02:59:16 -0400
Date: Sat, 31 Jul 2004 23:58:24 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: find_next_bit return type
Message-Id: <20040731235824.249ddb23.davem@redhat.com>
In-Reply-To: <20040731232515.1fead83b.akpm@osdl.org>
References: <20040731232434.7263b50c.akpm@osdl.org>
	<20040731232515.1fead83b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


It's kind of pukey that the size and offset passed in is
unsigned long yet the return type is 'int'.

Frankly, I think the 64-bit systems have the prototype correct
this time and x86 is what ought to be "fixed" :-)

Just think, it only takes a "4GB / 8" sized bitmap to
potentially overflow that int return value :)))

Come on Andrew, you had to cringe at least a smidgen when
making these diffs :)
