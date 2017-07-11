From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC v5 00/38] powerpc: Memory Protection Keys
Date: Tue, 11 Jul 2017 16:52:46 +0200
Message-ID: <20170711145246.GA11917@dhcp22.suse.cz>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42777 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932779AbdGKOwv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Jul 2017 10:52:51 -0400
Content-Disposition: inline
In-Reply-To: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com

On Wed 05-07-17 14:21:37, Ram Pai wrote:
> Memory protection keys enable applications to protect its
> address space from inadvertent access or corruption from
> itself.
> 
> The overall idea:
> 
>  A process allocates a   key  and associates it with
>  an  address  range  within    its   address   space.
>  The process  then  can  dynamically  set read/write 
>  permissions on  the   key   without  involving  the 
>  kernel. Any  code that  violates   the  permissions
>  of  the address space; as defined by its associated
>  key, will receive a segmentation fault.
> 
> This patch series enables the feature on PPC64 HPTE
> platform.
> 
> ISA3.0 section 5.7.13 describes the detailed specifications.

Could you describe the highlevel design of this feature in the cover
letter. I have tried to get some idea from the patchset but it was
really far from trivial. Patches are not very well split up (many
helpers are added without their users etc..). 

> 
> Testing:
> 	This patch series has passed all the protection key
> 	tests available in  the selftests directory.
> 	The tests are updated to work on both x86 and powerpc.
> 
> version v5:
> 	(1) reverted back to the old design -- store the 
> 	    key in the pte, instead of bypassing it.
> 	    The v4 design slowed down the hash page path.

This surprised me a lot but I couldn't find the respective code. Why do
you need to store anything in the pte? My understanding of PKEYs is that
the setup and teardown should be very cheap and so no page tables have
to updated. Or do I just misunderstand what you wrote here?
-- 
Michal Hocko
SUSE Labs
