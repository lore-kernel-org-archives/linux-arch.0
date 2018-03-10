Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51342 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750858AbeCJF4A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 10 Mar 2018 00:56:00 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2A5sq30006421
        for <linux-arch@vger.kernel.org>; Sat, 10 Mar 2018 00:56:00 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gm31y1qqk-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sat, 10 Mar 2018 00:55:59 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <linuxram@us.ibm.com>;
        Sat, 10 Mar 2018 05:55:58 -0000
Date: Fri, 9 Mar 2018 21:55:44 -0800
From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH] x86, powerpc : pkey-mprotect must allow pkey-0
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1520583161-11741-1-git-send-email-linuxram@us.ibm.com>
 <60886e4a-59d4-541a-a6af-d4504e6719ad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60886e4a-59d4-541a-a6af-d4504e6719ad@intel.com>
Message-ID: <20180310055544.GU1060@ram.oc3035372033.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com, Ulrich.Weigand@de.ibm.com
Message-ID: <20180310055544.wzFrG6pg__1ihx0CJ8jv0MZmDdZkpB_yiPFZcSKk-Dk@z>

On Fri, Mar 09, 2018 at 02:40:32PM -0800, Dave Hansen wrote:
> On 03/09/2018 12:12 AM, Ram Pai wrote:
> > Once an address range is associated with an allocated pkey, it cannot be
> > reverted back to key-0. There is no valid reason for the above behavior.  On
> > the contrary applications need the ability to do so.
> 
> Why don't we just set pkey 0 to be allocated in the allocation bitmap by
> default?

ok. that will make it allocatable. But it will not be associatable,
given the bug in the current code. And what will be the
default key associated with a pte? zero? or something else?

> 
> We *could* also just not let it be special and let it be freed.  An app
> could theoretically be careful and make sure nothing is using it.

unable to see how this solves the problem. Need some more explaination.


RP
