From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC 0/2] Reenable might_sleep() checks for might_fault() when
 atomic
Date: Wed, 26 Nov 2014 16:30:32 +0100
Message-ID: <5475F218.4050207@de.ibm.com>
References: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com> <20141126070258.GA25523@redhat.com> <20141126110504.511b733a@thinkpad-w530> <20141126151729.GB9612@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108]:55060 "EHLO
	e06smtp12.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886AbaKZPai (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Nov 2014 10:30:38 -0500
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Wed, 26 Nov 2014 15:30:37 -0000
In-Reply-To: <20141126151729.GB9612@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, mingo@kernel.org

Am 26.11.2014 um 16:17 schrieb Michael S. Tsirkin:
> On Wed, Nov 26, 2014 at 11:05:04AM +0100, David Hildenbrand wrote:
>>> What's the path you are trying to debug?
>>
>> Well, we had a problem where we held a spin_lock and called
>> copy_(from|to)_user(). We experienced very random deadlocks that took some guy
>> almost a week to debug. The simple might_sleep() check would have showed this
>> error immediately.
> 

> This must have been a very old kernel.
> A modern kernel will return an error from copy_to_user.

I disagree. copy_to_user will not return while holding a spinlock, because it does not know! How should it?
See: spin_lock will call preempt_disable, but thats a no-op for a non-preempt kernel. So the mere fact that we hold a spin_lock is not known by any user access function. (or others). No?

Christian
