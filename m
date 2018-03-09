Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53360 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932520AbeCIWki (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Mar 2018 17:40:38 -0500
Subject: Re: [PATCH] x86, powerpc : pkey-mprotect must allow pkey-0
References: <1520583161-11741-1-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <60886e4a-59d4-541a-a6af-d4504e6719ad@intel.com>
Date: Fri, 9 Mar 2018 14:40:32 -0800
MIME-Version: 1.0
In-Reply-To: <1520583161-11741-1-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com, Ulrich.Weigand@de.ibm.com
Message-ID: <20180309224032.aYMFG_bE8VUoxoAeqt7tGQRYB2EuETwP6cJKxW2uwGs@z>

On 03/09/2018 12:12 AM, Ram Pai wrote:
> Once an address range is associated with an allocated pkey, it cannot be
> reverted back to key-0. There is no valid reason for the above behavior.  On
> the contrary applications need the ability to do so.

Why don't we just set pkey 0 to be allocated in the allocation bitmap by
default?

We *could* also just not let it be special and let it be freed.  An app
could theoretically be careful and make sure nothing is using it.
