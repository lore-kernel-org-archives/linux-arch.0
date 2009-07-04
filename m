From: Tejun Heo <tj@kernel.org>
Subject: Re: linux-next submission requirements (Was: [RFC PATCH] linker script:
 unify usage of discard definition)
Date: Sat, 04 Jul 2009 12:18:02 +0900
Message-ID: <4A4EC9EA.9070005@kernel.org>
References: <4A4E9638.20304@kernel.org> <20090704113448.49a722d2.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48233 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824AbZGDDQH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 3 Jul 2009 23:16:07 -0400
In-Reply-To: <20090704113448.49a722d2.sfr@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org

Hello,

Stephen Rothwell wrote:
> Hi Tejun,
> 
> [This is not aimed just at you ... this patch just gave me an
> opportunity to point this out again.]
> 
> On Sat, 04 Jul 2009 08:37:28 +0900 Tejun Heo <tj@kernel.org> wrote:
>> This patch is on top of the current percpu#for-next.
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/percpu.git for-next
>>
>> Thanks.
>>
>> NOT_SIGNED_OFF_YET
> 
> Well, given no SOB and that this is a RFC patch, it should *not* be in a
> branch that is pulled into linux-next.

It's not _in_ the branch.  It's on _top_ of the branch.

Thanks.

-- 
tejun
