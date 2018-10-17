Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:60370 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeJRGhs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Oct 2018 02:37:48 -0400
Subject: Re: [PATCH v5 03/27] x86/fpu/xstate: Introduce XSAVES system states
References: <20181011151523.27101-1-yu-cheng.yu@intel.com>
 <20181011151523.27101-4-yu-cheng.yu@intel.com>
 <20181017104137.GE22535@zn.tnic>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <32da559b-7958-60db-e328-f0eb316e668e@infradead.org>
Date: Wed, 17 Oct 2018 15:39:47 -0700
MIME-Version: 1.0
In-Reply-To: <20181017104137.GE22535@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>, Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20181017223947.up-6yoNLfzAiBmNFlYGYQdwJR-vU5Di9nw5vFBuyTXo@z>

On 10/17/18 3:41 AM, Borislav Petkov wrote:

>> @@ -702,6 +703,7 @@ static int init_xstate_size(void)
>>   */
>>  static void fpu__init_disable_system_xstate(void)
>>  {
>> +	xfeatures_mask_all = 0;
>>  	xfeatures_mask_user = 0;
>>  	cr4_clear_bits(X86_CR4_OSXSAVE);
>>  	fpu__xstate_clear_all_cpu_caps();
>> @@ -717,6 +719,8 @@ void __init fpu__init_system_xstate(void)
>>  	static int on_boot_cpu __initdata = 1;
>>  	int err;
>>  	int i;
>> +	u64 cpu_user_xfeatures_mask;
>> +	u64 cpu_system_xfeatures_mask;
> 
> Please sort function local variables declaration in a reverse christmas
> tree order:
> 
> 	<type> longest_variable_name;
> 	<type> shorter_var_name;
> 	<type> even_shorter;
> 	<type> i;

Hi,

Would you mind explaining this request? (requirement?)
Other than to say that it is the preference of some maintainers,
please say Why it is preferred.

and since the <type>s above won't typically be the same length,
it's not for variable name alignment, right?

thanks,
-- 
~Randy
