Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730052AbeGQTov (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Jul 2018 15:44:51 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6HIx5oa130094
        for <linux-arch@vger.kernel.org>; Tue, 17 Jul 2018 15:10:50 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k9kcmfagt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 17 Jul 2018 15:10:49 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <linuxram@us.ibm.com>;
        Tue, 17 Jul 2018 20:10:47 +0100
Date: Tue, 17 Jul 2018 12:10:36 -0700
From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v13 19/24] selftests/vm: associate key on a mapped page
 and detect access violation
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-20-git-send-email-linuxram@us.ibm.com>
 <048b1de9-85f8-22ff-a31a-b06a382769bb@intel.com>
 <20180717161332.GH5790@ram.oc3035372033.ibm.com>
 <febe6668-c66a-4601-63da-44501faf12ee@intel.com>
MIME-Version: 1.0
In-Reply-To: <febe6668-c66a-4601-63da-44501faf12ee@intel.com>
Message-ID: <20180717191036.GI5790@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180717191036.YONoAYZwFRgjlNeNnSc3kmndzHp4VYloNcC9AnibgC8@z>

On Tue, Jul 17, 2018 at 10:56:08AM -0700, Dave Hansen wrote:
> On 07/17/2018 09:13 AM, Ram Pai wrote:
> > I have incorporated almost all of your comments. But there are some
> > comments that take some effort to implement. Shall we get the patches
> > merged in the current form?  This code has been sitting out for a while.
> > 
> > In the current form its tested and works on powerpc and on x86, and
> > incorporates about 95% of your suggestions. The rest I will take care
> > as we go.
> 
> What constitutes the remaining 5%?

Mostly your comments on code-organization in the signal handler. There
are still some #if defined(__i386__)  ..... Can be cleaned up and
abstracted further.

Also your questions on some of the code changes, the rationale for which
is not obvious. Will help to spinkle in some descriptive comments there.

Have fixed up a lot of codying style issues. But there could till be a
few that may spew warning by checkpatch.pl.

There are no functional issues AFAICT.

RP
