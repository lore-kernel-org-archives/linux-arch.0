From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 01/15] cmpxchg_local() is not signed-value safe, so fix generic atomics
Date: Wed, 18 May 2016 17:29:49 +0200
Message-ID: <3591761.rzLMs6OGtT@wuerfel>
References: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk> <146358424513.8596.16888168996359637266.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:60880 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932506AbcERPaa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2016 11:30:30 -0400
In-Reply-To: <146358424513.8596.16888168996359637266.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org

On Wednesday 18 May 2016 16:10:45 David Howells wrote:
> cmpxchg_local() is not signed-value safe because on a 64-bit machine signed
> int arguments to it may be sign-extended to signed long _before_ begin cast
> to unsigned long.  This potentially causes comparisons to fail when dealing
> with negative values.
> 
> Fix the generic atomic functions that are implemented in terms of cmpxchg()
> to cast their arguments to unsigned int before calling cmpxchg().
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> 

Isn't the problem you describe something that cmpxchg() could prevent instead?

	Arnd
