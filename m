From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [GIT PULL] Disintegrate the User API from the kernel headers
Date: Mon, 01 Oct 2012 14:15:53 -0700
Message-ID: <506A0809.704@zytor.com>
References: <15670.1349125526@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:50380 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904Ab2JAVQP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 1 Oct 2012 17:16:15 -0400
In-Reply-To: <15670.1349125526@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, arnd@arndb.de, alan@lxorguk.ukuu.org.uk, fengguang.wu@intel.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/01/2012 02:05 PM, David Howells wrote:
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Michael Kerrisk <mtk.manpages@gmail.com>
> Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Acked-by: Dave Jones <davej@redhat.com>
> Requested-by: H. Peter Anvin <hpa@zytor.com>

FWIW, I did not have time to review this before the merge window, but:

Acked-by: H. Peter Anvin <hpa@zytor.com>

I believe this will reduce the number of mishaps we have with what bits
are exported as ABI and which ones aren't, and provide a much better
platform for further improvements.

	-hpa
