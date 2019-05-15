Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34783 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfEOPkU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 May 2019 11:40:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id p27so499891eda.1
        for <linux-arch@vger.kernel.org>; Wed, 15 May 2019 08:40:19 -0700 (PDT)
Date: Wed, 15 May 2019 17:40:15 +0200
From: Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 1/2] pid: add pidfd_open()
Message-ID: <20190515154014.4jaxuw4fcgbusnbt@brauner.io>
References: <20190515100400.3450-1-christian@brauner.io>
 <20190515143857.GB18892@redhat.com>
 <20190515153515.GA20783@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190515153515.GA20783@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: jannh@google.com, viro@zeniv.linux.org.uk, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, arnd@arndb.de, dhowells@redhat.com, akpm@linux-foundation.org, cyphar@cyphar.com, ebiederm@xmission.com, elena.reshetova@intel.com, keescook@chromium.org, luto@amacapital.net, luto@kernel.org, tglx@linutronix.de, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <20190515154015.qp5C0gcA5ddLRYPBEvNUDLvyRilPq05yxOmWSsBpgGY@z>

On Wed, May 15, 2019 at 05:35:15PM +0200, Oleg Nesterov wrote:
> On 05/15, Oleg Nesterov wrote:
> >
> > On 05/15, Christian Brauner wrote:
> > >
> > > +SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
> > > +{
> > > +	int fd, ret;
> > > +	struct pid *p;
> > > +	struct task_struct *tsk;
> > > +
> > > +	if (flags)
> > > +		return -EINVAL;
> > > +
> > > +	if (pid <= 0)
> > > +		return -EINVAL;
> > > +
> > > +	p = find_get_pid(pid);
> > > +	if (!p)
> > > +		return -ESRCH;
> > > +
> > > +	rcu_read_lock();
> > > +	tsk = pid_task(p, PIDTYPE_PID);
> >
> > You do not need find_get_pid() before rcu_lock and put_pid() at the end.
> > You can just do find_vpid() under rcu_read_lock().
> 
> Ah, sorry. Somehow I forgot you need to call pidfd_create(pid), you can't
> do this under rcu_read_lock().
> 
> So I was wrong, you can't avoid get/put_pid.

Yeah, I haven't made any changes yet.

Christian
