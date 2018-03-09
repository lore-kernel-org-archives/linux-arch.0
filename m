Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932221AbeCIUAj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Mar 2018 15:00:39 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w29Jsmkk088353
        for <linux-arch@vger.kernel.org>; Fri, 9 Mar 2018 15:00:39 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gkyv72ass-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 09 Mar 2018 15:00:38 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <linuxram@us.ibm.com>;
        Fri, 9 Mar 2018 20:00:35 -0000
Date: Fri, 9 Mar 2018 12:00:17 -0800
From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH] x86, powerpc : pkey-mprotect must allow pkey-0
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1520583161-11741-1-git-send-email-linuxram@us.ibm.com>
 <ec90ed75-2810-bcc3-8439-8dc85a6b46ac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec90ed75-2810-bcc3-8439-8dc85a6b46ac@redhat.com>
Message-ID: <20180309200017.GR1060@ram.oc3035372033.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net, arnd@arndb.de, msuchanek@suse.com, Ulrich.Weigand@de.ibm.com
Message-ID: <20180309200017.pJ6EaT5abwKK4SeZflw2JdJFwtrmPVhvAcRk-xaWgFI@z>

On Fri, Mar 09, 2018 at 12:04:49PM +0100, Florian Weimer wrote:
> On 03/09/2018 09:12 AM, Ram Pai wrote:
> >Once an address range is associated with an allocated pkey, it cannot be
> >reverted back to key-0. There is no valid reason for the above behavior.
> 
> mprotect without a key does not necessarily use key 0, e.g. if
> protection keys are used to emulate page protection flag combination
> which is not directly supported by the hardware.
> 
> Therefore, it seems to me that filtering out non-allocated keys is
> the right thing to do.

I am not sure, what you mean. Do you agree with the patch or otherwise?
RP
