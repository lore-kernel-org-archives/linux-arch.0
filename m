Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:46251 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752115AbWCOBZY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Mar 2006 20:25:24 -0500
Message-ID: <44176CF9.90909@yahoo.com.au>
Date: Wed, 15 Mar 2006 12:25:13 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH] Document Linux's memory barriers [try #4]
References: <17431.14867.211423.851470@cargo.ozlabs.ibm.com>  <m1veujy47r.fsf@ebiederm.dsl.xmission.com> <16835.1141936162@warthog.cambridge.redhat.com> <32068.1142371612@warthog.cambridge.redhat.com>  <2301.1142380768@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0603141609520.3618@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603141609520.3618@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>, "Eric W. Biederman" <ebiederm@xmission.com>, akpm@osdl.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, alan@redhat.com, linuxppc64-dev@ozlabs.org
List-ID: <linux-arch.vger.kernel.org>

Linus Torvalds wrote:

>
>On Tue, 14 Mar 2006, David Howells wrote:
>
>>But that doesn't make any sense!
>>
>>That would mean we that we'd've read b into d before having read the new value
>>of p into q, and thus before having calculated the address from which to read d
>>(ie: &b) - so how could we know we were supposed to read d from b and not from
>>a without first having read p?
>>
>>Unless, of course, the smp_wmb() isn't effective, and the write to b happens
>>after the write to p; or the Alpha's cache isn't fully coherent.
>>
>
>The cache is fully coherent, but the coherency isn't _ordered_.
>
>

This is what I was referring to when I said your (David's) idea of "memory"
WRT memory consistency isn't correct -- cache coherency can be out of order.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
