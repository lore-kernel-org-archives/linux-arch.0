Return-Path: <minyard@acm.org>
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:5019 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263138AbUCSWiU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Mar 2004 17:38:20 -0500
Message-ID: <405B765A.1090505@acm.org>
Date: Fri, 19 Mar 2004 16:38:18 -0600
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
Subject: Re: signal-race-fix.patch
References: <20040319120151.380dcbc9.akpm@osdl.org> <20040319141258.338c91b1.davem@redhat.com>
In-Reply-To: <20040319141258.338c91b1.davem@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, roland@redhat.com
List-ID: <linux-arch.vger.kernel.org>

David S. Miller wrote:

>On Fri, 19 Mar 2004 12:01:51 -0800
>Andrew Morton <akpm@osdl.org> wrote:
>
>  
>
>>We have an SMP race in the signal code.  A fix for x86 is below.  All archs
>>need updating.
>>    
>>
>
>I think the fix may need fixing :-)
>
>Now that we're passing a stack local k_sigaction into handle_signal()
>the real sigaction is not being updated f.e. when SA_ONESHOT causes
>ka->sa.sa_handler to be set to SIG_DFL.  Only the stack local copy
>is going to be set like this, not the one in the signals struct which
>is where it is needed.
>
>I noticed this while coding up the sparc versions which I'll defer until
>this is cleared up.
>  
>
Yes, I see that now.  Is there some reason that get_signal_to_deliver() 
does not do modify ka->sa.sa_handler?

-Corey
