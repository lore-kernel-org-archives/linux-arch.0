Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:17843 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265301AbUHAHDv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Aug 2004 03:03:51 -0400
Date: Sun, 1 Aug 2004 00:02:13 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: find_next_bit return type
Message-Id: <20040801000213.5f01b469.akpm@osdl.org>
In-Reply-To: <20040731235824.249ddb23.davem@redhat.com>
References: <20040731232434.7263b50c.akpm@osdl.org>
	<20040731232515.1fead83b.akpm@osdl.org>
	<20040731235824.249ddb23.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

"David S. Miller" <davem@redhat.com> wrote:
>
> 
> It's kind of pukey that the size and offset passed in is
> unsigned long yet the return type is 'int'.

`size' and `offset' should be unsigned ints.

> Frankly, I think the 64-bit systems have the prototype correct
> this time and x86 is what ought to be "fixed" :-)
> 
> Just think, it only takes a "4GB / 8" sized bitmap to
> potentially overflow that int return value :)))
> 
> Come on Andrew, you had to cringe at least a smidgen when
> making these diffs :)

Kind-of.  But it's also cringeworthy to go slinging 8-byte values around
when 4-byte values would suffice.  Is it not more efficient to use
integers?
