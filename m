Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17328
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751122AbWHGHVf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2006 03:21:35 -0400
Date: Mon, 07 Aug 2006 00:21:34 -0700 (PDT)
Message-Id: <20060807.002134.122617142.davem@davemloft.net>
Subject: Re: [RFC] Generic ioremap_page_range
From: David Miller <davem@davemloft.net>
In-Reply-To: <17622.58971.782729.588902@cargo.ozlabs.ibm.com>
References: <1154711905.10109.25.camel@localhost.localdomain>
	<1defaf580608041144q9eca2c6tb9ef8c4ad9293a39@mail.gmail.com>
	<17622.58971.782729.588902@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
To: paulus@samba.org
Cc: hskinnemoen@gmail.com, haveblue@us.ibm.com, hskinnemoen@atmel.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Paul Mackerras <paulus@samba.org>
Date: Mon, 7 Aug 2006 17:06:03 +1000

> Håvard Skinnemoen writes:
> 
> > So far, I've only seen static flags. And I really can't think of a
> > reason to set the flags dynamically...
> 
> The reason would be to select what sort of caching is allowed for the
> mapping, and whether write-combining is allowed, on architectures
> (such as PowerPC) where those choices are made by bits in the PTEs.

Things work similarly on sparc64.
