Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751394AbeCNRPF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Mar 2018 13:15:05 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2EHEXKd059855
        for <linux-arch@vger.kernel.org>; Wed, 14 Mar 2018 13:15:05 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gq5bd01pj-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 14 Mar 2018 13:15:04 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <linuxram@us.ibm.com>;
        Wed, 14 Mar 2018 17:15:02 -0000
Date: Wed, 14 Mar 2018 10:14:48 -0700
From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH 1/1 v2] x86: pkey-mprotect must allow pkey-0
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1521013574-27041-1-git-send-email-linuxram@us.ibm.com>
 <18b155e3-07e9-5a4b-1f95-e1667078438c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18b155e3-07e9-5a4b-1f95-e1667078438c@intel.com>
Message-ID: <20180314171448.GA1060@ram.oc3035372033.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: mingo@redhat.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com
Message-ID: <20180314171448.1-tP6X2VjP6scSdvMxqJ2ytkiKnSsWUkk6xDOUxooL4@z>

On Wed, Mar 14, 2018 at 07:19:23AM -0700, Dave Hansen wrote:
> On 03/14/2018 12:46 AM, Ram Pai wrote:
> > Once an address range is associated with an allocated pkey, it cannot be
> > reverted back to key-0. There is no valid reason for the above behavior.  On
> > the contrary applications need the ability to do so.
> 
> I'm trying to remember why we cared in the first place. :)
> 
> Could you add that to the changelog, please?
> 
> > @@ -92,7 +92,8 @@ int mm_pkey_alloc(struct mm_struct *mm)
> >  static inline
> >  int mm_pkey_free(struct mm_struct *mm, int pkey)
> >  {
> > -	if (!mm_pkey_is_allocated(mm, pkey))
> > +	/* pkey 0 is special and can never be freed */
> > +	if (!pkey || !mm_pkey_is_allocated(mm, pkey))
> >  		return -EINVAL;
> 
> If an app was being really careful, couldn't it free up all of the
> implicitly-pkey-0-assigned memory so that it is not in use at all?  In
> that case, we might want to allow this.
> 
> On the other hand, nobody is likely to _ever_ actually do this so this
> is good shoot-yourself-in-the-foot protection.

I look at key-0 as 'the key'. It has special status. 
(a) It always exist.
(b) it cannot be freed.
(c) it is assigned by default.
(d) its permissions cannot be modified.
(e) it bypasses key-permission checks when assigned.

An arch need not necessarily map 'the key-0' to its key-0.  It could
internally map it to any of its internal key of its choice, transparent
to the application.

Do you see a problem to this view point?

RP
