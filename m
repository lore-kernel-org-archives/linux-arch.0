Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35261 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757002AbZF0DXV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 26 Jun 2009 23:23:21 -0400
Message-ID: <4A459075.4010709@kernel.org>
Date: Sat, 27 Jun 2009 12:22:29 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHSET core/percpu] percpu: convert most archs to dynamic
 percpu, take#4
References: <1245825924-30412-1-git-send-email-tj@kernel.org>
In-Reply-To: <1245825924-30412-1-git-send-email-tj@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, kyle@mcmartin.ca, cl@linux-foundation.org, Jesper.Nilsson@axis.com, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, torvalds@linux-foundation.org, akpm@linux-foundation.org
Message-ID: <20090627032229.zBk-dR0lV_Mg57X-CmHyvhlfgg42q_4pZdeOKZwBQxU@z>

Tejun Heo wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/percpu.git convert-most-archs

Rebased tree w/ the build breakage James spotted fixed pulled into
#for-next.  It won't be rebased from now on unless something drastic
happens.

Thanks.

-- 
tejun
