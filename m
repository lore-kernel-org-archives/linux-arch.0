From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [RFC v5 36/38] selftest: PowerPC specific test updates to memory
 protection keys
Date: Wed, 12 Jul 2017 14:57:29 -0700
Message-ID: <20170712215729.GC5525@ram.oc3035372033.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-37-git-send-email-linuxram@us.ibm.com>
 <c0e2eab4-a724-5155-4ae9-03b37e4b9f54@intel.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752021AbdGLV5q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Jul 2017 17:57:46 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6CLrXJB045855
        for <linux-arch@vger.kernel.org>; Wed, 12 Jul 2017 17:57:45 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3nm6dv-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 12 Jul 2017 17:57:45 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <linuxram@us.ibm.com>;
        Wed, 12 Jul 2017 17:57:44 -0400
Content-Disposition: inline
In-Reply-To: <c0e2eab4-a724-5155-4ae9-03b37e4b9f54@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com

On Tue, Jul 11, 2017 at 10:33:09AM -0700, Dave Hansen wrote:
> On 07/05/2017 02:22 PM, Ram Pai wrote:
> > Abstracted out the arch specific code into the header file, and
> > added powerpc specific changes.
> > 
> > a) added 4k-backed hpte, memory allocator, powerpc specific.
> > b) added three test case where the key is associated after the page is
> > 	accessed/allocated/mapped.
> > c) cleaned up the code to make checkpatch.pl happy
> 
> There's a *lot* of churn here.  If it breaks, I'm going to have a heck
> of a time figuring out which hunk broke.  Is there any way to break this
> up into a series of things that we have a chance at bisecting?

Just finished breaking down the changes into 20 gradual increments.
I have pushed it to my github tree at

https://github.com/rampai/memorykeys.git
branch is memkey.v6-rc3

See if it works for you. I am sure I would have broken something on
x86 since I dont have a x86 platform to test.

Let me know, Thanks,
RP
