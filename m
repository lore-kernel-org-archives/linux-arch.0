Return-Path: <SRS0=iRyw=4Z=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:60290 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgCHVHy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 8 Mar 2020 17:07:54 -0400
Subject: Re: [PATCH 3/3] docs: atomic_ops: Steer readers towards using
 refcount_t for reference counts
References: <20200308195618.22768-1-j.neuschaefer@gmx.net>
 <20200308200007.23314-1-j.neuschaefer@gmx.net>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7ff7dc4e-d606-e2a1-edce-a0485e948e48@infradead.org>
Date: Sun, 8 Mar 2020 14:07:46 -0700
MIME-Version: 1.0
In-Reply-To: <20200308200007.23314-1-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>, linux-doc@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20200308210746.-1hDJ3HyFhYbT-cibb25TpUZnZjuxaY9WPQ92oruX7o@z>

On 3/8/20 1:00 PM, Jonathan Neuschäfer wrote:
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/core-api/atomic_ops.rst         | 6 ++++++
>  Documentation/core-api/refcount-vs-atomic.rst | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-api/atomic_ops.rst
> index 73033fc954ad..37a0ffe1a9f1 100644
> --- a/Documentation/core-api/atomic_ops.rst
> +++ b/Documentation/core-api/atomic_ops.rst
> @@ -392,6 +392,12 @@ be guaranteed that no other entity can be accessing the object::
>  	memory barriers in kfree_skb() that exposed the atomic_t memory barrier
>  	requirements quite clearly.
> 
> +.. note::
> +
> +        More recently, reference counts are implement using the

                                               implemented

> +        :ref:`refcount_t <refcount_t_vs_atomic_t>` type, which works like
> +        atomic_t but protects against wraparound.
> +
>  Given the above scheme, it must be the case that the obj->active
>  update done by the obj list deletion be visible to other processors
>  before the atomic counter decrement is performed.


-- 
~Randy
