Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: TASK_SIZE is variable.
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20050125155239.4bc469e6.davem@davemloft.net>
References: <1106692012.6480.158.camel@localhost.localdomain>
	 <20050125155239.4bc469e6.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 26 Jan 2005 07:54:45 +0000
Message-Id: <1106726086.6480.171.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2005-01-25 at 15:52 -0800, David S. Miller wrote:
> I think the easiest way to fix this for good is to simply
> kill off TASK_SIZE and that way each and every use will be
> audited.  We can replace TASK_SIZE with something the describes
> what is really wanted:

You're right. And we should replace MM_VM_SIZE() too -- as you say,
nobody uses the (mm) argument because it's useless.

TASK_SIZE should be renamed to current_task_size(), because that's what
it actually does. MM_VM_SIZE(mm) should become MAX_TASK_SIZE, for much
the same reason. 

Then perhaps we can also add thread_task_size(tsk) in case any of the
current users of MM_VM_SIZE() or the currently-broken users of TASK_SIZE
actually have access to the thread_info in question and really want the
real answer instead of MAX_TASK_SIZE.

-- 
dwmw2
