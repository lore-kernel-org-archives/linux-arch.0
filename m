From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHSET core/percpu] percpu: convert most archs to dynamic
 percpu, take#4
Date: Sat, 27 Jun 2009 12:25:54 +0900
Message-ID: <4A459142.60301@kernel.org>
References: <1245825924-30412-1-git-send-email-tj@kernel.org> <4A459075.4010709@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35316 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753903AbZF0D0m (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 26 Jun 2009 23:26:42 -0400
In-Reply-To: <4A459075.4010709@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, kyle@mcmartin.ca, cl@linux-foundation.org, Jesper.Nilsson@axis.com, benh@kernel.crashing.org

Tejun Heo wrote:
> Tejun Heo wrote:
>>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/percpu.git convert-most-archs
> 
> Rebased tree w/ the build breakage James spotted fixed pulled into
> #for-next.  It won't be rebased from now on unless something drastic
> happens.

Eh... after hitting send I realized alpha was still broken.  It'll go
through another revision.

Thanks.

-- 
tejun
