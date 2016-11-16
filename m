Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752417AbcKPMef (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Nov 2016 07:34:35 -0500
Subject: Re: [PATCH 1/1] sched: provide common cpu_relax_yield definition
References: <1479298985-191589-1-git-send-email-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c41d574c-c89e-e518-91bb-3acd701e5023@redhat.com>
Date: Wed, 16 Nov 2016 13:34:22 +0100
MIME-Version: 1.0
In-Reply-To: <1479298985-191589-1-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Noam Camus <noamc@ezchip.com>, linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, sparclinux@vger.kernel.org, virtualization@lists.linux-foundation.org
Message-ID: <20161116123422.Dm7WffXGuZ9rz4g_-f3BEjN85qwZQwKH726Q6b-APpw@z>

Am 16.11.2016 um 13:23 schrieb Christian Borntraeger:
> No need to duplicate the same define everywhere. Since
> the only user is stop-machine and the only provider is
> s390, we can use a default implementation of cpu_relax_yield
> in sched.h.
>
> Suggested-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Looks good to me!

Reviewed-by: David Hildenbrand <david@redhat.com>

David
