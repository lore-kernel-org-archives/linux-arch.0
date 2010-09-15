From: Miklos Szeredi <miklos@szeredi.hu>
Subject: memory barrier question
Date: Wed, 15 Sep 2010 16:36:39 +0200
Message-ID: <E1Ovt6F-0005CS-RU@pomaz-ex.szeredi.hu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi,

I'm trying to understand memory barriers but not quite succeeding.

Consider the following example:

Start:
	p = NULL;
	x = 0;

CPU1:
	atomic_inc(&x);
	p = &x;

CPU2:
	if (p)
		z = atomic_read(p);

Is it possible to end up with z == 0?  What if there's a lock/unlock
before setting "p"?  What if there's a write barrier before setting
"p"?

Thanks,
Miklos
