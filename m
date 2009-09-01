Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:64048 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795AbZIAR1E (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 1 Sep 2009 13:27:04 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20090901171649.GA16779@flint.arm.linux.org.uk>
References: <20090901171649.GA16779@flint.arm.linux.org.uk> <20090901163231.14180.43426.stgit@warthog.procyon.org.uk> <20090901163307.14180.64201.stgit@warthog.procyon.org.uk>
Subject: Re: [PATCH [try #4] 8/9] KEYS: Extend TIF_NOTIFY_RESUME to (almost) all architectures
Date: Tue, 01 Sep 2009 18:26:04 +0100
Message-ID: <14644.1251825964@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: dhowells@redhat.com, jmorris@namei.org, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20090901172604.hQKb7Dd5XPlpIoPqP9HEclZNJxtNKSNZNlG2YseKB4M@z>

Russell King <rmk@arm.linux.org.uk> wrote:

> > @@ -707,4 +707,9 @@ do_notify_resume(struct pt_regs *regs, unsigned int thread_flags, int syscall)
> >  {
> >  	if (thread_flags & _TIF_SIGPENDING)
> >  		do_signal(&current->blocked, regs, syscall);
> > +
> > +	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
> 
> Shouldn't this be thread_flags ?

Yes, thanks.  Fixed.

David
