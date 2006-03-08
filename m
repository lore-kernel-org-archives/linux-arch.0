Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:21181 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752070AbWCHHlf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Mar 2006 02:41:35 -0500
Message-ID: <440E8AAA.9030609@yahoo.com.au>
Date: Wed, 08 Mar 2006 18:41:30 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH] Document Linux's memory barriers
References: <31492.1141753245@warthog.cambridge.redhat.com> <17422.19209.60360.178668@cargo.ozlabs.ibm.com>
In-Reply-To: <17422.19209.60360.178668@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Paul Mackerras wrote:
> David Howells writes:

>>+     The way to deal with this is to insert an I/O memory barrier between the
>>+     two accesses:
>>+
>>+	*ADR = ctl_reg_3;
>>+	mb();
>>+	reg = *DATA;
> 
> 
> Ummm, this implies mb() is "an I/O memory barrier".  I can see people
> getting confused if they read this and then see mb() being used when
> no I/O is being done.
> 

Isn't it? Why wouldn't you just use smp_mb() if no IO is being done?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
