From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 3/7] Add assertion checking macros
Date: Fri, 16 Dec 2011 13:36:53 -0800
Message-ID: <m21us4qjuy.fsf@firstfloor.org>
References: <20111216141357.24668.49793.stgit@warthog.procyon.org.uk>
	<20111216141417.24668.15693.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:7139 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760837Ab1LPVia (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 16 Dec 2011 16:38:30 -0500
In-Reply-To: <20111216141417.24668.15693.stgit@warthog.procyon.org.uk> (David
	Howells's message of "Fri, 16 Dec 2011 14:14:17 +0000")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, mingo@elte.hu, linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:
>
>      There is no need to display val here in the case the expression fails
>      since it can only be 0.  If this fails, it produces an error like the
>      following:
>
> 	------------[ cut here ]------------
> 	kernel BUG at fs/fscache/main.c:109!
> 	ASSERTION FAILED

It would be nice to display the expression here like an user space
assert. While it can be looked up in the source it would
make quick eyeballing easier. 

Probably wouldn't cost too much additional text size?

>
>  (e) ASSERTIFCMP(C, X, OP, Y)
>
>      This is a combination of ASSERTIF and ASSERTCMP.  For example:
>
> 	ASSERTIFCMP(test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags),
> 		    object->n_exclusive, >, 0);

You probably want a checkpatch rule with those to only allow a few
selected functions like test_bit. Otherwise people will put real side
effects in there.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
