From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v8 01/28] linkage: new macros for assembler symbols
Date: Thu, 29 Aug 2019 12:48:24 +0200
Message-ID: <f077becf-8ea7-cb4b-d704-5e59a8d69c56@suse.cz>
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-2-jslaby@suse.cz> <20190812170652.GJ23772@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190812170652.GJ23772@zn.tnic>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Ingo Molnar <mingo@kernel.org>, jpoimboe@redhat.com, Juergen Gross <jgross@suse.com>, Len Brown <len.brown@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, xen-devel@lists.xenproject.org
List-Id: linux-arch.vger.kernel.org

On 12. 08. 19, 19:06, Borislav Petkov wrote:
>> +  Again, every ``SYM_CODE_START*`` **shall** be coupled by ``SYM_CODE_END``.
> 
> Btw, this coupling: I haven't gone through the whole patchset but do we
> have automatic checking which makes sure a starting macro is coupled
> with the correct ending macro?

I do, but it's not part of this series. It's a pinch of link-time magic,
but it works reliably (see e.g. 1cbec37b3f9c). I will post it if/after
this gets merged. There were other approaches proposed in the past too
-- using objtool for that (not implemented).

>> +Overriding Macros
>> +~~~~~~~~~~~~~~~~~
>> +Architecture can also override any of the macros in their own
> 
> "Other architectures... "

Not only "other", x86 can override the types if need be too.

>> +``asm/linkage.h``, including macros specifying the type of a symbol
>> +(``SYM_T_FUNC``, ``SYM_T_OBJECT``, and ``SYM_T_NONE``).  As every macro
>> +described in this file is surrounded by ``#ifdef`` + ``#endif``, it is enough
>> +to define the macros differently in the aforementioned architecture-dependent
>> +header.

thanks,
-- 
js
suse labs
