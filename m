From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
Date: Mon, 9 Mar 2020 10:21:41 -0700
Message-ID: <968af1c2-a5b4-fb48-dfa9-499ec37f677c@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-2-yu-cheng.yu@intel.com>
 <9ae1cf84-1d84-1d34-c0ce-48b0d70b8f3f@intel.com>
 <0f43463e02d1be2af6bcf8ff6917e751ba7676a0.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:24078 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgCIRVp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Mar 2020 13:21:45 -0400
In-Reply-To: <0f43463e02d1be2af6bcf8ff6917e751ba7676a0.camel@intel.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>

On 3/9/20 10:00 AM, Yu-cheng Yu wrote:
> On Wed, 2020-02-26 at 09:57 -0800, Dave Hansen wrote:
>>> index ade4e6ec23e0..8b69ebf0baed 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -3001,6 +3001,12 @@
>>>  			noexec=on: enable non-executable mappings (default)
>>>  			noexec=off: disable non-executable mappings
>>>  
>>> +	no_cet_shstk	[X86-64] Disable Shadow Stack for user-mode
>>> +			applications
>>
>> If we ever add kernel support, "no_cet_shstk" will mean "no cet shstk
>> for userspace"?
> 
> What about no_user_shstk, no_kernel_shstk?

Those are better.

>>> +	no_cet_ibt	[X86-64] Disable Indirect Branch Tracking for user-mode
>>> +			applications
>>> +
>>>  	nosmap		[X86,PPC]
>>>  			Disable SMAP (Supervisor Mode Access Prevention)
>>>  			even if it is supported by processor.
>>
>> BTW, this documentation is misplaced.  It needs to go to the spot where
>> you introduce the code for these options.
> 
> We used to introduce the document later in the series.  The feedback was to
> introduce it first so that readers know what to expect.

To me, that doesn't apply for things that are implemented in this
specific of a spot in the code and *ALSO* might not even make the final
series.


>>> +Note:
>>> +  There is no CET-enabling arch_prctl function.  By design, CET is
>>> +  enabled automatically if the binary and the system can support it.
>>
>> This is kinda interesting.  It means that a JIT couldn't choose to
>> protect the code it generates and have different rules from itself?
> 
> JIT needs to be updated for CET first.  Once that is done, it runs with CET
> enabled.  It can use the NOTRACK prefix, for example.

Am I missing something?

What's the direct connection between shadow stacks and Indirect Branch
Tracking other than Intel marketing umbrellas?

>>> +  The parameters passed are always unsigned 64-bit.  When an IA32
>>> +  application passing pointers, it should only use the lower 32 bits.
>>
>> Won't a 32-bit app calling prctl() use the 32-bit ABI?  How would it
>> even know it's running on a 64-bit kernel?
> 
> The 32-bit app is passing only a pointer to an array of 64-bit numbers.

Well, the documentation just talked about pointers and I naively assume
it means the "unsigned long *" you had in there.

Rather than make suggestions, just say that the ABI is universally
64-bit.  Saying that the pointers must be valid is just kinda silly.
It's also not 100% clear what an "IA32 application" *MEANS* given fun
things like x32.

Also, I went to go find this implementation in your series.  I couldn't
find it.  Did I miss a patch?  Or are you documenting things you didn't
even implement?
