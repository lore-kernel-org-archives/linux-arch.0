From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFCv2 2/4] Documentation: document nospec helpers
Date: Sat, 6 Jan 2018 21:20:59 -0800
Message-ID: <f7a88365-8936-0d5e-0764-8664429e6305@infradead.org>
References: <20180105145750.53294-1-mark.rutland@arm.com>
 <20180105145750.53294-3-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:42764 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbeAGFV3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jan 2018 00:21:29 -0500
In-Reply-To: <20180105145750.53294-3-mark.rutland@arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: dan.j.williams@intel.com, elena.reshetova@intel.com, corbet@lwn.net, alan@linux.intel.com, peterz@infradead.org, will.deacon@arm.com, gregkh@linuxfoundation.org, tglx@linutronix.de, Paul Turner <pjt@google.com>

On 01/05/18 06:57, Mark Rutland wrote:
> Document the rationale and usage of the new nospec*() helpers.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  Documentation/speculation.txt | 166 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 Documentation/speculation.txt
> 
> diff --git a/Documentation/speculation.txt b/Documentation/speculation.txt
> new file mode 100644
> index 000000000000..748fcd4dcda4
> --- /dev/null
> +++ b/Documentation/speculation.txt
> @@ -0,0 +1,166 @@
> +
> +Typically speculative execution cannot be observed from architectural state,
> +such as the contents of registers. However, in some cases it is possible to
> +observe its impact on microarchitectural state, such as the presence or
> +absence of data in caches. Such state may form side-channels which can be
> +observed to extract secret information.

I'm curious about what it takes to observe this...

or is that covered in the exploit papers?

thanks,
-- 
~Randy
