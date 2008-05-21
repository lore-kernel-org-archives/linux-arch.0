Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47663 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936905AbYEUUkl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 21 May 2008 16:40:41 -0400
Subject: Re: [PATCH 1/2] Add thread_info_cache_init() to all archs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
In-Reply-To: <20080521114147.59ca3551.akpm@linux-foundation.org>
References: <20080410032354.90CB1DDF0F@ozlabs.org>
	 <20080413171953.bde5e9ac.akpm@linux-foundation.org>
	 <1208133506.6958.82.camel@pasglop>
	 <20080413191338.9776ebd0.akpm@linux-foundation.org>
	 <1208491086.6958.381.camel@pasglop>
	 <20080417211905.8ff769fa.akpm@linux-foundation.org>
	 <1208501061.6958.394.camel@pasglop> <1211392585.8297.218.camel@pasglop>
	 <20080521114147.59ca3551.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 21 May 2008 15:44:41 -0400
Message-ID: <1211399081.8297.234.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-m32r@ml.linux-m32r.org, takata@linux-m32r.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, Luke Browning <LukeBrowning@us.ibm.com>
Message-ID: <20080521194441.wnt3C95ttFe7UPAupBpnETOunvOnQgXPTqi25kZkla8@z>


On Wed, 2008-05-21 at 11:41 -0700, Andrew Morton wrote:
> 
> yup, gcc bug.  Discussed recently on lkml, "Subject: Re: huge gcc
> 4.1.{0,1} __weak problem".  I don't think anything ended up happening
> about it though.

Hrm... do you think we should work around ? ie. move the stubs to a
separate .c file ?

Ben.


