Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:40845 "HELO
	smtp108.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758089AbXHPBVE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Aug 2007 21:21:04 -0400
Message-ID: <46C3A675.7050108@yahoo.com.au>
Date: Thu, 16 Aug 2007 11:20:53 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH 6/24] make atomic_read() behave consistently on frv
References: <20070809134150.GA14890@shell.boston.redhat.com> <2708.1186737826@redhat.com> <7680.1186822071@redhat.com> <46BFFDBD.6080804@redhat.com> <46C140DD.3060509@yahoo.com.au> <2cbda24e96a49c3ab7cf7039c515f9fc@kernel.crashing.org> <20070815191829.GJ9645@linux.vnet.ibm.com> <369924c4b3132a4b06258b7ac81b1006@kernel.crashing.org> <20070815195915.GL9645@linux.vnet.ibm.com> <d2cd1065faf8a13040e8a2405c363aa1@kernel.crashing.org> <20070815203836.GO9645@linux.vnet.ibm.com> <7131d547746a998fcec74d1c091f9f6a@kernel.crashing.org>
In-Reply-To: <7131d547746a998fcec74d1c091f9f6a@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: paulmck@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, horms@verge.net.au, linux-kernel@vger.kernel.org, rpjday@mindspring.com, ak@suse.de, netdev@vger.kernel.org, cfriesen@nortel.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-arch@vger.kernel.org, jesper.juhl@gmail.com, zlynx@acm.org, schwidefsky@de.ibm.com, Chris Snook <csnook@redhat.com>, davem@davemloft.net, wensong@linux-vs.org, wjiang@resilience.com, David Howells <dhowells@redhat.com>
List-ID: <linux-arch.vger.kernel.org>

Segher Boessenkool wrote:
>> Please check the definition of "cache coherence".
> 
> 
> Which of the twelve thousand such definitions?  :-)

Every definition I have seen says that writes to a single memory
location have a serial order as seen by all CPUs, and that a read
will return the most recent write in the sequence (with a bit of
extra mumbo jumbo to cover store queues and store forwarding).

Within such a definition, I don't see how would be allowed for a
single CPU to execute reads out of order and have the second read
return an earlier write than the first read.

-- 
SUSE Labs, Novell Inc.
