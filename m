Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:36820 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756543AbdLUAa2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Dec 2017 19:30:28 -0500
Message-ID: <1513810153.2743.25.camel@kernel.crashing.org>
Subject: Re: [PATCH v9 29/51] mm/mprotect, powerpc/mm/pkeys, x86/mm/pkeys:
 Add sysfs interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 21 Dec 2017 09:49:13 +1100
In-Reply-To: <20171220175022.GB5619@ram.oc3035372033.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
         <1509958663-18737-30-git-send-email-linuxram@us.ibm.com>
         <bbc5593e-31ec-183a-01a5-1a253dc0c275@intel.com>
         <20171218221850.GD5461@ram.oc3035372033.ibm.com>
         <e7971d03-6ad1-40d5-9b79-f01242db5293@intel.com>
         <1513719296.2743.12.camel@kernel.crashing.org>
         <20171220175022.GB5619@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Dave Hansen <dave.hansen@intel.com>, mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Message-ID: <20171220224913.xMY0xWCzatUuH2eWwKylqiS2X6EoaAJDdihYvoezUog@z>

On Wed, 2017-12-20 at 09:50 -0800, Ram Pai wrote:
> The argument against this patch is --  it should not be baked into
> the ABI as yet, since we do not have clarity on what applications need.
> 
> As it stands today the only way to figure out the information from
> userspace is by probing the kernel through calls to sys_pkey_alloc().
> 
> AT_HWCAP can be used, but that will certainly not be capable of
> providing all the information that userspace might expect.
> 
> Your thoughts?

Well, there's one well known application wanting that whole keys
business, so why not ask them what works for them ?

In the meantime, that shouldn't block the rest of the patches.

Cheers,
Ben.
