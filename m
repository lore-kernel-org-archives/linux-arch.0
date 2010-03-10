From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH/RFC 1/8] numa: prep:  move generic percpu interface definitions
 to percpu-defs.h
Date: Wed, 10 Mar 2010 18:06:16 +0900
Message-ID: <4B976108.1010404@kernel.org>
References: <20100304170654.10606.32225.sendpatchset@localhost.localdomain>	 <20100304170702.10606.85808.sendpatchset@localhost.localdomain>	 <4B960AD0.8010709@kernel.org> <1268144009.27921.9.camel@useless.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50187 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755985Ab0CJJHL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Mar 2010 04:07:11 -0500
In-Reply-To: <1268144009.27921.9.camel@useless.americas.hpqcorp.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-numa@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>, Andi Kleen <andi@firstfloor.org>, Christoph Lameter <cl@linux-foundation.org>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>, akpm@linux-foundation.org, eric.whitney@hp.com

Hello,

On 03/09/2010 11:13 PM, Lee Schermerhorn wrote:
>> Hmmm... I think uninlining !SMP case would be much cleaner.  Sorry
>> that you had to do it twice.  I'll break the dependency in the percpu
>> devel branch and let you know.
> 
> OK, I'll do that for V4.  It'll be one big ugly patch because of all the
> dependencies.  But, it's really just a mechanical change.

Just in case it wasn't clear.  I'm giving it a shot right now.  I
don't think it will be too ugly and it's something which should be
done whether ugly or not.  I'll let you know how it turns out.

Thanks.

-- 
tejun
