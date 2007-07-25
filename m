Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:47859 "EHLO
	mtagate5.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbXGYGvK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jul 2007 02:51:10 -0400
Date: Wed, 25 Jul 2007 08:50:39 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH][RFC] getting rid of stupid loop in BUG()
Message-ID: <20070725065039.GA8555@osiris.boeblingen.de.ibm.com>
References: <21803.1185331847@ocs10w.ocs.com.au> <46A6DB04.3000003@zytor.com> <46A6ECB7.7090208@goop.org> <20070724.232914.56812376.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070724.232914.56812376.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: jeremy@goop.org, hpa@zytor.com, kaos@ocs.com.au, xyzzy@speakeasy.org, viro@ftp.linux.org.uk, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jul 24, 2007 at 11:29:14PM -0700, David Miller wrote:
> From: Jeremy Fitzhardinge <jeremy@goop.org>
> Date: Tue, 24 Jul 2007 23:24:55 -0700
> 
> > H. Peter Anvin wrote:
> > > How far back was __builtin_trap() supported?
> > 
> > I think its relatively recent, but it might be within our supported
> > compiler window.
> 
> I'm pretty sure it is.

We had this in include/asm-s390/bug.h to avoid compile errors with gcc 3.2:

+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 3)
+	__builtin_trap();
+#else
+	asm volatile(".long 0");
+#endif
