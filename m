From: Christoph Lameter <cl@linux.com>
Subject: Re: [gcv v3 10/35] rcu: Replace __get_cpu_var uses
Date: Wed, 4 Sep 2013 19:51:31 +0000
Message-ID: <00000140ea879e64-44399484-986b-47da-be12-5f3cd4da7abb-000000@email.amazonses.com>
References: <20130828193457.140443630@linux.com> <00000140c67825ee-d9e3a1ca-2e81-4868-8c8c-36ba965f7202-000000@email.amazonses.com> <20130831203559.GY3871@linux.vnet.ibm.com> <00000140e95815db-41b26a90-9bc9-490e-a313-e05364a152cb-000000@email.amazonses.com>
 <20130904194135.GD3966@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from a194-110.smtp-out.amazonses.com ([199.255.194.110]:6655 "EHLO
	a194-110.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755664Ab3IDTvf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 Sep 2013 15:51:35 -0400
In-Reply-To: <20130904194135.GD3966@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Tejun Heo <tj@kernel.org>, akpm@linuxfoundation.org, Dipankar Sarma <dipankar@in.ibm.com>, linux-arch@vger.kernel.org, Steven Rostedt <srostedt@redhat.com>, linux-kernel@vger.kernel.org

On Wed, 4 Sep 2013, Paul E. McKenney wrote:

> Yep, still queued for 3.13, and I even redid the change in
> rcu_is_cpu_idle() to be the way you wanted it.  I wouldn't do that for
> just anyone, you know!  ;-)

Well not everyone is so perfect as you are and has a tree for another
version of the kernel ahead of time.
