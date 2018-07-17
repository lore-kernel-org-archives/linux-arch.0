Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729713AbeGQQjF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Jul 2018 12:39:05 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6HG5Ttw061868
        for <linux-arch@vger.kernel.org>; Tue, 17 Jul 2018 12:05:44 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k9jsujma1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 17 Jul 2018 12:05:43 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <linuxram@us.ibm.com>;
        Tue, 17 Jul 2018 17:05:28 +0100
Date: Tue, 17 Jul 2018 09:05:16 -0700
From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v13 17/24] selftests/vm: powerpc implementation to check
 support for pkey
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-18-git-send-email-linuxram@us.ibm.com>
 <20bc9696-3ae9-4eb9-40ce-9c477a8aaea2@intel.com>
MIME-Version: 1.0
In-Reply-To: <20bc9696-3ae9-4eb9-40ce-9c477a8aaea2@intel.com>
Message-ID: <20180717160516.GE5790@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180717160516.a31OAMPjSR1dDJYMut0frkyR7g0ai__UaXs_FJeUx0A@z>

On Wed, Jun 20, 2018 at 08:09:12AM -0700, Dave Hansen wrote:
> > -	if (cpu_has_pku()) {
> > -		dprintf1("SKIP: %s: no CPU support\n", __func__);
> > +	if (is_pkey_supported()) {
> > +		dprintf1("SKIP: %s: no CPU/kernel support\n", __func__);
> >  		return;
> >  	}
> 
> I actually kinda wanted a specific message for when the *CPU* doesn't
> support the feature.

is_pkey_supported() x86 implementation has specific messages. it will
print if the CPU doesn't support the feature.

RP

-- 
Ram Pai
