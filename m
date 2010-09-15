Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fxip-0047f.externet.hu ([88.209.222.127]:53698 "EHLO
	pomaz-ex.szeredi.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551Ab0IOPDP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Sep 2010 11:03:15 -0400
Subject: memory barrier question
Message-ID: <E1Ovt6F-0005CS-RU@pomaz-ex.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 15 Sep 2010 16:36:39 +0200
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20100915143639.fT1EwrgLXoFjvlxX2V1nqkUMtLMj8ulNZzamkX5c_H4@z>

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
