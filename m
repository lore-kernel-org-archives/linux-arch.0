Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:53995 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeCOQN2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Mar 2018 12:13:28 -0400
Date: Thu, 15 Mar 2018 17:13:16 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] x86: treat pkey-0 special
In-Reply-To: <f5ef79ef-122a-e0a3-9b8e-d49c33f4a417@intel.com>
Message-ID: <alpine.DEB.2.21.1803151713050.1525@nanos.tec.linutronix.de>
References: <1521061214-22385-1-git-send-email-linuxram@us.ibm.com> <alpine.DEB.2.21.1803151039430.1525@nanos.tec.linutronix.de> <f5ef79ef-122a-e0a3-9b8e-d49c33f4a417@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Ram Pai <linuxram@us.ibm.com>, mingo@redhat.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com, Ulrich.Weigand@de.ibm.com
Message-ID: <20180315161316.irO7HmR4mn3iQJXekipsy1ImP8o8HM3Qzzc7-FuzJ0Q@z>

On Thu, 15 Mar 2018, Dave Hansen wrote:

> On 03/15/2018 02:46 AM, Thomas Gleixner wrote:
> >> +	if (!pkey || !mm_pkey_is_allocated(mm, pkey))
> > Why this extra check? mm_pkey_is_allocated(mm, 0) should not return true
> > ever. If it does, then this wants to be fixed.
> 
> I was thinking that we _do_ actually want it to seem allocated.  It just
> get "allocated" implicitly when an mm is created.  I think that will
> simplify the code if we avoid treating it specially in as many places as
> possible.

That works as well.
