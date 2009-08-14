From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHSET percpu#for-next] implement and use sparse embedding
 first chunk allocator
Date: Fri, 14 Aug 2009 15:09:34 +0900
Message-ID: <4A84FF9E.3050306@kernel.org>
References: <1248171979-29166-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58180 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbZHNGKm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 14 Aug 2009 02:10:42 -0400
In-Reply-To: <1248171979-29166-1-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, benh@kernel.crashing.org, davem@davemloft.net, dhowells@redhat.com, npiggin@suse.de, JBeulich@novell.comc

Tejun Heo wrote:
> Hello, all.
> 
> This patchset teaches percpu allocator how to manage very sparse
> units, vmalloc how to allocate congruent sparse vmap areas and combine
> them to extend the embedding allocator to allow embedding of sparse
> unit addresses.  This basically implements Christoph's sparse
> congruent allocator.

Exported to linux-next.

Thanks.

-- 
tejun
