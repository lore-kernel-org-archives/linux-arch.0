Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20399 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751171AbWCLRRE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 12 Mar 2006 12:17:04 -0500
Subject: Re: [PATCH] Document Linux's memory barriers [try #4]
References: <16835.1141936162@warthog.cambridge.redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 12 Mar 2006 10:15:20 -0700
In-Reply-To: <16835.1141936162@warthog.cambridge.redhat.com> (David
 Howells's message of "Thu, 09 Mar 2006 20:29:22 +0000")
Message-ID: <m1veujy47r.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, alan@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


A small nit.  You are not documenting the most subtle memory barrier:
smp_read_barrier_depends();  Which is a deep requirement of the RCU
code.

As I understand it.  On some architectures (alpha) without at least
this a load from a pointer can load from the an old pointer value.

At one point it was suggested this be called: 
read_memory_barrier_data_dependent().

Simply calling: rcu_dereference is what all users should call but
the semantics should be documented at least so that people porting
Linux can have a chance of getting it right.

Eric
