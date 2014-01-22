From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 31/73] module: relocate module_init from init.h to module.h
Date: Tue, 21 Jan 2014 16:43:19 -0800
Message-ID: <52DF1427.20603@infradead.org>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com> <1390339396-3479-32-git-send-email-paul.gortmaker@windriver.com> <87ha8w50s9.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:42012 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbaAVAnX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2014 19:43:23 -0500
In-Reply-To: <87ha8w50s9.fsf@rustcorp.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org

On 01/21/2014 04:16 PM, Rusty Russell wrote:
> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
>> Modular users will always be users of init functionality, but
>> users of init functionality are not necessarily always modules.
>>
>> Hence any functionality like module_init and module_exit would
>> be more at home in the module.h file.  And module.h should
>> explicitly include init.h to make the dependency clear.
>>
>> We've already done all the legwork needed to ensure that this
>> move does not cause any build regressions due to implicit
>> header file include assumptions about where module_init lives.
>>
>> Cc: Rusty Russell <rusty@rustcorp.com.au>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> Acked-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> Want to delete the extraneous semicolons, for bonus points? :)
> 
>> +#define module_init(x)	__initcall(x);
> ...
>> +#define module_exit(x)	__exitcall(x);


There are still around 380 modules that use "module_init(x)" without
a trailing semi-colon.  That would make lots of build errors/warnings,
I think.  There was also a 2012 patch to fix those and change the
module_init() macro.

What happened there?

ISTR (maybe incorrectly) that Linus once argued for leaving the trailing
semi-colon there (perhaps 8 years ago).  who knows?


-- 
~Randy
