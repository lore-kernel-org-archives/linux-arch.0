Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:26053 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932234AbWCHSfZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2006 13:35:25 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060308173605.GB13063@devserv.devel.redhat.com> 
References: <20060308173605.GB13063@devserv.devel.redhat.com>  <20060308145506.GA5095@devserv.devel.redhat.com> <31492.1141753245@warthog.cambridge.redhat.com> <29826.1141828678@warthog.cambridge.redhat.com> <9834.1141837491@warthog.cambridge.redhat.com> 
Subject: Re: [PATCH] Document Linux's memory barriers [try #2] 
Date: Wed, 08 Mar 2006 18:35:07 +0000
Message-ID: <11922.1141842907@warthog.cambridge.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Alan Cox <alan@redhat.com> wrote:

> spin_unlock ensures that local CPU writes before the lock are visible
> to all processors before the lock is dropped but it has no effect on 
> I/O ordering. Just a need for clarity.

So I can't use spinlocks in my driver to make sure two different CPUs don't
interfere with each other when trying to communicate with a device because the
spinlocks don't guarantee that I/O operations will stay in effect within the
locking section?

David
