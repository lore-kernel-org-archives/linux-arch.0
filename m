Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:33190 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932653AbeCOPzg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Mar 2018 11:55:36 -0400
Subject: Re: [PATCH v3] x86: treat pkey-0 special
References: <1521061214-22385-1-git-send-email-linuxram@us.ibm.com>
 <alpine.DEB.2.21.1803151039430.1525@nanos.tec.linutronix.de>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <f5ef79ef-122a-e0a3-9b8e-d49c33f4a417@intel.com>
Date: Thu, 15 Mar 2018 08:55:31 -0700
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803151039430.1525@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ram Pai <linuxram@us.ibm.com>
Cc: mingo@redhat.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com, Ulrich.Weigand@de.ibm.com
Message-ID: <20180315155531.jmH_wk9c3YTc-cgEgaMybkl5luyxbJKYAX4uT5C3YW4@z>

On 03/15/2018 02:46 AM, Thomas Gleixner wrote:
>> +	if (!pkey || !mm_pkey_is_allocated(mm, pkey))
> Why this extra check? mm_pkey_is_allocated(mm, 0) should not return true
> ever. If it does, then this wants to be fixed.

I was thinking that we _do_ actually want it to seem allocated.  It just
get "allocated" implicitly when an mm is created.  I think that will
simplify the code if we avoid treating it specially in as many places as
possible.
