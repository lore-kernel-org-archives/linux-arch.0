Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:43705
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751111AbWJEUGa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 5 Oct 2006 16:06:30 -0400
Date: Thu, 05 Oct 2006 13:06:31 -0700 (PDT)
Message-Id: <20061005.130631.63128675.davem@davemloft.net>
Subject: Re: Cache alias handling in copy_user_page / copy_user_highpage
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061005165429.GA18700@linux-mips.org>
References: <20060819122520.GA18180@linux-mips.org>
	<20060828.233656.59469351.davem@davemloft.net>
	<20061005165429.GA18700@linux-mips.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: ralf@linux-mips.org
Cc: linux-arch@vger.kernel.org, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

From: Ralf Baechle <ralf@linux-mips.org>
Date: Thu, 5 Oct 2006 17:54:29 +0100

> I found it to be much more maintainable to deal with this in C due to a
> large number of processor variations to be supported.

It is a reasonable reason to use code patching :-)

Anyways, I have no problems with your patch.
