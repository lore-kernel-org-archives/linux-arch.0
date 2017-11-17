From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH for 4.15 23/24] membarrier: selftest: Test private
 expedited sync core cmd
Date: Fri, 17 Nov 2017 16:17:56 +0000 (UTC)
Message-ID: <182547799.17141.1510935476057.JavaMail.zimbra@efficios.com>
References: <20171114200414.2188-1-mathieu.desnoyers@efficios.com> <20171114200414.2188-24-mathieu.desnoyers@efficios.com> <b529c741-dec1-0d02-ad4f-1059203b7b7c@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.142.141]:39169 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbdKQQRF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Nov 2017 11:17:05 -0500
In-Reply-To: <b529c741-dec1-0d02-ad4f-1059203b7b7c@osg.samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Boqun Feng <boqun.feng@gmail.com>, Andy Lutomirski <luto@amacapital.net>, Dave Watson <davejwatson@fb.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, Paul Turner <pjt@google.com>, Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>, Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>, Josh Triplett <josh@joshtriplett.org>, Linus Torvalds <torvalds@linux-foundation.org>, Catalin Marinas <cata>

----- On Nov 17, 2017, at 10:09 AM, Shuah Khan shuahkh@osg.samsung.com wrote:
> 
> Looks good to me. I am assuming this patch goes in with the rest of the
> series. For this patch:
> 
> Acked-by: Shuah Khan <shuahkh@osg.samsung.com>

Thanks for the Acked-by. I'll add it to the patch changelog.
The sync_core membarrier patches are now queued for 4.16 however.

Thanks,

Mathieu

> 
> thanks,
> -- Shuah

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
