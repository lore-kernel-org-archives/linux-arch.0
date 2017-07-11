Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:36005 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753498AbdGKWTd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Jul 2017 18:19:33 -0400
Subject: Re: [RFC v5 12/38] mm: ability to disable execute permission on a key
 at creation
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-13-git-send-email-linuxram@us.ibm.com>
 <3bd2ffd4-33ad-ce23-3db1-d1292e69ca9b@intel.com>
 <1499808577.2865.30.camel@kernel.crashing.org>
 <20170711215105.GA5542@ram.oc3035372033.ibm.com>
 <3bdd9083-ef2a-d1da-802c-c6822cf818b3@intel.com>
 <20170711221434.GB5542@ram.oc3035372033.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <9fbe72be-453f-57e2-861e-5d35fbe95c41@intel.com>
Date: Tue, 11 Jul 2017 15:19:31 -0700
MIME-Version: 1.0
In-Reply-To: <20170711221434.GB5542@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-arch@vger.kernel.org, corbet@lwn.net, arnd@arndb.de, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, linux-kselftest@vger.kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
Message-ID: <20170711221931.ddzfn1VKYZ8j3fXxokSJnCFiXV27XFCvCYUP6-TzxHs@z>

On 07/11/2017 03:14 PM, Ram Pai wrote:
> Now how many does the kernel use to reserve for itself is something
> the kernel knows too and hence can expose it, though the information
> may change dynamically as the kernel reserves and releases the key
> based on its internal needs. 
> 
> So i think we can expose this informaton through procfs/sysfs and let
> the application decide how it wants to use the information.

Why bother?  On x86, you'll be told either 14 or 15 depending on whether
you tried to create a mapping in the process without execute permission.
 You can't use all 14 or 15 unless you actually call pkey_alloc() anyway
because the /proc check is inherently racy.

I'm just not sure I see the value in creating a new ABI for it.
