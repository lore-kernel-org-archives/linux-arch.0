From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 11/11] Use unreachable() in asm-generic/bug.h for  !CONFIG_BUG
 case.
Date: Tue, 15 Sep 2009 08:35:52 -0700
Message-ID: <4AAFB458.3080406@caviumnetworks.com>
References: <4AAEBAC2.1050905@caviumnetworks.com>  <1252965340-31735-11-git-send-email-ddaney@caviumnetworks.com> <73c1f2160909141612i32f46361q7430cecf0b68d07b@mail.gmail.com> <4AAED18E.7030903@caviumnetworks.com> <alpine.LFD.2.01.0909141637250.4950@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:15968 "EHLO
	smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbZIOPvB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Sep 2009 11:51:01 -0400
In-Reply-To: <alpine.LFD.2.01.0909141637250.4950@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Brian Gerst <brgerst@gmail.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

Linus Torvalds wrote:
> 
> On Mon, 14 Sep 2009, David Daney wrote:
>> The existing code just falls through to whatever happens to follow the BUG().
> 
> Brian was talking BUG_ON().
> 
> And the existing !CONFIG_BUG BUG_ON() is actually set up so that gcc will 
> just optimize it away entirely (yet give the same compile-time warnings as 
> the "real" BUG_ON() does).
> 
> Changing it to "if (cond) unreachable()" is likely to generate _more_ 
> code, which is against the whole point of wanting to disable CONFIG_BUG.
> 

Yes, you are correct.  I said the same thing in the log message for the 
patch.

Really it may be too early for this patch to be appropriate for your 
tree.  GCC-4.5 will probably not be released for several more months, 
and it will be several years before a GCC with __builtin_unreachable() 
is being used by the majority of people compiling kernels.

Ingo had suggested the approach of this patch as a way of eliminating 
many warnings when using !CONFIG_BUG.  I think it clearly makes sense 
for compilers that support __builtin_unreachable(), but clearly it is 
not an unquestionable win if we end up generating larger code.

With this particular patch, I don't really care if you merge it or not. 
  Perhaps I shouldn't have made it part of the set.

The rest of the set I think would make sense for 2.6.32 or 2.6.33.

David Daney
