Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:47798
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1422662AbWHEANG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 4 Aug 2006 20:13:06 -0400
Date: Fri, 04 Aug 2006 17:13:11 -0700 (PDT)
Message-Id: <20060804.171311.08346387.davem@davemloft.net>
Subject: Re: [RFC] Generic ioremap_page_range
From: David Miller <davem@davemloft.net>
In-Reply-To: <17619.56062.114311.902273@cargo.ozlabs.ibm.com>
References: <1152892123.24925.67.camel@localhost.localdomain>
	<20060804094700.40a63a78@cad-250-152.norway.atmel.com>
	<17619.56062.114311.902273@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: paulus@samba.org
Cc: hskinnemoen@atmel.com, haveblue@us.ibm.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Paul Mackerras <paulus@samba.org>
Date: Sat, 5 Aug 2006 09:40:46 +1000

> This would need to be set_pte_at(...) for this to be useful on
> PowerPC.

I'm surprised set_pte() still exists, we should kill it off
so nobody can add new uses even accidently.
