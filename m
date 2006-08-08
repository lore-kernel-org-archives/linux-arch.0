Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:13275
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965020AbWHHW0Y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 8 Aug 2006 18:26:24 -0400
Date: Tue, 08 Aug 2006 15:26:29 -0700 (PDT)
Message-Id: <20060808.152629.84150822.davem@davemloft.net>
Subject: Re: [PATCH 0/13] Generic ioremap_page_range: introduction
From: David Miller <davem@davemloft.net>
In-Reply-To: <11550397951750-git-send-email-hskinnemoen@atmel.com>
References: <11550397951750-git-send-email-hskinnemoen@atmel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: hskinnemoen@atmel.com
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 08 Aug 2006 14:23:02 +0200

> sparc seems to do something completely different than everyone else.

Yes, we map in huge pages when possible.

I really don't expect you to try to abstract
that in your generic routines. :-)
