Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.tip.net.au ([203.10.76.45]:47330 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751121AbWHGHGK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 7 Aug 2006 03:06:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <17622.58971.782729.588902@cargo.ozlabs.ibm.com>
Date: Mon, 7 Aug 2006 17:06:03 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC] Generic ioremap_page_range
In-Reply-To: <1defaf580608041144q9eca2c6tb9ef8c4ad9293a39@mail.gmail.com>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
	<1152892123.24925.67.camel@localhost.localdomain>
	<20060804094700.40a63a78@cad-250-152.norway.atmel.com>
	<1154711905.10109.25.camel@localhost.localdomain>
	<1defaf580608041144q9eca2c6tb9ef8c4ad9293a39@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
To: =?ISO-8859-1?Q?H=E5vard_Skinnemoen?= <hskinnemoen@gmail.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Håvard Skinnemoen writes:

> So far, I've only seen static flags. And I really can't think of a
> reason to set the flags dynamically...

The reason would be to select what sort of caching is allowed for the
mapping, and whether write-combining is allowed, on architectures
(such as PowerPC) where those choices are made by bits in the PTEs.

Paul.
