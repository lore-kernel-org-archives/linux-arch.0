Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sd0112e0.au.ibm.com (d23rh903.au.ibm.com [202.81.18.201])
	by ausmtp02.au.ibm.com (8.12.10/8.12.10) with ESMTP id j1O5GChI101066
	for <linux-arch@vger.kernel.org>; Thu, 24 Feb 2005 16:16:12 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0112e0.au.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j1O5LVNh101382
	for <linux-arch@vger.kernel.org>; Thu, 24 Feb 2005 16:21:31 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11/8.12.11) with ESMTP id j1O5JAp4009338
	for <linux-arch@vger.kernel.org>; Thu, 24 Feb 2005 16:19:10 +1100
Subject: Re: [PATCH] set_pte() part 2 arch usage
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
In-Reply-To: <20050223200719.2d4e8918.davem@davemloft.net>
References: <20050223200719.2d4e8918.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 24 Feb 2005 16:18:48 +1100
Message-Id: <1109222328.15027.12.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2005-02-23 at 20:07 -0800, David S. Miller wrote:
> Ok, here is the promised second installment.  This changes
> sparc64 (first attachment) and ppc{32,64} (second attachment)
> over to take advantage of the new set_pte_at() mm+address
> arguments.
> 
> I've build and run tested the sparc64 version.  I have only
> build tested the ppc32 and ppc64 changes.  Ben, can you give
> them a spin?

Seems to be happy on ppc32, I'll try ppc64 asap.

Ben.
