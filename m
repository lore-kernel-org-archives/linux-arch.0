From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHSET] percpu: generalize first chunk allocators and improve
 lpage NUMA support
Date: Fri, 26 Jun 2009 09:40:10 +0900
Message-ID: <4A4418EA.9000705@kernel.org>
References: <1245850216-31653-1-git-send-email-tj@kernel.org> <20090624165508.30b88343.akpm@linux-foundation.org> <20090625000202.GR6760@one.firstfloor.org> <4A42C131.6040007@zytor.com> <20090625091939.GS6760@one.firstfloor.org> <4A43871F.9030507@zytor.com> <20090625195408.GW6760@one.firstfloor.org> <4A43DAFD.90409@zytor.com> <20090625202642.GX6760@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54414 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbZFZAkd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 25 Jun 2009 20:40:33 -0400
In-Reply-To: <20090625202642.GX6760@one.firstfloor.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de, cl@linux-foundation.org

Andi Kleen wrote:
>> I don't know why, but in the configuration I saw each percpu area was
>> something like 1.8 MB.
> 
> That sounds like something that needs to be investigated and fixed then.
> In a sense per cpu space is precious like stack space and shouldn't 
> be wasted.

The large percpu space is most likely from lockdep.

Thanks.

-- 
tejun
