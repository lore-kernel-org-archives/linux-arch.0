Return-Path: <minyard@acm.org>
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:39137 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263152AbUCSXhn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Mar 2004 18:37:43 -0500
Message-ID: <405B8443.40701@acm.org>
Date: Fri, 19 Mar 2004 17:37:39 -0600
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
Subject: Re: signal-race-fix.patch
References: <20040319120151.380dcbc9.akpm@osdl.org>	<20040319141258.338c91b1.davem@redhat.com>	<405B773B.8010705@acm.org> <20040319152821.3c306ccc.davem@redhat.com>
In-Reply-To: <20040319152821.3c306ccc.davem@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, roland@redhat.com
List-ID: <linux-arch.vger.kernel.org>

David S. Miller wrote:

>On Fri, 19 Mar 2004 16:42:03 -0600
>Corey Minyard <minyard@acm.org> wrote:
>
>  
>
>>BTW, here is a new patch that covers that problem.
>>    
>>
>
>Ok, I'll cook up the sparc bits.
>
>Although I can just see someone updating something in the 'ka' and
>expecting it to take effect, then spending a serious amount of time
>debugging only to find it's a pointer to a stack local copy of the
>info.
>
>:-)
>  
>
True.  I should probably rename the variable to ka_copy, or something 
like that to avoid somebody using it.  It actually happens in another 
place in the code, too, on x86.  There is a situation in setup_frame() 
and setup_rt_frame() where if it cannot write the signal frame to the 
stack, it sets the handler to SIG_DFL if it is a SEGV.

I'm not sure what to do about that one yet.

-Corey
