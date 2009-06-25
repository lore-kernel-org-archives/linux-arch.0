From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCHSET] percpu: generalize first chunk allocators and improve
 lpage NUMA support
Date: Wed, 24 Jun 2009 17:13:37 -0700
Message-ID: <4A42C131.6040007@zytor.com>
References: <1245850216-31653-1-git-send-email-tj@kernel.org> <20090624165508.30b88343.akpm@linux-foundation.org> <20090625000202.GR6760@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:57738 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbZFYAOu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2009 20:14:50 -0400
In-Reply-To: <20090625000202.GR6760@one.firstfloor.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de, cl@linux-foundation.org

Andi Kleen wrote:
> 
> Haven't read the new patches, but per cpu data always was sized
> for all possible CPUs.
> 
>> and N is large, what did it cost?
> 
>> And what are reasonable values of N?
> 
> N should normally not be large anymore, since num_possible_cpus() 
> is sized based on firmware information now.
> 

*Ahem* virtual machines *ahem*...

I have discussed this with Tejun, and the plan is to allocate the percpu
information when a processor is first brought online (but not removed
when it is offlined again.)  It's a real problem for 32-bit VMs, so it's
more important than you'd think.

	-hpa
