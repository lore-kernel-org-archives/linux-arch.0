From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 03/20] percpu: rename 4k first chunk allocator to page
Date: Wed, 22 Jul 2009 13:38:49 +0900
Message-ID: <4A6697D9.1000704@kernel.org>
References: <1248171979-29166-1-git-send-email-tj@kernel.org> <1248171979-29166-4-git-send-email-tj@kernel.org> <alpine.DEB.1.10.0907211745080.25867@gentwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38819 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901AbZGVEkH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Jul 2009 00:40:07 -0400
In-Reply-To: <alpine.DEB.1.10.0907211745080.25867@gentwo.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, benh@kernel.crashing.org, davem@davemloft.net, dhowells@redhat.com, npiggin@suse.de, JBeulich@novell.com, rusty@rustcorp.com.au, hpa@zytor.com, tglx@linutronix.de, akpm@linux-foundation.org, x86@kernel.org, andi@firstfloor.org

Christoph Lameter wrote:
> On Tue, 21 Jul 2009, Tejun Heo wrote:
> 
>> - * Boring fallback 4k allocator.  This allocator puts more pressure on
>> - * PTE TLBs but other than that behaves nicely on both UMA and NUMA.
>> + * Boring fallback 4k page allocator.  This allocator puts more
> 
> Guess this should not mentione 4k anymroe? page size allocation?

That's x86 specific code and PAGE_SIZE is always 4k there, so....
Also, this comment gets completely deleted by later patches anyway.

>>  				pr_warning("PERCPU: %s allocator failed (%zd), "
>> -					   "falling back to 4k\n",
>> +					   "falling back to page\n",
> 
> "falling back to page size"?

So updated.

Thanks.

-- 
tejun
