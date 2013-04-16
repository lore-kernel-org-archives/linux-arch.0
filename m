From: Waiman Long <Waiman.Long@hp.com>
Subject: Re: [PATCH 0/3 v2] mutex: Improve mutex performance by doing less
 atomic-ops & better spinning
Date: Tue, 16 Apr 2013 07:49:50 -0400
Message-ID: <516D3ADE.9060606@hp.com>
References: <1366036679-9702-1-git-send-email-Waiman.Long@hp.com> <20130416091259.GC9569@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:35737 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899Ab3DPLty (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Apr 2013 07:49:54 -0400
In-Reply-To: <20130416091259.GC9569@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, Dave Jones <davej@redhat.com>, Clark Williams <williams@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, "Chandramouleeswaran, Aswin" <aswin@hp.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, "Norton, Scott J" <scott.norton@hp.com>, Rik van Riel <riel@redhat.com>

On 04/16/2013 05:12 AM, Ingo Molnar wrote:
> * Waiman Long<Waiman.Long@hp.com>  wrote:
>
>> [...]
>>
>> Patches 2 improves the mutex spinning process by reducing contention among the
>> spinners when competing for the mutex. This is done by using a MCS lock to put
>> the spinners in a queue so that only the first spinner will try to acquire the
>> mutex when it is available. This patch showed significant performance
>> improvement of +30% on the AIM7 fserver and new_fserver workload.
> Ok, that's really nice - and this approach has no arbitrary limits/tunings in it.
>
> Do you have a performance comparison to your first series (patches 1+2+3 IIRC) -
> how does this new series with MCS locking compare to the best previous result from
> that old series? Do we now achieve that level of performance?

Compared with the old patch set, the new patches 1+2 have over 30% 
performance gain in high user load (1100-1500) in the fserver and 
new_fserver workloads. The old patches 1+2 or 1+3 only manages around 
10% gain. In the intermediate range of 200-1000, the 2 sets are more 
comparable in performance gain.

Regards,
Longman
