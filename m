Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753161AbdGJDHi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jul 2017 23:07:38 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6A33Z50062590
        for <linux-arch@vger.kernel.org>; Sun, 9 Jul 2017 23:07:22 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2bjuhhkp05-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sun, 09 Jul 2017 23:07:22 -0400
Received: from localhost
        by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <khandual@linux.vnet.ibm.com>;
        Mon, 10 Jul 2017 13:07:18 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC v5 38/38] Documentation: PowerPC specific updates to memory
 protection keys
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-39-git-send-email-linuxram@us.ibm.com>
Date: Mon, 10 Jul 2017 08:37:04 +0530
MIME-Version: 1.0
In-Reply-To: <1499289735-14220-39-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-ID: <d94ab2c1-8be5-f618-6f42-cac2813059a5@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Message-ID: <20170710030704.cysUJ_Hp7mD6VuOS_4T7P6WZKmK5nK_wc4Xk6g6vWJk@z>

On 07/06/2017 02:52 AM, Ram Pai wrote:
> Add documentation updates that capture PowerPC specific changes.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  Documentation/vm/protection-keys.txt |   85 ++++++++++++++++++++++++++--------
>  1 files changed, 65 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/vm/protection-keys.txt b/Documentation/vm/protection-keys.txt
> index b643045..d50b6ab 100644
> --- a/Documentation/vm/protection-keys.txt
> +++ b/Documentation/vm/protection-keys.txt
> @@ -1,21 +1,46 @@
> -Memory Protection Keys for Userspace (PKU aka PKEYs) is a CPU feature
> -which will be found on future Intel CPUs.
> +Memory Protection Keys for Userspace (PKU aka PKEYs) is a CPU feature found in
> +new generation of intel CPUs and on PowerPC 7 and higher CPUs.
>  
>  Memory Protection Keys provides a mechanism for enforcing page-based
> -protections, but without requiring modification of the page tables
> -when an application changes protection domains.  It works by
> -dedicating 4 previously ignored bits in each page table entry to a
> -"protection key", giving 16 possible keys.
> -
> -There is also a new user-accessible register (PKRU) with two separate
> -bits (Access Disable and Write Disable) for each key.  Being a CPU
> -register, PKRU is inherently thread-local, potentially giving each
> -thread a different set of protections from every other thread.
> -
> -There are two new instructions (RDPKRU/WRPKRU) for reading and writing
> -to the new register.  The feature is only available in 64-bit mode,
> -even though there is theoretically space in the PAE PTEs.  These
> -permissions are enforced on data access only and have no effect on
> +protections, but without requiring modification of the page tables when an
> +application changes protection domains.
> +
> +
> +On Intel:
> +
> +	It works by dedicating 4 previously ignored bits in each page table
> +	entry to a "protection key", giving 16 possible keys.
> +
> +	There is also a new user-accessible register (PKRU) with two separate
> +	bits (Access Disable and Write Disable) for each key.  Being a CPU
> +	register, PKRU is inherently thread-local, potentially giving each
> +	thread a different set of protections from every other thread.
> +
> +	There are two new instructions (RDPKRU/WRPKRU) for reading and writing
> +	to the new register.  The feature is only available in 64-bit mode,
> +	even though there is theoretically space in the PAE PTEs.  These
> +	permissions are enforced on data access only and have no effect on
> +	instruction fetches.
> +
> +
> +On PowerPC:
> +
> +	It works by dedicating 5 page table entry bits to a "protection key",
> +	giving 32 possible keys.
> +
> +	There  is  a  user-accessible  register (AMR)  with  two separate bits;
> +	Access Disable and  Write  Disable, for  each key.  Being  a  CPU
> +	register,  AMR  is inherently  thread-local,  potentially  giving  each
> +	thread a different set of protections from every other thread.  NOTE:
> +	Disabling read permission does not disable write and vice-versa.

We can only enable/disable entire access or write. Then how
read permission can be changed with protection keys directly ?
