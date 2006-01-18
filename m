Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1753
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161026AbWARV65 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Jan 2006 16:58:57 -0500
Date: Wed, 18 Jan 2006 13:58:56 -0800 (PST)
Message-Id: <20060118.135856.10441826.davem@davemloft.net>
Subject: Re: new syscalls
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1137621188.30084.67.camel@localhost.localdomain>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05737A9F@scsmsx401.amr.corp.intel.com>
	<20060118133629.1cda96fd.akpm@osdl.org>
	<1137621188.30084.67.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: dwmw2@infradead.org
Cc: akpm@osdl.org, tony.luck@intel.com, linux-arch@vger.kernel.org, janak@us.ibm.com, drepper@redhat.com, dhowells@redhat.com, davidel@xmailserver.org, christoph@lameter.com
List-ID: <linux-arch.vger.kernel.org>

From: David Woodhouse <dwmw2@infradead.org>
Date: Thu, 19 Jan 2006 08:53:07 +1100

> When I get back home I'll tidy up and publish the hacks I used for
> testing pselect() and ppoll() so that those can be tested without
> actually rebuilding glibc.

Thanks David.
