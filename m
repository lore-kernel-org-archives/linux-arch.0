Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:39342 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728AbbL3Uqs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Dec 2015 15:46:48 -0500
Date: Wed, 30 Dec 2015 15:46:46 -0500 (EST)
Message-ID: <20151230.154646.596597479469584255.davem@davemloft.net>
Subject: Re: [PATCH 00/34] arch: barrier cleanup + __smp_xxx barriers for
 virt
From: David Miller <davem@davemloft.net>
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, arnd@arndb.de, linux-arch@vger.kernel.org, andrew.cooper3@citrix.com, virtualization@lists.linux-foundation.org, stefano.stabellini@eu.citrix.com
Message-ID: <20151230204646.98fPxJNVKj9XnYpO71BPU_1klWKyQdyFN-Hqbn4HuSk@z>

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 30 Dec 2015 14:58:19 +0200

> -. Patch 1 documents the __smp APIs, and explains why they are
>    useful for virt

If virt is doing things like interacting with descriptors that are
shared with a (potentially SMP) host, why don't we just annotate those
specific cases?

The other memory barriers in the kernel do not matter for SMP'ness
when build UP.
