Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:48102 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423024AbWJRVsw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Oct 2006 17:48:52 -0400
Received: by nf-out-0910.google.com with SMTP id c2so798624nfe
        for <linux-arch@vger.kernel.org>; Wed, 18 Oct 2006 14:48:50 -0700 (PDT)
Date: Thu, 19 Oct 2006 01:48:43 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: dealing with excessive includes
Message-ID: <20061018214843.GA5344@martell.zuzino.mipt.ru>
References: <20061017005025.GF29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org> <20061018044054.GH29920@ftp.linux.org.uk> <20061018091944.GA5343@martell.zuzino.mipt.ru> <20061018093126.GM29920@ftp.linux.org.uk> <20061018100057.GB5343@martell.zuzino.mipt.ru> <20061018174257.GP29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018174257.GP29920@ftp.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Oct 18, 2006 at 06:42:57PM +0100, Al Viro wrote:
> On Wed, Oct 18, 2006 at 02:00:57PM +0400, Alexey Dobriyan wrote:
> > > 	Anyway, that patch is obviously preliminary - at the very least
> > > it needs be checked on more configs (and more targets - e.g. mips and
> > > parisc hadn't been checked at all).
> >
> > configs. Is ftp://ftp.linux.org.uk/pub/people/viro/config/ still
> > relevant?
>
> Updated.

Thank you!

This is needed on parisc when sched.h is going out of module.h

lib/random32.c:119: error: `jiffies' undeclared (first use in this function)

--- a/lib/random32.c
+++ b/lib/random32.c
@@ -37,6 +37,7 @@ #include <linux/types.h>
 #include <linux/percpu.h>
 #include <linux/module.h>
 #include <linux/random.h>
+#include <linux/jiffies.h>
 
 struct rnd_state {
 	u32 s1, s2, s3;

