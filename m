From: "H. Peter Anvin" <hpa@kernel.org>
Subject: Re: [PATCH 1/2] UNREACHABLE() macro
Date: Fri, 11 Sep 2009 21:43:42 -0700
Message-ID: <4AAB26FE.7010309@kernel.org>
References: <20090910015923.8FB628AE5F@magilla.sf.frob.com>	<20090910020031.87DC68BF6E@magilla.sf.frob.com>	<20090911134528.cd1782d9.akpm@linux-foundation.org>	<20090911215525.12B366A98F@magilla.sf.frob.com> <20090912054906.22b05848@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:51258 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbZILFMq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 12 Sep 2009 01:12:46 -0400
In-Reply-To: <20090912054906.22b05848@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org, jakub@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org

On 09/11/2009 08:49 PM, Arjan van de Ven wrote:
> On Fri, 11 Sep 2009 14:55:25 -0700 (PDT)
> Roland McGrath <roland@redhat.com> wrote:
> 
>>> That's a bit of a mouthful.  Did you consider a runtime probe with
>>> scripts/Kbuild.include's try-run, cc-option, etc?  
>>
>> I did not see any precedent in the sources for using those to test for
>> features by compiling particular test sources (i.e. in autoconf
> 
> look at the stackprotector flags.. they work this way already.
> It gets done once per kernel build...
> 

That works for flags, but not for the presence of builtin functions.
You can't even just try compiling something, since it will turn into an
ordinary function if not present... not obvious until link.

	-hpa
