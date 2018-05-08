From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v13 0/3] mm, x86, powerpc: Enhancements to Memory Protection Keys.
Date: Wed, 09 May 2018 00:39:14 +1000
Message-ID: <8736z21ab1.fsf@concordia.ellerman.id.au>
References: <1525471183-21277-1-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525471183-21277-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com, corbet@lwn.net, arnd@arndb.de
List-Id: linux-arch.vger.kernel.org

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
