Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:34621 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170AbZJNHTR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 Oct 2009 03:19:17 -0400
Date: Wed, 14 Oct 2009 09:18:38 +0200
From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [v8 PATCH 2/8]: cpuidle: implement a list based approach to register a set of idle routines.
Message-ID: <20091014071838.GE23248@one.firstfloor.org>
References: <20091008094828.GA20595@linux.vnet.ibm.com> <20091008095027.GC20595@linux.vnet.ibm.com> <1254998162.26976.270.camel@twins> <20091008104249.GJ20595@linux.vnet.ibm.com> <1254999033.26976.272.camel@twins> <8763akh4re.fsf@basil.nowhere.org> <20091014061727.GA8605@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091014061727.GA8605@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Cc: Andi Kleen <andi@firstfloor.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@elte.hu>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Dipankar Sarma <dipankar@in.ibm.com>, Balbir Singh <balbir@in.ibm.com>, Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org
Message-ID: <20091014071838.M84eqS9XVAO1D7p9tAuD5AX3LmwSAxcCVW2g0AaR3F4@z>

> How about something like this..
> If the arch does not enable CONFIG_CPU_IDLE, the cpuidle_idle_call
> which is called from cpu_idle() should call default_idle without
> involving the registering cpuidle steps. This should prevent bloating
> up of the kernel for archs which dont want to use cpuidle.

On x86 some people want small kernel too, so selecting it on a architecture
granuality is not good. Also you can make it default, you just need
to slim it down first.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
