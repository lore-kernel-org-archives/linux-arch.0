Return-Path: <manfred@colorfullife.com>
Received: from dbl.q-ag.de ([213.172.117.3]:64224 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262273AbUEOMOD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 15 May 2004 08:14:03 -0400
Message-ID: <40A60984.1070202@colorfullife.com>
Date: Sat, 15 May 2004 14:13:56 +0200
From: Manfred Spraul <manfred@colorfullife.com>
MIME-Version: 1.0
Subject: [PATCH] Allow arch override for kmem_bufctl_t
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@digeo.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi Andrew,

The slab allocator keeps track of the free objects in a slab with a 
linked list of integers (typedef'ed to kmem_bufctl_t). Right now 
unsigned int is used for kmem_bufctl_t, i.e. 4 bytes per-object overhead.
The attached patch allows an arch override for this type: Theoretically, 
unsigned short is sufficient for kmem_bufctl_t and this would reduce the 
per-object overhead to 2 bytes. But some archs cannot operate on 16-bit 
values efficiently, thus it's not possible to switch everyone to ushort. 
The patch switches i386, the port maintainers should switch their arch 
if there are no problems with 16-bit quantities. All accesses to 
kmem_bufctl_t are under a per-cache spinlock and not in the hottest path.

Could you apply it to -mm?

--
    Manfred
