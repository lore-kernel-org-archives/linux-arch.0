Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:65218 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932401AbdGKRdL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Jul 2017 13:33:11 -0400
Subject: Re: [RFC v5 36/38] selftest: PowerPC specific test updates to memory
 protection keys
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-37-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <c0e2eab4-a724-5155-4ae9-03b37e4b9f54@intel.com>
Date: Tue, 11 Jul 2017 10:33:09 -0700
MIME-Version: 1.0
In-Reply-To: <1499289735-14220-37-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Message-ID: <20170711173309.pqkPM83XWgxZ_sZAKAleubvtcZLsB4H14abwweyKMVM@z>

On 07/05/2017 02:22 PM, Ram Pai wrote:
> Abstracted out the arch specific code into the header file, and
> added powerpc specific changes.
> 
> a) added 4k-backed hpte, memory allocator, powerpc specific.
> b) added three test case where the key is associated after the page is
> 	accessed/allocated/mapped.
> c) cleaned up the code to make checkpatch.pl happy

There's a *lot* of churn here.  If it breaks, I'm going to have a heck
of a time figuring out which hunk broke.  Is there any way to break this
up into a series of things that we have a chance at bisecting?
