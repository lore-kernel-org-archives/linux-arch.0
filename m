Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:51910 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754047AbcFPWWZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Jun 2016 18:22:25 -0400
Subject: Re: cmpxchg and x86 flags output
References: <40fd5f74-190e-b805-fbaa-f84899190fbc@zytor.com>
 <20160615085002.GC30935@twins.programming.kicks-ass.net>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <5e5b99d7-c739-9743-b3e0-fbe0636d6dee@zytor.com>
Date: Thu, 16 Jun 2016 15:21:41 -0700
MIME-Version: 1.0
In-Reply-To: <20160615085002.GC30935@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, David Howells <dhowells@redhat.com>
Message-ID: <20160616222141.ZKjgmEHqVfjLDswpg8CLqtWD5ZxwkybVfdEPYsjB2QU@z>

On 06/15/16 01:50, Peter Zijlstra wrote:
>>
>> It seems to me that the sanest way to handle this is to add a new
>> interface with a fourth parameter, so:
>>
>> 	changed = cmpxchgx(ptr, old, new, out);
> 
> See also:
> 
>   lkml.kernel.org/r/146358429016.8596.3381723959064491676.stgit@warthog.procyon.org.uk
> 
> where David suggests the same.
> 
>>
>> A generic implementation of cmpxchgx() would be provided, looking like:
>>
>> #define cmpxchgx(ptr, old, new, out) ({			\
>> 	__typeof__((*(ptr))) __old = (old);		\
>> 	__typeof__((*(ptr))) __new = (new);		\
>> 	__typeof__((*(ptr))) __old = (old);		\
>> 	__typeof__((*(ptr))) __out; 			\
>> 	(out) = __out = cmpxchg(ptr, __old, __new);	\
>> 	(__old != __out);				\
>> })
>>
>> ... and so on for all the many other variants.
>>
>> However, I'm wondering how well this will fit in with other
>> architectures.
> 
> All ll/sc based archs also already know if the operation succeeded
> without having to do the extra comparison.
> 
> SPARCv9,S390x which are native CAS architectures, also places the
> success of the operation in condition codes.
> 
> IA64 might be the odd duck out (or I'm not reading the manual right,
> which is entirely possible).
> 
>> Keep in mind gcc will probably gain this ability for
>> other architectures with flags at some point, although that doesn't
>> inherently mean that cmpxchg will be able to make use of it.
>>
>> This means a lot of changes even to common code, so I want to make sure
>> the interface is right before embarking on an implementation.
>>
>> Thoughts?
> 
> David has already done lots of the conversions for you.
> 

Well, that sounds promising.  I wonder how David's model, using
intrinsics (do we have enough intrinsics to actually be able to do this
"correctly"?), compare to using the flags output from assembly.

	-hpa

