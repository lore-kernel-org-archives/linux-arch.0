From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/3] lib: Sparc's strncpy_from_user is generic enough,
 move under lib/
Date: Thu, 24 May 2012 15:53:22 -0400 (EDT)
Message-ID: <20120524.155322.2148951495051745756.davem@davemloft.net>
References: <20120523.233440.1152363385537335796.davem@davemloft.net>
	<7607.1337875848@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:42441 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932105Ab2EXTxZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 May 2012 15:53:25 -0400
In-Reply-To: <7607.1337875848@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dhowells@redhat.com
Cc: linux-arch@vger.kernel.org, torvalds@linux-foundation.org

From: David Howells <dhowells@redhat.com>
Date: Thu, 24 May 2012 17:10:48 +0100

> David Miller <davem@davemloft.net> wrote:
> 
>> +			v = (c & low_bits) + low_bits;;
> 
> You've an extra semicolon there.

Thanks I'll fix that up.
