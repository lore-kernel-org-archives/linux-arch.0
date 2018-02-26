From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v12 3/3] mm, x86, powerpc: display pkey in smaps only if
 arch supports pkeys
Date: Mon, 26 Feb 2018 13:16:16 -0800
Message-ID: <2a7737cf-a5ba-c814-fdc7-45b5cdd47376@intel.com>
References: <1519257138-23797-1-git-send-email-linuxram@us.ibm.com>
 <1519257138-23797-4-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519257138-23797-4-git-send-email-linuxram@us.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com
List-Id: linux-arch.vger.kernel.org

On 02/21/2018 03:52 PM, Ram Pai wrote:
> Currently the  architecture  specific code is expected to
> display  the  protection  keys  in  smap  for a given vma.
> This can lead to redundant code and possibly to divergent
> formats in which the key gets displayed.
> 
> This  patch  changes  the implementation. It displays the
> pkey only if the architecture support pkeys, i.e
> arch_pkeys_enabled() returns true.  This patch
> provides x86 implementation for arch_pkeys_enabled().
> 
> x86 arch_show_smap() function is not needed anymore.
> Deleting it.

This looks fine to me.  Thanks for doing these, Ram.

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
