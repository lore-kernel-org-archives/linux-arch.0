Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:17035 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbXDLOtF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Apr 2007 10:49:05 -0400
Message-ID: <461E476D.4030509@oracle.com>
Date: Thu, 12 Apr 2007 07:51:25 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
MIME-Version: 1.0
Subject: Re: + expose-range-checking-functions-from-arch-specific.patch added
 to -mm tree
References: <1176334892.14322.137.camel@localhost.localdomain>  <20070410194834.b688ce55.akpm@linux-foundation.org> <200704062127.l36LRMA7019394@shell0.pdx.osdl.net> <6632.1176200270@redhat.com> <1176257950.26372.50.camel@localhost.localdomain> <14926.1176288559@redhat.com> <20070411112452.6979414c.akpm@linux-foundation.org> <720.1176374867@redhat.com>
In-Reply-To: <720.1176374867@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Howells wrote:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
>> +static inline bool range_over_limit(unsigned long start, unsigned long len,
>> +				    unsigned long limit)
> 
> I like it.
> 
>> + * range_over_limit() - is a start and length past a limit?
> 
> As I understand it you wouldn't normally put "()" there for kdoc comments.

Correct, but scripts/kernel-doc filters out the "()" for its output.

-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
