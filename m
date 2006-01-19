Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40336
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161022AbWASB0m (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Jan 2006 20:26:42 -0500
Date: Wed, 18 Jan 2006 17:26:39 -0800 (PST)
Message-Id: <20060118.172639.15928930.davem@davemloft.net>
Subject: Re: new syscalls
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.63.0601181714330.6878@localhost.localdomain>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05737A9F@scsmsx401.amr.corp.intel.com>
	<20060118133629.1cda96fd.akpm@osdl.org>
	<Pine.LNX.4.63.0601181714330.6878@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: davidel@xmailserver.org
Cc: akpm@osdl.org, tony.luck@intel.com, linux-arch@vger.kernel.org, janak@us.ibm.com, drepper@redhat.com, dwmw2@infradead.org, dhowells@redhat.com, christoph@lameter.com
List-ID: <linux-arch.vger.kernel.org>

From: Davide Libenzi <davidel@xmailserver.org>
Date: Wed, 18 Jan 2006 17:17:20 -0800 (PST)

> How sophisticated this has to be? And what's the expected ETA? The 
> epoll_pwait is really a wrapper around epoll_wait (that did not change at 
> all), so the test in this case should just make sure that the signal 
> behaviour is the one expected.

Something along the lines of a smoke test is probably sufficient.
The platform folks just want to make sure they wired up the
syscall tables correctly, for the most part.
