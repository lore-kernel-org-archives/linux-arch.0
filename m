Return-Path: <minyard@acm.org>
Received: from sccrmhc12.comcast.net ([204.127.202.56]:30685 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266237AbUG0Dkz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 26 Jul 2004 23:40:55 -0400
Message-ID: <4105CEC5.2030308@acm.org>
Date: Mon, 26 Jul 2004 22:40:53 -0500
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
Subject: Re: signal-race-fix.patch
References: <20040319120151.380dcbc9.akpm@osdl.org>	<20040319141258.338c91b1.davem@redhat.com>	<405B773B.8010705@acm.org>	<20040319154928.3b2d8820.davem@redhat.com>	<405B8BE5.4070602@acm.org>	<20040323022020.3972af1d.akpm@osdl.org>	<410574E6.2040309@acm.org> <20040726142224.79018464.akpm@osdl.org>
In-Reply-To: <20040726142224.79018464.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andrew Morton wrote:

>Corey Minyard <minyard@acm.org> wrote:
>  
>
>>I haven't seen anything for this, this is not in the current Linus or mm 
>>releases.  Did I miss something?
>>    
>>
>
>Andi had some legitimate gripes over it - the patch was a bit messy and
>could have some performance impact.  So I kinda forgot about it in the hope
>that a nicer solution would come along.
>  
>
Ok.  I searched and could not find Andi's email; do you have a pointer 
to it?  I'll fix the problems.

I looked at it, though, and the only possible performance hit I could 
find was that it copies the sa_handler data structure.  That's going to 
be hard to avoid.  And there was that big nasty line with too many "->" 
and "." setting sa_handler to SIG_DFL...

Thanks,

-Corey
