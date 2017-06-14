From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH 12/12] tracing: Rename update the enum_map file
Date: Wed, 14 Jun 2017 13:43:26 -0500
Message-ID: <ffb8c5fa-4ea7-cbea-b7ea-f88c0a49548b@arm.com>
References: <20170531215653.3240-1-jeremy.linton@arm.com>
 <20170531215653.3240-13-jeremy.linton@arm.com>
 <20170613171255.5090de5b@gandalf.local.home>
 <d111f8c9-1a31-c447-8f2e-8360df6ef835@arm.com>
 <20170614130615.1c841159@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751628AbdFNSn3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Jun 2017 14:43:29 -0400
In-Reply-To: <20170614130615.1c841159@gandalf.local.home>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, rusty@rustcorp.com.au, jeyu@redhat.com, kirill.shutemov@linux.intel.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, jcm@jonmasters.org

On 06/14/2017 12:06 PM, Steven Rostedt wrote:
> On Tue, 13 Jun 2017 16:21:48 -0500
> Jeremy Linton <jeremy.linton@arm.com> wrote:
> 
>>> Hmm, I have to audit some userspace code to see if this is used. The
>>> enum_map was a debug feature, but it could have been used by some tools.
>>
>> I thought perf was using it, but I was mistaken. I didn't find anything
>> using it, but to be on the safe side I placed this patch last so it
>> could be dropped if a user was found. The CONFIG option seems to be
>> disabled in the couple distro's I checked, further indicating that if
>> someone is using it, they are seemingly obscure.
> 
> I pulled in all your patches but the samples one. Could you update that
> with a use case as well. You can create some crazy struct that you want
> to get the size of, or whatever. Maybe make an array out of it? Or I
> can come up with something creative.

I was actually working on that, it seems that the existing sample has 
the problem because of the __print_array(...sizeof(int)) case. So I 
think my general plan was just to update it to TRACE_DEFINE_SIZEOF(int).

Do you want a more complex example?

But this lead me to discover a number of other __print_array() cases 
where people have hardcoded the size, so I was running through those and 
converting them to sizeof() since it should work now.

> 
> I'll start testing your patches and do a push in a few days.
> 
> -- Steve
> 
