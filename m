From: Steven Rostedt <srostedt@redhat.com>
Subject: Re: [PATCH 6/9 UPDATED] percpu: enforce global definition
Date: Thu, 18 Jun 2009 09:26:37 -0400
Message-ID: <1245331597.5195.8.camel@localhost.localdomain>
References: <1245210060-24344-1-git-send-email-tj@kernel.org>
	 <1245210060-24344-7-git-send-email-tj@kernel.org>
	 <4A39EF13.7010309@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:36244 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753684AbZFRNhc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 Jun 2009 09:37:32 -0400
In-Reply-To: <4A39EF13.7010309@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, kyle@mcmartin.ca, cl@linux-foundation.org, Jesper.Nilsson@axis.com, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, David Howells <dhowells@redhat.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, arm@redhat.com


On Thu, 2009-06-18 at 16:38 +0900, Tejun Heo wrote:
> Some archs (alpha and s390) need to add 'weak' attribute to percpu
> variable definitions so that the compiler generates external
> references for them.  To allow this, enforce global definition of all
> percpu variables.
> 
> This patch makes DEFINE_PER_CPU_SECTION() do DECLARE_PERCPU_SECTION()
> implicitly and drop static from all percpu definitions.
> 
> [ Impact: all percpu variables are forced to be global ]
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Christoph Lameter <cl@linux-foundation.org>
> Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

Uh, wont this cause name space collisions?

-- Steve
