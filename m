From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 12/12] tracing: Rename update the enum_map file
Date: Wed, 14 Jun 2017 13:06:15 -0400
Message-ID: <20170614130615.1c841159@gandalf.local.home>
References: <20170531215653.3240-1-jeremy.linton@arm.com>
        <20170531215653.3240-13-jeremy.linton@arm.com>
        <20170613171255.5090de5b@gandalf.local.home>
        <d111f8c9-1a31-c447-8f2e-8360df6ef835@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751904AbdFNRGU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Jun 2017 13:06:20 -0400
In-Reply-To: <d111f8c9-1a31-c447-8f2e-8360df6ef835@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, rusty@rustcorp.com.au, jeyu@redhat.com, kirill.shutemov@linux.intel.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, jcm@jonmasters.org

On Tue, 13 Jun 2017 16:21:48 -0500
Jeremy Linton <jeremy.linton@arm.com> wrote:

> > Hmm, I have to audit some userspace code to see if this is used. The
> > enum_map was a debug feature, but it could have been used by some tools.  
> 
> I thought perf was using it, but I was mistaken. I didn't find anything 
> using it, but to be on the safe side I placed this patch last so it 
> could be dropped if a user was found. The CONFIG option seems to be 
> disabled in the couple distro's I checked, further indicating that if 
> someone is using it, they are seemingly obscure.

I pulled in all your patches but the samples one. Could you update that
with a use case as well. You can create some crazy struct that you want
to get the size of, or whatever. Maybe make an array out of it? Or I
can come up with something creative.

I'll start testing your patches and do a push in a few days.

-- Steve
