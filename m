Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from a9-74.smtp-out.amazonses.com ([54.240.9.74]:54127 "EHLO
	a9-74.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756310Ab3IDOUB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 Sep 2013 10:20:01 -0400
Date: Wed, 4 Sep 2013 14:19:59 +0000
From: Christoph Lameter <cl@linux.com>
Subject: Re: [gcv v3 10/35] rcu: Replace __get_cpu_var uses
In-Reply-To: <20130831203559.GY3871@linux.vnet.ibm.com>
Message-ID: <00000140e95815db-41b26a90-9bc9-490e-a313-e05364a152cb-000000@email.amazonses.com>
References: <20130828193457.140443630@linux.com> <00000140c67825ee-d9e3a1ca-2e81-4868-8c8c-36ba965f7202-000000@email.amazonses.com> <20130831203559.GY3871@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Tejun Heo <tj@kernel.org>, akpm@linuxfoundation.org, Dipankar Sarma <dipankar@in.ibm.com>, linux-arch@vger.kernel.org, Steven Rostedt <srostedt@redhat.com>, linux-kernel@vger.kernel.org
Message-ID: <20130904141959.fLAi9x7dRxQ9wQSZZEbvlPDT3L9-eNtTF-577L9lTzQ@z>

On Sat, 31 Aug 2013, Paul E. McKenney wrote:

> Queued for 3.13.  I had to rework for conflicts, please see below for
> the update patch.

Looks fine to me. Can I drop the rcu patches from my patchset?

