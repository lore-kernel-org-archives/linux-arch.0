Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp01.au.ibm.com (8.12.10/8.12.10) with ESMTP id j1P5bYTV142506
	for <linux-arch@vger.kernel.org>; Fri, 25 Feb 2005 16:37:34 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0208e0.au.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j1P5c5np059048
	for <linux-arch@vger.kernel.org>; Fri, 25 Feb 2005 16:38:07 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11/8.12.11) with ESMTP id j1P5Wl4A010479
	for <linux-arch@vger.kernel.org>; Fri, 25 Feb 2005 16:32:47 +1100
Subject: Re: [PATCH] set_pte() part 2 arch usage
From: Benjamin Herrenschmidt <benh@AU1.IBM.COM>
In-Reply-To: <20050224143601.12c340ca.davem@davemloft.net>
References: <20050223200719.2d4e8918.davem@davemloft.net>
	 <1109222328.15027.12.camel@gaston>
	 <20050224143601.12c340ca.davem@davemloft.net>
Content-Type: text/plain
Date: Fri, 25 Feb 2005 16:32:03 +1100
Message-Id: <1109309524.14993.56.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2005-02-24 at 14:36 -0800, David S. Miller wrote:
> On Thu, 24 Feb 2005 16:18:48 +1100
> Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:
> 
> > Seems to be happy on ppc32, I'll try ppc64 asap.
> 
> Thanks for testing, let me know how ppc64 goes.

Looks fine. Didn't stress much yet tho, but certainly good enough for
early 2.6.12, we can always push further fixes in if necessary.

Ben.
