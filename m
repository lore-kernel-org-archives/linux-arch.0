Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:32887 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932375AbeEHOjS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 May 2018 10:39:18 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v13 0/3] mm, x86, powerpc: Enhancements to Memory Protection Keys.
In-Reply-To: <1525471183-21277-1-git-send-email-linuxram@us.ibm.com>
References: <1525471183-21277-1-git-send-email-linuxram@us.ibm.com>
Date: Wed, 09 May 2018 00:39:14 +1000
Message-ID: <8736z21ab1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, mingo@redhat.com, akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net, arnd@arndb.de
Message-ID: <20180508143914.OqPCrrbyM-WEQwUtyheD1-fD3SvWawktsToogmeEZqk@z>

Ram Pai <linuxram@us.ibm.com> writes:

> This patch series provides arch-neutral enhancements to
> enable memory-keys on new architecutes, and the corresponding
> changes in x86 and powerpc specific code to support that.
>
> a) Provides ability to support upto 32 keys.  PowerPC
>         can handle 32 keys and hence needs this.
>
> b) Arch-neutral code; and not the arch-specific code,
>    determines the format of the string, that displays the key
>    for each vma in smaps.
>
> History:
> -------
> version 14:

This doesn't match the patch subjects, which is a little confusing :)

> 	(1) made VM_PKEY_BIT4 unusable on x86, #defined it to 0
> 		-- comment by Dave Hansen
> 	(2) due to some reason this patch series continue to
> 	      break some or the other build. The last series
> 	      passed everything but created a merge
> 	      conflict followed by build failure for
> 	      Michael Ellermen. :(

I have a fix, it involved some cleanup of headers prior to the smaps
change.

Will post it.

cheers
